From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 29/31] Universal GUI for specifications edition: RefSpecPanel and related
Date: Sun, 17 Aug 2008 22:44:10 +0200
Message-ID: <1219005852-21496-30-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-14-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-15-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-16-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-17-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-18-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-19-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-20-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-21-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-22-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-23-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-24-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-25-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-26-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-27-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-28-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-29-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:48:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUpAL-0003WL-AR
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594AbYHQUqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbYHQUqQ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:46:16 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849AbYHQUqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:46:11 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RM8P/b0el0YaXi4sdlP1M0dEBG4pzIOhQZQIABf+gGI=;
        b=ptMkyZjoifrFUiR1CIyVvN2e6AxybgJ6XGs4kiiUGJ6bpZBh2mAmCN6rctgxOIHn5T
         398JqDmhvtIlBtbYWPvcn3i8TJJS6tn+GkFqoueFVdYtFB3CMs9d8Rh6tfUiVBlmCPqe
         BSGQbDh8BMy71vSwOWiqC8HJj/QSy1FJ1sXbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Bd0BTUkw+LlgDfPov8+cQHIvIXLqTgwbEeTD5WpV+XA+habrHxLsjgidtrSf71eyzx
         Nr2DCfKKkeiq0IcwjDIcRI+Qu+rDkeK0NuKArZS9b3o6+kOYm1v4HNRwmjzw8YyUd+yF
         04DMjTsINtpxjXObM3w+iW/Ys7c12Zl5UvnCk=
Received: by 10.103.1.5 with SMTP id d5mr3469007mui.99.1219005968693;
        Sun, 17 Aug 2008 13:46:08 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id j2sm2159473mue.4.2008.08.17.13.46.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:46:06 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-29-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92660>

RefSpecPanel provides universal GUI (Control) for editing list of RefSpec
specifications for both push or fetch, depending on panel configuration.

It is intended to allow user easily edit specifications, supporting user
with rich content assistant and giving feedback with error information as
soon as possible. Component uses editable specifications table and panels
for easy creation of new specifications basing on typical push/fetch
schemes (like branch update, deletion, all branches update, saved
configuration etc.).

Possibly there are still some places when this panel usability could be
improved by some UI-engineer. I hope it shouldn't be very hard and panel
core and API should resist such changes. Keyboard handling could be
improved perhaps, some bugs are still open for MacOS, with one critical
reported to bugzilla.

RefSpecPage class is fetch/push WizardPage using RefSpecPanel extensively.

Beside of RefSpecPanel class this commit introduces some components needed
to build this one. As these components as potentially reusable, they are
put in components package and declared as public.

Influenced-by-smart-comments-of: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |  207 +++
 .../components/CenteredImageLabelProvider.java     |   52 +
 .../internal/components/CheckboxLabelProvider.java |  138 ++
 .../internal/components/ClickableCellEditor.java   |   68 +
 .../internal/components/ComboLabelingSupport.java  |   77 +
 .../ui/internal/components/RefContentProposal.java |  140 ++
 .../egit/ui/internal/components/RefSpecPage.java   |  237 +++
 .../egit/ui/internal/components/RefSpecPanel.java  | 1823 ++++++++++++++++++++
 .../src/org/spearce/egit/ui/uitext.properties      |   71 +
 9 files changed, 2813 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/CenteredImageLabelProvider.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/CheckboxLabelProvider.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/ClickableCellEditor.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/ComboLabelingSupport.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefContentProposal.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 9b290f3..ff2b541 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -176,6 +176,213 @@ public class UIText extends NLS {
 	public static String CloneDestinationPage_errorNotEmptyDir;
 
 	/** */
+	public static String RefSpecPanel_refChooseSome;
+
+	/** */
+	public static String RefSpecPanel_refChooseSomeWildcard;
+
+	/** */
+	public static String RefSpecPanel_clickToChange;
+
+	/** */
+	public static String RefSpecPanel_columnDst;
+
+	/** */
+	public static String RefSpecPanel_columnForce;
+
+	/** */
+	public static String RefSpecPanel_columnMode;
+
+	/** */
+	public static String RefSpecPanel_columnRemove;
+
+	/** */
+	public static String RefSpecPanel_columnSrc;
+
+	/** */
+	public static String RefSpecPanel_creationButton;
+
+	/** */
+	public static String RefSpecPanel_creationButtonDescription;
+
+	/** */
+	public static String RefSpecPanel_creationDst;
+
+	/** */
+	public static String RefSpecPanel_creationGroup;
+
+	/** */
+	public static String RefSpecPanel_creationSrc;
+
+	/** */
+	public static String RefSpecPanel_deletionButton;
+
+	/** */
+	public static String RefSpecPanel_deletionButtonDescription;
+
+	/** */
+	public static String RefSpecPanel_deletionGroup;
+
+	/** */
+	public static String RefSpecPanel_deletionRef;
+
+	/** */
+	public static String RefSpecPanel_dstDeletionDescription;
+
+	/** */
+	public static String RefSpecPanel_dstFetchDescription;
+
+	/** */
+	public static String RefSpecPanel_dstPushDescription;
+
+	/** */
+	public static String RefSpecPanel_errorRemoteConfigDescription;
+
+	/** */
+	public static String RefSpecPanel_errorRemoteConfigTitle;
+
+	/** */
+	public static String RefSpecPanel_fetch;
+
+	/** */
+	public static String RefSpecPanel_srcFetchDescription;
+
+	/** */
+	public static String RefSpecPanel_forceAll;
+
+	/** */
+	public static String RefSpecPanel_forceAllDescription;
+
+	/** */
+	public static String RefSpecPanel_forceDeleteDescription;
+
+	/** */
+	public static String RefSpecPanel_forceFalseDescription;
+
+	/** */
+	public static String RefSpecPanel_forceTrueDescription;
+
+	/** */
+	public static String RefSpecPanel_modeDelete;
+
+	/** */
+	public static String RefSpecPanel_modeDeleteDescription;
+
+	/** */
+	public static String RefSpecPanel_modeUpdate;
+
+	/** */
+	public static String RefSpecPanel_modeUpdateDescription;
+
+	/** */
+	public static String RefSpecPanel_predefinedAll;
+
+	/** */
+	public static String RefSpecPanel_predefinedAllDescription;
+
+	/** */
+	public static String RefSpecPanel_predefinedConfigured;
+
+	/** */
+	public static String RefSpecPanel_predefinedConfiguredDescription;
+
+	/** */
+	public static String RefSpecPanel_predefinedGroup;
+
+	/** */
+	public static String RefSpecPanel_predefinedTags;
+
+	/** */
+	public static String RefSpecPanel_predefinedTagsDescription;
+
+	/** */
+	public static String RefSpecPanel_push;
+
+	/** */
+	public static String RefSpecPanel_srcPushDescription;
+
+	/** */
+	public static String RefSpecPanel_removeAll;
+
+	/** */
+	public static String RefSpecPanel_removeAllDescription;
+
+	/** */
+	public static String RefSpecPanel_removeDescription;
+
+	/** */
+	public static String RefSpecPanel_specifications;
+
+	/** */
+	public static String RefSpecPanel_srcDeleteDescription;
+
+	/** */
+	public static String RefSpecPanel_validationDstInvalidExpression;
+
+	/** */
+	public static String RefSpecPanel_validationDstRequired;
+
+	/** */
+	public static String RefSpecPanel_validationRefDeleteRequired;
+
+	/** */
+	public static String RefSpecPanel_validationRefDeleteWildcard;
+
+	/** */
+	public static String RefSpecPanel_validationRefInvalidExpression;
+
+	/** */
+	public static String RefSpecPanel_validationRefInvalidLocal;
+
+	/** */
+	public static String RefSpecPanel_validationRefNonExistingRemote;
+
+	/** */
+	public static String RefSpecPanel_validationRefNonExistingRemoteDelete;
+
+	/** */
+	public static String RefSpecPanel_validationRefNonMatchingLocal;
+
+	/** */
+	public static String RefSpecPanel_validationRefNonMatchingRemote;
+
+	/** */
+	public static String RefSpecPanel_validationSpecificationsOverlappingDestination;
+
+	/** */
+	public static String RefSpecPanel_validationSrcUpdateRequired;
+
+	/** */
+	public static String RefSpecPanel_validationWildcardInconsistent;
+
+	/** */
+	public static String RefSpecPage_descriptionFetch;
+
+	/** */
+	public static String RefSpecPage_descriptionPush;
+
+	/** */
+	public static String RefSpecPage_errorDontMatchSrc;
+
+	/** */
+	public static String RefSpecPage_errorTransportDialogMessage;
+
+	/** */
+	public static String RefSpecPage_errorTransportDialogTitle;
+
+	/** */
+	public static String RefSpecPage_operationCancelled;
+
+	/** */
+	public static String RefSpecPage_saveSpecifications;
+
+	/** */
+	public static String RefSpecPage_titleFetch;
+
+	/** */
+	public static String RefSpecPage_titlePush;
+
+	/** */
 	public static String Decorator_failedLazyLoading;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/CenteredImageLabelProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/CenteredImageLabelProvider.java
new file mode 100644
index 0000000..8752a60
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/CenteredImageLabelProvider.java
@@ -0,0 +1,52 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.components;
+
+import org.eclipse.jface.viewers.OwnerDrawLabelProvider;
+import org.eclipse.swt.graphics.Image;
+import org.eclipse.swt.graphics.Rectangle;
+import org.eclipse.swt.widgets.Event;
+import org.eclipse.swt.widgets.TableItem;
+
+/**
+ * Label provider displaying image centered.
+ * <p>
+ * This implementation is actually workaround for lacking SWT/JFace features.
+ * Code is based on official snippet found on Internet.
+ */
+// FIXME: doesn't work on Mac OS X 10.5 / Eclipse 3.3
+public abstract class CenteredImageLabelProvider extends OwnerDrawLabelProvider {
+	/**
+	 * @param element
+	 *            element to provide label for.
+	 * @return image for provided element.
+	 */
+	protected abstract Image getImage(final Object element);
+
+	@Override
+	protected void measure(Event event, Object element) {
+		// empty
+	}
+
+	@Override
+	protected void paint(final Event event, final Object element) {
+		final Image image = getImage(element);
+		final Rectangle bounds = ((TableItem) event.item)
+				.getBounds(event.index);
+		final Rectangle imgBounds = image.getBounds();
+		bounds.width /= 2;
+		bounds.width -= imgBounds.width / 2;
+		bounds.height /= 2;
+		bounds.height -= imgBounds.height / 2;
+
+		final int x = bounds.width > 0 ? bounds.x + bounds.width : bounds.x;
+		final int y = bounds.height > 0 ? bounds.y + bounds.height : bounds.y;
+
+		event.gc.drawImage(image, x, y);
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/CheckboxLabelProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/CheckboxLabelProvider.java
new file mode 100644
index 0000000..2222afc
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/CheckboxLabelProvider.java
@@ -0,0 +1,138 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.components;
+
+import org.eclipse.swt.graphics.Image;
+import org.eclipse.swt.widgets.Control;
+import org.spearce.egit.ui.UIIcons;
+
+/**
+ * Label provider displaying native check boxes images for boolean values.
+ * Label-image is centralized.
+ * <p>
+ * Concrete implementations must provide object to boolean mapping.
+ * <p>
+ * This implementation is actually workaround for lacking features in
+ * TableViewer. It is based on (workaround) snippets&tricks found on Internet.
+ */
+public abstract class CheckboxLabelProvider extends CenteredImageLabelProvider {
+	private static Image createCheckboxImage(final Control control,
+			boolean checked, boolean enabled) {
+		// Temporary workaround?
+		if (enabled) {
+			if (checked)
+				return UIIcons.CHECKBOX_ENABLED_CHECKED.createImage();
+			return UIIcons.CHECKBOX_ENABLED_UNCHECKED.createImage();
+		}
+		if (checked)
+			return UIIcons.CHECKBOX_DISABLED_CHECKED.createImage();
+		return UIIcons.CHECKBOX_DISABLED_UNCHECKED.createImage();
+		
+		// FIXME: Shawn says that blinking shell caused by below code is very
+		// annoying...(at least on Mac) - anyone knows better workaround?
+		// final Shell s = new Shell(control.getShell(), SWT.NO_TRIM);
+		// // Hopefully no platform uses exactly this color because we'll make
+		// // it transparent in the image.
+		// final Color greenScreen = new Color(control.getDisplay(), 222, 223,
+		// 224);
+		//
+		// // otherwise we have a default gray color
+		// s.setBackground(greenScreen);
+		//
+		// final Button b = new Button(s, SWT.CHECK);
+		// b.setSelection(checked);
+		// b.setEnabled(enabled);
+		// b.setBackground(greenScreen);
+		//
+		// // otherwise an image is located in a corner
+		// b.setLocation(0, 0);
+		// final Point bSize = b.computeSize(SWT.DEFAULT, SWT.DEFAULT);
+		// // otherwise an image is stretched by width
+		// bSize.x = Math.max(bSize.x, bSize.y);
+		// bSize.y = Math.max(bSize.x, bSize.y);
+		// b.setSize(bSize);
+		// s.setSize(bSize);
+		// s.open();
+		//
+		// final GC gc = new GC(b);
+		// final Image image = new Image(control.getShell().getDisplay(),
+		// bSize.x,
+		// bSize.y);
+		// gc.copyArea(image, 0, 0);
+		// gc.dispose();
+		// s.close();
+		//
+		// final ImageData imageData = image.getImageData();
+		// imageData.transparentPixel = imageData.palette.getPixel(greenScreen
+		// .getRGB());
+		// return new Image(control.getDisplay(), imageData);
+	}
+
+	private final Image imageCheckedEnabled;
+
+	private final Image imageUncheckedEnabled;
+
+	private final Image imageCheckedDisabled;
+
+	private final Image imageUncheckedDisabled;
+
+	/**
+	 * Create label provider for provided viewer.
+	 * 
+	 * @param control
+	 *            viewer where label provided is used.
+	 */
+	public CheckboxLabelProvider(final Control control) {
+		imageCheckedEnabled = createCheckboxImage(control, true, true);
+		imageUncheckedEnabled = createCheckboxImage(control, false, true);
+		imageCheckedDisabled = createCheckboxImage(control, true, false);
+		imageUncheckedDisabled = createCheckboxImage(control, false, false);
+	}
+
+	@Override
+	public void dispose() {
+		super.dispose();
+		imageCheckedEnabled.dispose();
+		imageUncheckedEnabled.dispose();
+		imageCheckedDisabled.dispose();
+		imageUncheckedDisabled.dispose();
+	}
+
+	@Override
+	protected Image getImage(final Object element) {
+		if (isEnabled(element)) {
+			if (isChecked(element))
+				return imageCheckedEnabled;
+			return imageUncheckedEnabled;
+		} else {
+			if (isChecked(element))
+				return imageCheckedDisabled;
+			return imageUncheckedDisabled;
+		}
+	}
+
+	/**
+	 * @param element
+	 *            element to provide label for.
+	 * @return true if checkbox label should be checked for this element, false
+	 *         otherwise.
+	 */
+	protected abstract boolean isChecked(Object element);
+
+	/**
+	 * Default implementation always return true.
+	 * 
+	 * @param element
+	 *            element to provide label for.
+	 * @return true if checkbox label should be enabled for this element, false
+	 *         otherwise.
+	 */
+	protected boolean isEnabled(final Object element) {
+		return true;
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/ClickableCellEditor.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/ClickableCellEditor.java
new file mode 100644
index 0000000..af4cb86
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/ClickableCellEditor.java
@@ -0,0 +1,68 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.components;
+
+import org.eclipse.jface.viewers.CellEditor;
+import org.eclipse.jface.viewers.ColumnViewerEditorActivationEvent;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Control;
+import org.eclipse.swt.widgets.Table;
+
+/**
+ * Workaround class allowing usage of clickable element as a TableViewer cell,
+ * acting as button.
+ * <p>
+ * setValue method of EditingSupport is called on cell click, with this cell
+ * editor configured.
+ * 
+ */
+public class ClickableCellEditor extends CellEditor {
+
+	/**
+	 * Create cell editor for provided table.
+	 * 
+	 * @param table
+	 *            the parent table.
+	 */
+	public ClickableCellEditor(final Table table) {
+		super(table, SWT.NONE);
+	}
+
+	@Override
+	protected Control createControl(Composite parent) {
+		return null;
+	}
+
+	@Override
+	protected Object doGetValue() {
+		return null;
+	}
+
+	@Override
+	protected void doSetFocus() {
+		// nothing to do
+	}
+
+	@Override
+	protected void doSetValue(Object value) {
+		// nothing to do
+	}
+
+	@Override
+	public void activate() {
+		// just force setValue on editing support
+		fireApplyEditorValue();
+	}
+
+	public void activate(ColumnViewerEditorActivationEvent activationEvent) {
+		if (activationEvent.eventType != ColumnViewerEditorActivationEvent.TRAVERSAL) {
+			super.activate(activationEvent);
+		}
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/ComboLabelingSupport.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/ComboLabelingSupport.java
new file mode 100644
index 0000000..724c570
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/ComboLabelingSupport.java
@@ -0,0 +1,77 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.components;
+
+import java.util.Collections;
+import java.util.List;
+
+import org.eclipse.jface.fieldassist.IContentProposal;
+import org.eclipse.swt.events.SelectionAdapter;
+import org.eclipse.swt.events.SelectionEvent;
+import org.eclipse.swt.events.SelectionListener;
+import org.eclipse.swt.widgets.Combo;
+
+/**
+ * Support class for Combo, extending its functionality to differentiate between
+ * item label and item content.
+ * <p>
+ * This implementation takes {@link IContentProposal} instances as data source.
+ */
+public class ComboLabelingSupport {
+	private final Combo combo;
+
+	private List<? extends IContentProposal> proposals;
+
+	/**
+	 * Installs labeling support on provided combo. setItems method of combo
+	 * shouldn't be called manually after that installation.
+	 * <p>
+	 * Support class is initialized with empty proposals list.
+	 * 
+	 * @param combo
+	 *            target combo to install on.
+	 * @param selectionListener
+	 *            listener that is notified when content is filled after label
+	 *            being clicked. May be null.
+	 */
+	public ComboLabelingSupport(final Combo combo,
+			final SelectionListener selectionListener) {
+		this.combo = combo;
+
+		combo.addSelectionListener(new SelectionAdapter() {
+			@Override
+			public void widgetSelected(SelectionEvent e) {
+				final int i = combo.getSelectionIndex();
+				if (i != -1 && i < proposals.size()) {
+					combo.setText(proposals.get(i).getContent());
+					if (selectionListener != null)
+						selectionListener.widgetSelected(e);
+				}
+			}
+		});
+		setProposals(Collections.<IContentProposal> emptyList());
+	}
+
+	/**
+	 * Sets input data for combo.
+	 * <p>
+	 * Proposals are set in provided order.
+	 * 
+	 * @param proposals
+	 *            model of input data.
+	 */
+	public void setProposals(final List<? extends IContentProposal> proposals) {
+		this.proposals = proposals;
+
+		final String[] itemsLabels = new String[proposals.size()];
+		int i = 0;
+		for (final IContentProposal p : proposals)
+			itemsLabels[i++] = p.getLabel();
+		combo.setItems(itemsLabels);
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefContentProposal.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefContentProposal.java
new file mode 100644
index 0000000..feeac26
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefContentProposal.java
@@ -0,0 +1,140 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.components;
+
+import java.io.IOException;
+import java.sql.Blob;
+
+import org.eclipse.jface.fieldassist.IContentProposal;
+import org.spearce.egit.ui.Activator;
+import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PersonIdent;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.Tag;
+import org.spearce.jgit.lib.Tree;
+
+/**
+ * Content proposal class for refs names, specifically Ref objects - name with
+ * optionally associated object id. This class can be used for Eclipse field
+ * assist as content proposal.
+ * <p>
+ * Content of this proposal is simply a ref name, but description and labels
+ * tries to be smarter - showing easier to read label for user (stripping
+ * prefixes) and information about pointed object if it exists locally.
+ */
+public class RefContentProposal implements IContentProposal {
+	private static final String PREFIXES[] = new String[] {
+			Constants.HEADS_PREFIX + "/", Constants.REMOTES_PREFIX + "/",
+			Constants.TAGS_PREFIX + "/" };
+
+	private static final String PREFIXES_DESCRIPTIONS[] = new String[] {
+			" [branch]", " [tracking branch]", " [tag]" };
+
+	private static void appendObjectSummary(final StringBuilder sb,
+			final String type, final PersonIdent author, final String message) {
+		sb.append(type + " by ");
+		sb.append(author.getName());
+		sb.append("\n");
+		sb.append(author.getWhen());
+		sb.append("\n\n");
+		final int newLine = message.indexOf('\n');
+		final int last = (newLine != -1 ? newLine : message.length());
+		sb.append(message.substring(0, last));
+	}
+
+	private final Repository db;
+
+	private final String refName;
+
+	private final ObjectId objectId;
+
+	/**
+	 * Create content proposal for specified ref.
+	 * 
+	 * @param repo
+	 *            repository for accessing information about objects. Could be a
+	 *            local repository even for remote objects.
+	 * @param ref
+	 *            ref being a content proposal. May have null or locally
+	 *            non-existent object id.
+	 */
+	public RefContentProposal(final Repository repo, final Ref ref) {
+		this(repo, ref.getName(), ref.getObjectId());
+	}
+
+	/**
+	 * Create content proposal for specified ref name and object id.
+	 * 
+	 * @param repo
+	 *            repository for accessing information about objects. Could be a
+	 *            local repository even for remote objects.
+	 * @param refName
+	 *            ref name being a content proposal.
+	 * @param objectId
+	 *            object being pointed by this ref name. May be null or locally
+	 *            non-existent object.
+	 */
+	public RefContentProposal(final Repository repo, final String refName,
+			final ObjectId objectId) {
+		this.db = repo;
+		this.refName = refName;
+		this.objectId = objectId;
+	}
+
+	public String getContent() {
+		return refName;
+	}
+
+	public int getCursorPosition() {
+		return refName.length();
+	}
+
+	public String getDescription() {
+		if (objectId == null)
+			return null;
+		final Object obj;
+		try {
+			obj = db.mapObject(objectId, refName);
+		} catch (IOException e) {
+			Activator.logError("Unable to read object " + objectId
+					+ " for content proposal assistance", e);
+			return null;
+		}
+
+		final StringBuilder sb = new StringBuilder();
+		sb.append(refName);
+		sb.append('\n');
+		sb.append(objectId.abbreviate(db));
+		sb.append(" - ");
+		if (obj instanceof Commit) {
+			final Commit c = ((Commit) obj);
+			appendObjectSummary(sb, "commit", c.getAuthor(), c.getMessage());
+		} else if (obj instanceof Tag) {
+			final Tag t = ((Tag) obj);
+			appendObjectSummary(sb, "tag", t.getAuthor(), t.getMessage());
+		} else if (obj instanceof Tree) {
+			sb.append("tree");
+		} else if (obj instanceof Blob) {
+			sb.append("blob");
+		} else
+			sb.append("locally unknown object");
+		return sb.toString();
+	}
+
+	public String getLabel() {
+		for (int i = 0; i < PREFIXES.length; i++)
+			if (refName.startsWith(PREFIXES[i]))
+				return refName.substring(PREFIXES[i].length())
+						+ PREFIXES_DESCRIPTIONS[i];
+		return refName;
+
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java
new file mode 100644
index 0000000..4471e24
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java
@@ -0,0 +1,237 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.components;
+
+import java.lang.reflect.InvocationTargetException;
+import java.util.ArrayList;
+import java.util.Collections;
+import java.util.List;
+
+import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.Status;
+import org.eclipse.jface.dialogs.ErrorDialog;
+import org.eclipse.osgi.util.NLS;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.events.SelectionAdapter;
+import org.eclipse.swt.events.SelectionEvent;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.layout.GridLayout;
+import org.eclipse.swt.widgets.Button;
+import org.eclipse.swt.widgets.Composite;
+import org.spearce.egit.core.op.ListRemoteOperation;
+import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIText;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.transport.RefSpec;
+import org.spearce.jgit.transport.URIish;
+
+/**
+ * This wizard page allows user easy selection of specifications for push or
+ * fetch (configurable).
+ * <p>
+ * Page is relying highly on {@link RefSpecPanel} component, see its description
+ * for details.
+ * <p>
+ * Page is designed to be successor of {@link RepositorySelectionPage} in
+ * wizard.
+ */
+public class RefSpecPage extends BaseWizardPage {
+
+	private final Repository local;
+
+	private final RepositorySelectionPage repoPage;
+
+	private final boolean pushPage;
+
+	private RepositorySelection validatedRepoSelection;
+
+	private RefSpecPanel specsPanel;
+
+	private Button saveButton;
+
+	private String transportError;
+
+	/**
+	 * Create specifications selection page for provided context.
+	 * 
+	 * @param local
+	 *            local repository.
+	 * @param pushPage
+	 *            true if this page is used for push specifications selection,
+	 *            false if it used for fetch specifications selection.
+	 * @param repoPage
+	 *            repository selection page - must be predecessor of this page
+	 *            in wizard.
+	 */
+	public RefSpecPage(final Repository local, final boolean pushPage,
+			final RepositorySelectionPage repoPage) {
+		super(RefSpecPage.class.getName());
+		this.local = local;
+		this.repoPage = repoPage;
+		this.pushPage = pushPage;
+		if (pushPage) {
+			setTitle(UIText.RefSpecPage_titlePush);
+			setDescription(UIText.RefSpecPage_descriptionPush);
+		} else {
+			setTitle(UIText.RefSpecPage_titleFetch);
+			setDescription(UIText.RefSpecPage_descriptionFetch);
+		}
+
+		repoPage.addSelectionListener(new SelectionChangeListener() {
+			public void selectionChanged() {
+				if (!repoPage.selectionEquals(validatedRepoSelection))
+					setPageComplete(false);
+				else
+					checkPage();
+			}
+		});
+	}
+
+	public void createControl(Composite parent) {
+		final Composite panel = new Composite(parent, SWT.NULL);
+		panel.setLayout(new GridLayout());
+
+		specsPanel = new RefSpecPanel(panel, pushPage);
+		specsPanel.getControl().setLayoutData(
+				new GridData(SWT.FILL, SWT.FILL, true, true));
+		specsPanel.addRefSpecTableListener(new SelectionChangeListener() {
+			public void selectionChanged() {
+				notifySelectionChanged();
+				checkPage();
+			}
+		});
+
+		saveButton = new Button(panel, SWT.CHECK);
+		saveButton.setLayoutData(new GridData(SWT.LEFT, SWT.FILL, true, false));
+		saveButton.addSelectionListener(new SelectionAdapter() {
+			@Override
+			public void widgetSelected(SelectionEvent e) {
+				notifySelectionChanged();
+			}
+		});
+
+		setControl(panel);
+		notifySelectionChanged();
+		checkPage();
+	}
+
+	@Override
+	public void setVisible(final boolean visible) {
+		if (visible)
+			revalidate();
+		super.setVisible(visible);
+	}
+
+	/**
+	 * @return ref specifications as selected by user. Returned collection is a
+	 *         copy, so it may be modified by caller.
+	 */
+	public List<RefSpec> getRefSpecs() {
+		if (specsPanel == null)
+			return Collections.emptyList();
+		else
+			return new ArrayList<RefSpec>(specsPanel.getRefSpecs());
+	}
+
+	/**
+	 * @return true if user chosen to save selected specification in remote
+	 *         configuration, false otherwise.
+	 */
+	public boolean isSaveRequested() {
+		return saveButton.getSelection();
+	}
+
+	/**
+	 * Compare provided specifications to currently selected ones.
+	 * 
+	 * @param specs
+	 *            specifications to compare to. May be null.
+	 * @return true if provided specifications are equal to currently selected
+	 *         ones, false otherwise.
+	 */
+	public boolean specsSelectionEquals(final List<RefSpec> specs) {
+		return getRefSpecs().equals(specs);
+	}
+
+	private void revalidate() {
+		final RepositorySelection newRepoSelection = repoPage.getSelection();
+
+		if (repoPage.selectionEquals(validatedRepoSelection)) {
+			// nothing changed on previous page
+			checkPage();
+			return;
+		}
+
+		specsPanel.clearRefSpecs();
+		specsPanel.setEnable(false);
+		saveButton.setVisible(false);
+		saveButton.setSelection(false);
+		notifySelectionChanged();
+		validatedRepoSelection = null;
+		transportError = null;
+		getControl().getDisplay().asyncExec(new Runnable() {
+			public void run() {
+				revalidateImpl(newRepoSelection);
+			}
+		});
+	}
+
+	private void revalidateImpl(final RepositorySelection newRepoSelection) {
+		final ListRemoteOperation listRemotesOp;
+		try {
+			final URIish uri;
+			uri = newRepoSelection.getURI();
+			listRemotesOp = new ListRemoteOperation(local, uri);
+			getContainer().run(true, true, listRemotesOp);
+		} catch (InvocationTargetException e) {
+			final Throwable cause = e.getCause();
+			transportError(cause.getMessage());
+			ErrorDialog.openError(getShell(), UIText.RefSpecPage_errorTransportDialogTitle,
+					UIText.RefSpecPage_errorTransportDialogMessage, new Status(
+							IStatus.ERROR, Activator.getPluginId(), 0, cause
+									.getMessage(), cause));
+			return;
+		} catch (InterruptedException e) {
+			transportError(UIText.RefSpecPage_operationCancelled);
+			return;
+		}
+
+		this.validatedRepoSelection = newRepoSelection;
+		final String remoteName = validatedRepoSelection.getConfigName();
+		specsPanel.setAssistanceData(local, listRemotesOp.getRemoteRefs(),
+				remoteName);
+		if (newRepoSelection.isConfigSelected()) {
+			saveButton.setVisible(true);
+			saveButton.setText(NLS.bind(UIText.RefSpecPage_saveSpecifications,
+					remoteName));
+			saveButton.pack();
+		}
+		checkPage();
+	}
+
+	private void transportError(final String message) {
+		transportError = message;
+		checkPage();
+	}
+
+	private void checkPage() {
+		if (transportError != null) {
+			setErrorMessage(transportError);
+			setPageComplete(false);
+			return;
+		}
+		if (!specsPanel.isEmpty() && specsPanel.isValid()
+				&& !specsPanel.isMatchingAnyRefs()) {
+			setErrorMessage(UIText.RefSpecPage_errorDontMatchSrc);
+			setPageComplete(false);
+			return;
+		}
+		setErrorMessage(specsPanel.getErrorMessage());
+		setPageComplete(!specsPanel.isEmpty() && specsPanel.isValid());
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
new file mode 100644
index 0000000..caef4d2
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
@@ -0,0 +1,1823 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.components;
+
+import java.io.IOException;
+import java.net.URISyntaxException;
+import java.util.ArrayList;
+import java.util.Collection;
+import java.util.Collections;
+import java.util.Comparator;
+import java.util.HashMap;
+import java.util.HashSet;
+import java.util.LinkedList;
+import java.util.List;
+import java.util.Map;
+import java.util.Set;
+import java.util.TreeSet;
+import java.util.regex.Pattern;
+
+import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.Status;
+import org.eclipse.jface.dialogs.ErrorDialog;
+import org.eclipse.jface.fieldassist.ComboContentAdapter;
+import org.eclipse.jface.fieldassist.ContentProposalAdapter;
+import org.eclipse.jface.fieldassist.ControlDecoration;
+import org.eclipse.jface.fieldassist.FieldDecorationRegistry;
+import org.eclipse.jface.fieldassist.IContentProposal;
+import org.eclipse.jface.fieldassist.IContentProposalListener;
+import org.eclipse.jface.fieldassist.IContentProposalProvider;
+import org.eclipse.jface.fieldassist.TextContentAdapter;
+import org.eclipse.jface.layout.TableColumnLayout;
+import org.eclipse.jface.resource.ImageRegistry;
+import org.eclipse.jface.viewers.CellEditor;
+import org.eclipse.jface.viewers.CheckboxCellEditor;
+import org.eclipse.jface.viewers.ColumnLabelProvider;
+import org.eclipse.jface.viewers.ColumnViewerToolTipSupport;
+import org.eclipse.jface.viewers.ColumnWeightData;
+import org.eclipse.jface.viewers.EditingSupport;
+import org.eclipse.jface.viewers.IElementComparer;
+import org.eclipse.jface.viewers.IStructuredContentProvider;
+import org.eclipse.jface.viewers.TableViewer;
+import org.eclipse.jface.viewers.TableViewerColumn;
+import org.eclipse.jface.viewers.TextCellEditor;
+import org.eclipse.jface.viewers.Viewer;
+import org.eclipse.osgi.util.NLS;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.events.DisposeEvent;
+import org.eclipse.swt.events.DisposeListener;
+import org.eclipse.swt.events.ModifyEvent;
+import org.eclipse.swt.events.ModifyListener;
+import org.eclipse.swt.events.SelectionAdapter;
+import org.eclipse.swt.events.SelectionEvent;
+import org.eclipse.swt.events.TraverseEvent;
+import org.eclipse.swt.events.TraverseListener;
+import org.eclipse.swt.graphics.Color;
+import org.eclipse.swt.graphics.Image;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.layout.GridLayout;
+import org.eclipse.swt.layout.RowLayout;
+import org.eclipse.swt.widgets.Button;
+import org.eclipse.swt.widgets.Combo;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Control;
+import org.eclipse.swt.widgets.Group;
+import org.eclipse.swt.widgets.Label;
+import org.eclipse.swt.widgets.Table;
+import org.eclipse.swt.widgets.TableColumn;
+import org.eclipse.swt.widgets.Text;
+import org.eclipse.ui.fieldassist.ContentAssistCommandAdapter;
+import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIIcons;
+import org.spearce.egit.ui.UIText;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.Ref.Storage;
+import org.spearce.jgit.transport.FetchConnection;
+import org.spearce.jgit.transport.RefSpec;
+import org.spearce.jgit.transport.RemoteConfig;
+import org.spearce.jgit.transport.Transport;
+
+/**
+ * This class provides universal panel for editing list of {@link RefSpec} -
+ * specifications for both push or fetch, depending on panel configuration.
+ * <p>
+ * It is intended to allow user easily edit specifications, supporting user with
+ * content assistant and giving feedback with error information as soon as
+ * possible. Component uses editable specifications table and panels for easy
+ * creation of new specifications basing on typical push/fetch schemes (like
+ * branch update, deletion, all branches update, saved configuration etc.).
+ * <p>
+ * The model of specifications list behind panel is accessible by public methods
+ * - giving both read and write access. Listener interface for handling changes
+ * in model is provided by {@link SelectionChangeListener}.
+ * <p>
+ * Typical class usage:
+ * 
+ * <pre>
+ * // create panel for editing push-specifications
+ * RefSpecPanel panel = new RefSpecPanel(parent, true);
+ * // register model listener
+ * panel.addRefSpecPanelListener(listener);
+ * 
+ * // provide information about local and remote refs
+ * panel.setRefsData(localRepo, remoteRefs, remoteName);
+ * 
+ * // get result data 
+ * List&lt;RefSpec&gt; result = panel.getRefSpecs();
+ * // further processing: push or save configuration...
+ * </pre>
+ * 
+ * @see SelectionChangeListener
+ */
+public class RefSpecPanel {
+	private static final String REMOTES_PREFIX_S = Constants.REMOTES_PREFIX + '/';
+
+	private static final String HEADS_PREFIX_S = Constants.HEADS_PREFIX + '/';
+
+	private static final String IMAGE_ADD = "ADD"; //$NON-NLS-1$
+
+	private static final String IMAGE_DELETE = "DELETE"; //$NON-NLS-1$
+
+	private static final String IMAGE_TRASH = "TRASH"; //$NON-NLS-1$
+
+	private static final String IMAGE_CLEAR = "CLEAR"; //$NON-NLS-1$
+
+	private static final int TABLE_PREFERRED_HEIGHT = 165;
+
+	private static final int TABLE_PREFERRED_WIDTH = 560;
+
+	private static final int COLUMN_MODE_WEIGHT = 23;
+
+	private static final int COLUMN_SRC_WEIGHT = 40;
+
+	private static final int COLUMN_DST_WEIGHT = 40;
+
+	private static final int COLUMN_FORCE_WEIGHT = 30;
+
+	private static final int COLUMN_REMOVE_WEIGHT = 20;
+
+	private static boolean isDeleteRefSpec(final Object element) {
+		return ((RefSpec) element).getSource() == null;
+	}
+
+	private static boolean isValidRefExpression(final String s) {
+		if (RefSpec.isWildcard(s)) {
+			// replace wildcard with some legal name just for checking
+			return Repository
+					.isValidRefName(s.substring(0, s.length() - 1) + 'X');
+		} else
+			return Repository.isValidRefName(s);
+	}
+
+	private static RefSpec setRefSpecSource(final RefSpec spec, final String src) {
+		final String dst;
+		if (RefSpec.isWildcard(src))
+			dst = wildcardSpecComponent(spec.getDestination());
+		else
+			dst = unwildcardSpecComponent(spec.getDestination(), src);
+		return spec.setSourceDestination(src, dst);
+	}
+
+	private static RefSpec setRefSpecDestination(final RefSpec spec,
+			final String dst) {
+		final String src;
+		if (RefSpec.isWildcard(dst))
+			src = wildcardSpecComponent(spec.getSource());
+		else
+			src = unwildcardSpecComponent(spec.getSource(), dst);
+		return spec.setSourceDestination(src, dst);
+	}
+
+	private static String wildcardSpecComponent(final String comp) {
+		final int i;
+		if (RefSpec.isWildcard(comp))
+			return comp;
+		if (comp == null || (i = comp.lastIndexOf('/')) == -1) {
+			// That's somewhat ugly. What better can we do here?
+			return UIText.RefSpecPanel_refChooseSomeWildcard;
+		}
+		return comp.substring(0, i + 1) + '*';
+	}
+
+	private static String unwildcardSpecComponent(final String comp,
+			final String other) {
+		if (!RefSpec.isWildcard(comp))
+			return comp;
+		if (other == null || other.length() == 0)
+			return ""; //$NON-NLS-1$
+		final int i = other.lastIndexOf('/');
+		return comp.substring(0, comp.length() - 1) + other.substring(i + 1);
+	}
+
+	private static List<RefContentProposal> createProposalsFilteredRemote(
+			final List<RefContentProposal> proposals) {
+		final List<RefContentProposal> result = new ArrayList<RefContentProposal>();
+		for (final RefContentProposal p : proposals) {
+			final String content = p.getContent();
+			if (content.equals(Constants.HEAD)
+					|| content.startsWith(HEADS_PREFIX_S))
+				result.add(p);
+		}
+		return result;
+	}
+
+	private static Image getDecorationImage(final String key) {
+		return FieldDecorationRegistry.getDefault().getFieldDecoration(key)
+				.getImage();
+	}
+
+	private static void setControlDecoration(final ControlDecoration control,
+			final String imageKey, final String description) {
+		control.setImage(getDecorationImage(imageKey));
+		control.setDescriptionText(description);
+		control.show();
+	}
+
+	private final List<RefSpec> specs = new ArrayList<RefSpec>();
+
+	private final Composite panel;
+
+	private TableViewer tableViewer;
+
+	private CellEditor modeCellEditor;
+
+	private CellEditor localRefCellEditor;
+
+	private CellEditor remoteRefCellEditor;
+
+	private CellEditor forceUpdateCellEditor;
+
+	private CellEditor removeSpecCellEditor;
+
+	private int srcColumnIndex;
+
+	private Button removeAllSpecButton;
+
+	private Button forceUpdateAllButton;
+
+	private Button creationButton;
+
+	private Button addConfiguredButton;
+
+	private Button addTagsButton;
+
+	private Button addBranchesButton;
+
+	private ControlDecoration creationSrcDecoration;
+
+	private ControlDecoration creationDstDecoration;
+
+	private ControlDecoration deleteRefDecoration;
+
+	private Combo creationSrcCombo;
+
+	private Combo creationDstCombo;
+
+	private Combo deleteRefCombo;
+
+	private Button deleteButton;
+
+	private Repository localDb;
+
+	private String remoteName;
+
+	private Set<String> localRefNames = Collections.emptySet();
+
+	private Set<String> remoteRefNames = Collections.emptySet();
+
+	private List<RefSpec> predefinedConfigured = Collections.emptyList();
+
+	private RefSpec predefinedBranches = null;
+
+	private final RefContentProposalProvider remoteProposalProvider;
+
+	private final RefContentProposalProvider localProposalProvider;
+
+	private ComboLabelingSupport creationSrcComboSupport;
+
+	private ComboLabelingSupport creationDstComboSupport;
+
+	private ComboLabelingSupport deleteRefComboSupport;
+
+	private final boolean pushSpecs;
+
+	private final List<SelectionChangeListener> listeners = new LinkedList<SelectionChangeListener>();
+
+	private final ImageRegistry imageRegistry;
+
+	private boolean matchingAnyRefs;
+
+	private RefSpec invalidSpec;
+
+	private RefSpec invalidSpecSameDst;
+
+	private String errorMessage;
+
+	private Color errorBackgroundColor;
+
+	private Color errorTextColor;
+
+	/**
+	 * Create a new panel and install it on a provided composite. Panel is
+	 * created either for editing push or fetch specifications - this setting
+	 * can't be changed later, after constructing object.
+	 * <p>
+	 * Panel is created with an empty model, with no provided assistant. It
+	 * can't be used by user until
+	 * {@link #setAssistanceData(Repository, Collection, String)} method is
+	 * called, and to this time is disabled.
+	 * 
+	 * @param parent
+	 *            parent control for panel.
+	 * @param pushSpecs
+	 *            true if panel is used for editing push specifications, false
+	 *            if panel is used for editing fetch specifications.
+	 */
+	public RefSpecPanel(final Composite parent, final boolean pushSpecs) {
+		this.pushSpecs = pushSpecs;
+		this.localProposalProvider = new RefContentProposalProvider(true);
+		this.remoteProposalProvider = new RefContentProposalProvider(false);
+		this.imageRegistry = new ImageRegistry(parent.getDisplay());
+
+		panel = new Composite(parent, SWT.NONE);
+		panel.setLayout(new GridLayout());
+
+		safeCreateResources();
+
+		createCreationPanel();
+		if (pushSpecs)
+			createDeleteCreationPanel();
+		createPredefinedCreationPanel();
+		createTableGroup();
+
+		addRefSpecTableListener(new SelectionChangeListener() {
+			public void selectionChanged() {
+				validateSpecs();
+			}
+		});
+		setEnable(false);
+	}
+
+	/**
+	 * Enable or disable panel controls.
+	 * 
+	 * @param enable
+	 *            true to enable panel, false to disable.
+	 */
+	public void setEnable(final boolean enable) {
+		getControl().setEnabled(enable);
+	}
+
+	/**
+	 * Set information needed for assisting user with entering data and
+	 * validating user input. This method automatically enables the panel.
+	 * 
+	 * @param localRepo
+	 *            local repository where specifications will be applied.
+	 * @param remoteRefs
+	 *            collection of remote refs as advertised by remote repository.
+	 *            Typically they are collected by {@link FetchConnection}
+	 *            implementation.
+	 * @param remoteName
+	 *            optional name for remote configuration, if edited
+	 *            specification list is related to this remote configuration.
+	 *            Can be null. When not null, panel is filled with default
+	 *            fetch/push specifications for this remote configuration.
+	 */
+	public void setAssistanceData(final Repository localRepo,
+			final Collection<Ref> remoteRefs, final String remoteName) {
+		this.localDb = localRepo;
+		this.remoteName = remoteName;
+
+		final List<RefContentProposal> remoteProposals = createContentProposals(
+				remoteRefs, null);
+		remoteProposalProvider.setProposals(remoteProposals);
+		remoteRefNames = new HashSet<String>();
+		for (final RefContentProposal p : remoteProposals)
+			remoteRefNames.add(p.getContent());
+
+		Ref HEAD = null;
+		try {
+			final ObjectId id = localDb.resolve(Constants.HEAD);
+			if (id != null)
+				HEAD = new Ref(Storage.LOOSE, Constants.HEAD, id);
+		} catch (IOException e) {
+			Activator.logError("Couldn't read HEAD from local repository", e); //$NON-NLS-1$
+		}
+		final List<RefContentProposal> localProposals = createContentProposals(
+				localDb.getAllRefs().values(), HEAD);
+		localProposalProvider.setProposals(localProposals);
+		localRefNames = new HashSet<String>();
+		for (final RefContentProposal ref : localProposals)
+			localRefNames.add(ref.getContent());
+
+		final List<RefContentProposal> localFilteredProposals = createProposalsFilteredLocal(localProposals);
+		final List<RefContentProposal> remoteFilteredProposals = createProposalsFilteredRemote(remoteProposals);
+
+		if (pushSpecs) {
+			creationSrcComboSupport.setProposals(localFilteredProposals);
+			creationDstComboSupport.setProposals(remoteFilteredProposals);
+		} else {
+			creationSrcComboSupport.setProposals(remoteFilteredProposals);
+			creationDstComboSupport.setProposals(localFilteredProposals);
+		}
+		validateCreationPanel();
+
+		if (pushSpecs) {
+			deleteRefComboSupport.setProposals(remoteFilteredProposals);
+			validateDeleteCreationPanel();
+		}
+
+		try {
+			final RemoteConfig rc = new RemoteConfig(localDb.getConfig(),
+					remoteName);
+			if (pushSpecs)
+				predefinedConfigured = rc.getPushRefSpecs();
+			else
+				predefinedConfigured = rc.getFetchRefSpecs();
+			for (final RefSpec spec : predefinedConfigured)
+				addRefSpec(spec);
+		} catch (URISyntaxException e) {
+			predefinedConfigured = null;
+			ErrorDialog.openError(panel.getShell(),
+					UIText.RefSpecPanel_errorRemoteConfigTitle,
+					UIText.RefSpecPanel_errorRemoteConfigDescription,
+					new Status(IStatus.ERROR, Activator.getPluginId(), 0, e
+							.getMessage(), e));
+		}
+		updateAddPredefinedButton(addConfiguredButton, predefinedConfigured);
+		if (pushSpecs)
+			predefinedBranches = Transport.REFSPEC_PUSH_ALL;
+		else
+			predefinedBranches = new RefSpec("refs/heads/*:refs/remotes/" //$NON-NLS-1$
+					+ remoteName + "/*"); //$NON-NLS-1$
+		updateAddPredefinedButton(addBranchesButton, predefinedBranches);
+		setEnable(true);
+	}
+
+	/**
+	 * @return underlying control for this panel.
+	 */
+	public Control getControl() {
+		return panel;
+	}
+
+	/**
+	 * Return current list of specifications of this panel.
+	 * <p>
+	 * This method should be called only from the UI thread.
+	 * 
+	 * @return unmodifiable view of specifications list as edited by user in
+	 *         this panel. Note that this view underlying model may change -
+	 *         create a copy if needed.
+	 */
+	public List<RefSpec> getRefSpecs() {
+		return Collections.unmodifiableList(specs);
+	}
+
+	/**
+	 * @return true if specifications list is empty, false otherwise.
+	 */
+	public boolean isEmpty() {
+		return getRefSpecs().isEmpty();
+	}
+
+	/**
+	 * @return true if specifications match any ref(s) in source repository -
+	 *         resolve to concrete ref updates, false otherwise. For non empty
+	 *         specifications list, false value is possible only in case of
+	 *         specifications with wildcards.
+	 */
+	public boolean isMatchingAnyRefs() {
+		return matchingAnyRefs;
+	}
+
+	/**
+	 * Add provided specification to this panel. Panel view is automatically
+	 * refreshed, model is revalidated.
+	 * <p>
+	 * Note that the same reference can't be added twice to the panel, while two
+	 * or more equals RefSpec (in terms of equals method) can be - likely
+	 * causing validation error.
+	 * <p>
+	 * This method should be called only from the UI thread.
+	 * 
+	 * @param spec
+	 *            specification to add.
+	 * @throws IllegalArgumentException
+	 *             if specification with same reference already exists in panel.
+	 */
+	public void addRefSpec(final RefSpec spec) {
+		final int i = indexOfSpec(spec);
+		if (i != -1)
+			throw new IllegalArgumentException("RefSpec " + spec //$NON-NLS-1$
+					+ " already exists."); //$NON-NLS-1$
+		specs.add(spec);
+		tableViewer.add(spec);
+		notifySpecsChanged();
+	}
+
+	/**
+	 * Remove provided specification from this panel. Panel view is
+	 * automatically refreshed, model is revalidated.
+	 * <p>
+	 * Provided specification must be equals with existing one in terms of
+	 * reference equality, not an equals method.
+	 * <p>
+	 * This method should be called only from the UI thread.
+	 * 
+	 * @param spec
+	 *            specification to remove.
+	 * @throws IllegalArgumentException
+	 *             if specification with this reference doesn't exist in this
+	 *             panel.
+	 */
+	public void removeRefSpec(final RefSpec spec) {
+		final int i = indexOfSpec(spec);
+		if (i == -1)
+			throw new IllegalArgumentException("RefSpec " + spec //$NON-NLS-1$
+					+ " not found."); //$NON-NLS-1$
+		specs.remove(i);
+		tableViewer.remove(spec);
+		notifySpecsChanged();
+	}
+
+	/**
+	 * Change some specification to the new one.
+	 * <p>
+	 * Old specification must exist in the panel, while new specification can't
+	 * exist before (both in terms of reference equality).
+	 * <p>
+	 * This method should be called only from the UI thread.
+	 * 
+	 * @param oldSpec
+	 *            specification to change. Can't be null.
+	 * @param newSpec
+	 *            new specification to override existing one. Can't be null.
+	 */
+	public void setRefSpec(final RefSpec oldSpec, final RefSpec newSpec) {
+		final int oldI = indexOfSpec(oldSpec);
+		if (oldI == -1)
+			throw new IllegalArgumentException("RefSpec " + oldSpec //$NON-NLS-1$
+					+ " not found."); //$NON-NLS-1$
+		final int newI = indexOfSpec(newSpec);
+		if (newI != -1)
+			throw new IllegalArgumentException("RefSpec " + newSpec //$NON-NLS-1$
+					+ " already exists."); //$NON-NLS-1$
+		specs.set(oldI, newSpec);
+
+		// have to refresh whole table as we are operating on immutable objects
+		// (this shouldn't be an issue)
+		tableViewer.refresh();
+		notifySpecsChanged();
+	}
+
+	/**
+	 * Clear all specifications from this panel.
+	 * <p>
+	 * This method should be called only from the UI thread.
+	 */
+	public void clearRefSpecs() {
+		final RefSpec toRemove[] = specs.toArray(new RefSpec[0]);
+		specs.clear();
+		tableViewer.remove(toRemove);
+		notifySpecsChanged();
+	}
+
+	/**
+	 * Add listener of changes in panel model.
+	 * <p>
+	 * Listeners are notified on events caused by both operations invoked by
+	 * external calls and user interaction. Listener method(s) is always called
+	 * from UI thread and shouln't perform long computations.
+	 * <p>
+	 * Order of adding listeners is significant. This method is not thread-safe.
+	 * Listeners should be set up before panel usage.
+	 * 
+	 * @param listener
+	 *            listener to add.
+	 */
+	public void addRefSpecTableListener(final SelectionChangeListener listener) {
+		listeners.add(listener);
+	}
+
+	/**
+	 * Get user-friendly error message regarding invalid specification.
+	 * 
+	 * @return user-readable information about invalid specification.
+	 */
+	public String getErrorMessage() {
+		return errorMessage;
+	}
+
+	/**
+	 * Return information about validity of specifications.
+	 * <p>
+	 * Specifications are considered valid if pushing/fetching (depending on
+	 * panel configuration) shouldn't cause any error except for
+	 * non-fast-forward or server-related errors complaint. I.e. specifications
+	 * destinations don't overlap and every specification is correctly
+	 * formulated, preferably none is referring to non-existing ref etc.
+	 * 
+	 * @return true if all specifications in panel are valid, false if at least
+	 *         one specification is invalid (in this case
+	 *         {@link #getErrorMessage()} gives detailed information for user).
+	 */
+	public boolean isValid() {
+		return errorMessage == null;
+	}
+
+	private int indexOfSpec(final RefSpec spec) {
+		int i;
+		for (i = 0; i < specs.size(); i++) {
+			// we have to compare references, not use List#indexOf,
+			// as equals is implemented in RefSpec
+			if (specs.get(i) == spec)
+				break;
+		}
+		if (i == specs.size())
+			return -1;
+		return i;
+	}
+
+	private void notifySpecsChanged() {
+		for (final SelectionChangeListener listener : listeners)
+			listener.selectionChanged();
+	}
+
+	private void safeCreateResources() {
+		imageRegistry.put(IMAGE_ADD, UIIcons.ELCL16_ADD);
+		imageRegistry.put(IMAGE_DELETE, UIIcons.ELCL16_DELETE);
+		imageRegistry.put(IMAGE_TRASH, UIIcons.ELCL16_TRASH);
+		imageRegistry.put(IMAGE_CLEAR, UIIcons.ELCL16_CLEAR);
+		errorBackgroundColor = new Color(panel.getDisplay(), 255, 150, 150);
+		errorTextColor = new Color(panel.getDisplay(), 255, 0, 0);
+
+		panel.addDisposeListener(new DisposeListener() {
+			public void widgetDisposed(DisposeEvent e) {
+				imageRegistry.dispose();
+				errorBackgroundColor.dispose();
+				errorTextColor.dispose();
+			}
+		});
+	}
+
+	private RefContentProposalProvider getRefsProposalProvider(
+			final boolean local) {
+		return (local ? localProposalProvider : remoteProposalProvider);
+	}
+
+	private void createCreationPanel() {
+		final Group creationPanel = new Group(panel, SWT.NONE);
+		creationPanel.setText(UIText.RefSpecPanel_creationGroup);
+		creationPanel.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true,
+				false));
+		final GridLayout layout = new GridLayout();
+		layout.numColumns = 3;
+		layout.horizontalSpacing = 10;
+		layout.verticalSpacing = 2;
+		creationPanel.setLayout(layout);
+
+		new Label(creationPanel, SWT.NONE)
+				.setText(UIText.RefSpecPanel_creationSrc);
+		new Label(creationPanel, SWT.NONE)
+				.setText(UIText.RefSpecPanel_creationDst);
+		creationButton = new Button(creationPanel, SWT.PUSH);
+		creationButton.setLayoutData(new GridData(SWT.RIGHT, SWT.BOTTOM, false,
+				false, 1, 2));
+		creationButton.setImage(imageRegistry.get(IMAGE_ADD));
+		creationButton.setText(UIText.RefSpecPanel_creationButton);
+		creationButton.addSelectionListener(new SelectionAdapter() {
+			@Override
+			public void widgetSelected(SelectionEvent e) {
+				final String src = creationSrcCombo.getText();
+				final String dst = creationDstCombo.getText();
+				RefSpec spec = new RefSpec(src + ':' + dst);
+				addRefSpec(spec);
+				creationSrcCombo.setText(""); //$NON-NLS-1$
+				creationDstCombo.setText(""); //$NON-NLS-1$
+			}
+		});
+		creationButton.setToolTipText(NLS.bind(
+				UIText.RefSpecPanel_creationButtonDescription, typeString()));
+
+		creationSrcDecoration = createAssistedDecoratedCombo(creationPanel,
+				getRefsProposalProvider(pushSpecs),
+				new IContentProposalListener() {
+					public void proposalAccepted(IContentProposal proposal) {
+						tryAutoCompleteSrcToDst();
+					}
+				});
+		creationSrcCombo = (Combo) creationSrcDecoration.getControl();
+		creationSrcCombo.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true,
+				false));
+		creationSrcCombo.addTraverseListener(new TraverseListener() {
+			public void keyTraversed(TraverseEvent e) {
+				// SWT.TRAVERSE_RETURN may be also reasonable here, but
+				// it can be confused with RETURN for content proposal
+				if (e.detail == SWT.TRAVERSE_TAB_NEXT)
+					tryAutoCompleteSrcToDst();
+			}
+		});
+		if (pushSpecs)
+			creationSrcCombo
+					.setToolTipText(UIText.RefSpecPanel_srcPushDescription);
+		else
+			creationSrcCombo
+					.setToolTipText(UIText.RefSpecPanel_srcFetchDescription);
+		creationSrcComboSupport = new ComboLabelingSupport(creationSrcCombo,
+				new SelectionAdapter() {
+					@Override
+					public void widgetSelected(SelectionEvent e) {
+						tryAutoCompleteSrcToDst();
+					}
+				});
+
+		creationDstDecoration = createAssistedDecoratedCombo(creationPanel,
+				getRefsProposalProvider(!pushSpecs),
+				new IContentProposalListener() {
+					public void proposalAccepted(IContentProposal proposal) {
+						tryAutoCompleteDstToSrc();
+					}
+				});
+		creationDstCombo = (Combo) creationDstDecoration.getControl();
+		creationDstCombo.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true,
+				false));
+		creationDstCombo.addTraverseListener(new TraverseListener() {
+			public void keyTraversed(TraverseEvent e) {
+				// SWT.TRAVERSE_RETURN may be also reasonable here, but
+				// it can be confused with RETURN for content proposal
+				if (e.detail == SWT.TRAVERSE_TAB_NEXT)
+					tryAutoCompleteDstToSrc();
+			}
+		});
+		if (pushSpecs)
+			creationDstCombo
+					.setToolTipText(UIText.RefSpecPanel_dstPushDescription);
+		else
+			creationDstCombo
+					.setToolTipText(UIText.RefSpecPanel_dstFetchDescription);
+		creationDstComboSupport = new ComboLabelingSupport(creationDstCombo,
+				new SelectionAdapter() {
+					@Override
+					public void widgetSelected(SelectionEvent e) {
+						tryAutoCompleteDstToSrc();
+					}
+				});
+
+		validateCreationPanel();
+		final ModifyListener validator = new ModifyListener() {
+			public void modifyText(final ModifyEvent e) {
+				validateCreationPanel();
+			}
+		};
+		creationSrcCombo.addModifyListener(validator);
+		creationDstCombo.addModifyListener(validator);
+	}
+
+	private void createDeleteCreationPanel() {
+		final Group deletePanel = new Group(panel, SWT.NONE);
+		deletePanel.setText(UIText.RefSpecPanel_deletionGroup);
+		deletePanel
+				.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, false));
+		final GridLayout layout = new GridLayout();
+		layout.numColumns = 3;
+		layout.horizontalSpacing = 10;
+		deletePanel.setLayout(layout);
+
+		final Label label = new Label(deletePanel, SWT.NONE);
+		label.setText(UIText.RefSpecPanel_deletionRef);
+		label.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, false, false));
+
+		deleteRefDecoration = createAssistedDecoratedCombo(deletePanel,
+				getRefsProposalProvider(false), null);
+		deleteRefCombo = (Combo) deleteRefDecoration.getControl();
+		deleteRefCombo.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true,
+				false));
+		deleteRefCombo
+				.setToolTipText(UIText.RefSpecPanel_dstDeletionDescription);
+		deleteRefComboSupport = new ComboLabelingSupport(deleteRefCombo, null);
+
+		deleteButton = new Button(deletePanel, SWT.PUSH);
+		deleteButton.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, false,
+				false));
+		deleteButton.setImage(imageRegistry.get(IMAGE_DELETE));
+		deleteButton.setText(UIText.RefSpecPanel_deletionButton);
+		deleteButton.addSelectionListener(new SelectionAdapter() {
+			@Override
+			public void widgetSelected(SelectionEvent e) {
+				RefSpec spec = new RefSpec(':' + deleteRefCombo.getText());
+				addRefSpec(spec);
+				deleteRefCombo.setText(""); //$NON-NLS-1$
+			}
+		});
+		deleteButton
+				.setToolTipText(UIText.RefSpecPanel_deletionButtonDescription);
+		validateDeleteCreationPanel();
+
+		deleteRefCombo.addModifyListener(new ModifyListener() {
+			public void modifyText(final ModifyEvent e) {
+				validateDeleteCreationPanel();
+			}
+		});
+	}
+
+	private void createPredefinedCreationPanel() {
+		final Group predefinedPanel = new Group(panel, SWT.NONE);
+		predefinedPanel.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true,
+				false));
+		predefinedPanel.setText(UIText.RefSpecPanel_predefinedGroup);
+		final GridLayout layout = new GridLayout();
+		layout.numColumns = 3;
+		predefinedPanel.setLayout(layout);
+
+		addConfiguredButton = new Button(predefinedPanel, SWT.PUSH);
+		addConfiguredButton.setLayoutData(new GridData(SWT.FILL, SWT.CENTER,
+				true, false));
+		addConfiguredButton.setText(NLS.bind(
+				UIText.RefSpecPanel_predefinedConfigured, typeString()));
+		addConfiguredButton.addSelectionListener(new SelectionAdapter() {
+			@Override
+			public void widgetSelected(SelectionEvent e) {
+				addPredefinedRefSpecs(predefinedConfigured);
+			}
+		});
+		addConfiguredButton
+				.setToolTipText(UIText.RefSpecPanel_predefinedConfiguredDescription);
+		updateAddPredefinedButton(addConfiguredButton, predefinedConfigured);
+
+		addBranchesButton = new Button(predefinedPanel, SWT.PUSH);
+		addBranchesButton.setLayoutData(new GridData(SWT.FILL, SWT.CENTER,
+				true, false));
+		addBranchesButton.setText(UIText.RefSpecPanel_predefinedAll);
+		addBranchesButton.addSelectionListener(new SelectionAdapter() {
+			@Override
+			public void widgetSelected(SelectionEvent e) {
+				addPredefinedRefSpecs(predefinedBranches);
+			}
+		});
+		addBranchesButton
+				.setToolTipText(UIText.RefSpecPanel_predefinedAllDescription);
+		updateAddPredefinedButton(addBranchesButton, predefinedBranches);
+
+		addTagsButton = new Button(predefinedPanel, SWT.PUSH);
+		addTagsButton.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true,
+				false));
+		addTagsButton.setText(UIText.RefSpecPanel_predefinedTags);
+		addTagsButton.addSelectionListener(new SelectionAdapter() {
+			@Override
+			public void widgetSelected(SelectionEvent e) {
+				addPredefinedRefSpecs(Transport.REFSPEC_TAGS);
+			}
+		});
+		addTagsButton
+				.setToolTipText(UIText.RefSpecPanel_predefinedTagsDescription);
+		updateAddPredefinedButton(addTagsButton, Transport.REFSPEC_TAGS);
+
+		addRefSpecTableListener(new SelectionChangeListener() {
+			public void selectionChanged() {
+				updateAddPredefinedButton(addConfiguredButton,
+						predefinedConfigured);
+				updateAddPredefinedButton(addBranchesButton, predefinedBranches);
+				updateAddPredefinedButton(addTagsButton, Transport.REFSPEC_TAGS);
+			}
+		});
+	}
+
+	private ControlDecoration createAssistedDecoratedCombo(
+			final Composite parent,
+			final IContentProposalProvider proposalProvider,
+			final IContentProposalListener listener) {
+		// FIXME: VERY ANNOYING! reported as 243991 in eclipse bugzilla
+		// when typing, pressing arrow-down key opens combo box drop-down
+		// instead of moving within autocompletion list (Mac 10.4&10.5, Eclipse
+		// 3.4)
+		final Combo combo = new Combo(parent, SWT.DROP_DOWN);
+		final ControlDecoration decoration = new ControlDecoration(combo,
+				SWT.BOTTOM | SWT.LEFT);
+		final ContentAssistCommandAdapter proposal = new ContentAssistCommandAdapter(
+				combo, new ComboContentAdapter(), proposalProvider, null, null,
+				true);
+		proposal
+				.setProposalAcceptanceStyle(ContentProposalAdapter.PROPOSAL_REPLACE);
+		if (listener != null)
+			proposal.addContentProposalListener(listener);
+		return decoration;
+	}
+
+	private void createTableGroup() {
+		final Group tableGroup = new Group(panel, SWT.NONE);
+		tableGroup.setText(NLS.bind(UIText.RefSpecPanel_specifications,
+				typeString()));
+		tableGroup.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, true));
+		tableGroup.setLayout(new GridLayout());
+
+		createTable(tableGroup);
+		createSpecsButtonsPanel(tableGroup);
+	}
+
+	private void createTable(final Group tableGroup) {
+		final Composite tablePanel = new Composite(tableGroup, SWT.NONE);
+		final GridData layoutData = new GridData(SWT.FILL, SWT.FILL, true, true);
+		layoutData.heightHint = TABLE_PREFERRED_HEIGHT;
+		layoutData.widthHint = TABLE_PREFERRED_WIDTH;
+		tablePanel.setLayoutData(layoutData);
+
+		tableViewer = new TableViewer(tablePanel, SWT.FULL_SELECTION
+				| SWT.MULTI | SWT.BORDER | SWT.V_SCROLL);
+		ColumnViewerToolTipSupport.enableFor(tableViewer);
+		final Table table = tableViewer.getTable();
+		table.setLinesVisible(true);
+		table.setHeaderVisible(true);
+
+		createTableColumns(tablePanel);
+		createCellEditors(table);
+
+		tableViewer.setContentProvider(new IStructuredContentProvider() {
+			public Object[] getElements(final Object inputElement) {
+				return ((List) inputElement).toArray();
+			}
+
+			public void dispose() {
+				// nothing to dispose
+			}
+
+			public void inputChanged(Viewer viewer, Object oldInput,
+					Object newInput) {
+				// input is hard coded
+			}
+		});
+		tableViewer.setInput(specs);
+
+		tableViewer.setComparer(new IElementComparer() {
+			public boolean equals(Object a, Object b) {
+				// need that as viewers are not designed to support 2 equals
+				// object, while we have RefSpec#equals implemented
+				return a == b;
+			}
+
+			public int hashCode(Object element) {
+				return element.hashCode();
+			}
+		});
+	}
+
+	private void createTableColumns(final Composite tablePanel) {
+		final TableColumnLayout columnLayout = new TableColumnLayout();
+		tablePanel.setLayout(columnLayout);
+
+		createDummyColumn(columnLayout);
+		createModeColumn(columnLayout);
+		createSrcColumn(columnLayout);
+		createDstColumn(columnLayout);
+		createForceColumn(columnLayout);
+		createRemoveColumn(columnLayout);
+	}
+
+	private void createDummyColumn(final TableColumnLayout columnLayout) {
+		final TableViewerColumn viewerColumn = new TableViewerColumn(
+				tableViewer, SWT.LEFT);
+		final TableColumn column = viewerColumn.getColumn();
+		columnLayout.setColumnData(column, new ColumnWeightData(0, 0, false));
+		viewerColumn.setLabelProvider(new ColumnLabelProvider());
+		// FIXME: first cell is left aligned on Mac OS X 10.4, Eclipse 3.4
+	}
+
+	private void createModeColumn(final TableColumnLayout columnLayout) {
+		final TableViewerColumn column = createColumn(columnLayout,
+				UIText.RefSpecPanel_columnMode, COLUMN_MODE_WEIGHT, SWT.CENTER);
+		column.setLabelProvider(new ColumnLabelProvider() {
+			@Override
+			public String getText(final Object element) {
+				return (isDeleteRefSpec(element) ? UIText.RefSpecPanel_modeDelete
+						: UIText.RefSpecPanel_modeUpdate);
+			}
+
+			@Override
+			public Image getImage(Object element) {
+				return (isDeleteRefSpec(element) ? imageRegistry
+						.get(IMAGE_DELETE) : imageRegistry.get(IMAGE_ADD));
+			}
+
+			@Override
+			public String getToolTipText(Object element) {
+				if (isDeleteRefSpec(element))
+					return UIText.RefSpecPanel_modeDeleteDescription + '\n'
+							+ UIText.RefSpecPanel_clickToChange;
+				return UIText.RefSpecPanel_modeUpdateDescription + '\n'
+						+ UIText.RefSpecPanel_clickToChange;
+			}
+		});
+		column.setEditingSupport(new EditingSupport(tableViewer) {
+			@Override
+			protected boolean canEdit(final Object element) {
+				return true;
+			}
+
+			@Override
+			protected CellEditor getCellEditor(final Object element) {
+				return modeCellEditor;
+			}
+
+			@Override
+			protected Object getValue(final Object element) {
+				return isDeleteRefSpec(element);
+			}
+
+			@Override
+			protected void setValue(final Object element, final Object value) {
+				final RefSpec oldSpec = (RefSpec) element;
+				final RefSpec newSpec;
+				if ((Boolean) value) {
+					newSpec = setRefSpecSource(oldSpec, null);
+					setRefSpec(oldSpec, newSpec);
+				} else {
+					newSpec = setRefSpecSource(oldSpec,
+							UIText.RefSpecPanel_refChooseSome);
+					setRefSpec(oldSpec, newSpec);
+					tableViewer.getControl().getDisplay().asyncExec(
+							new Runnable() {
+								public void run() {
+									tableViewer.editElement(newSpec,
+											srcColumnIndex);
+								}
+							});
+				}
+			}
+		});
+	}
+
+	private void createSrcColumn(final TableColumnLayout columnLayout) {
+		final TableViewerColumn column = createColumn(columnLayout,
+				UIText.RefSpecPanel_columnSrc, COLUMN_SRC_WEIGHT, SWT.LEFT);
+		column.setLabelProvider(new ColumnLabelProvider() {
+			@Override
+			public String getText(final Object element) {
+				return ((RefSpec) element).getSource();
+			}
+
+			@Override
+			public String getToolTipText(Object element) {
+				if (isInvalidSpec(element))
+					return errorMessage;
+				if (isDeleteRefSpec(element))
+					return UIText.RefSpecPanel_srcDeleteDescription;
+				if (pushSpecs)
+					return UIText.RefSpecPanel_srcPushDescription;
+				return UIText.RefSpecPanel_srcFetchDescription;
+			}
+
+			@Override
+			public Color getBackground(final Object element) {
+				if (isInvalidSpec(element))
+					return errorBackgroundColor;
+				return null;
+			}
+
+			@Override
+			public Color getToolTipForegroundColor(Object element) {
+				if (isInvalidSpec(element))
+					return errorTextColor;
+				return null;
+			}
+		});
+		column.setEditingSupport(new EditingSupport(tableViewer) {
+			@Override
+			protected boolean canEdit(final Object element) {
+				return !isDeleteRefSpec(element);
+			}
+
+			@Override
+			protected CellEditor getCellEditor(final Object element) {
+				return (pushSpecs ? localRefCellEditor : remoteRefCellEditor);
+			}
+
+			@Override
+			protected Object getValue(final Object element) {
+				return ((RefSpec) element).getSource();
+			}
+
+			@Override
+			protected void setValue(final Object element, final Object value) {
+				if (value == null || ((String) value).length() == 0
+						|| ObjectId.zeroId().toString().equals(value)) {
+					// Ignore empty strings or null objects - do not set them in
+					// model.User won't loose any information if we just fall
+					// back to the old value.
+					// If user want to delete ref, let change the mode.
+					return;
+				}
+
+				final RefSpec oldSpec = (RefSpec) element;
+				final RefSpec newSpec = setRefSpecSource(oldSpec,
+						(String) value);
+				setRefSpec(oldSpec, newSpec);
+			}
+		});
+
+		// find index of this column - for later usage
+		final TableColumn[] columns = tableViewer.getTable().getColumns();
+		for (srcColumnIndex = 0; srcColumnIndex < columns.length; srcColumnIndex++)
+			if (columns[srcColumnIndex] == column.getColumn())
+				break;
+
+	}
+
+	private void createDstColumn(final TableColumnLayout columnLayout) {
+		final TableViewerColumn column = createColumn(columnLayout,
+				UIText.RefSpecPanel_columnDst, COLUMN_DST_WEIGHT, SWT.LEFT);
+		column.setLabelProvider(new ColumnLabelProvider() {
+			@Override
+			public String getText(final Object element) {
+				return ((RefSpec) element).getDestination();
+			}
+
+			@Override
+			public String getToolTipText(Object element) {
+				if (isInvalidSpec(element))
+					return errorMessage;
+				if (isDeleteRefSpec(element))
+					return UIText.RefSpecPanel_dstDeletionDescription;
+				if (pushSpecs)
+					return UIText.RefSpecPanel_dstPushDescription;
+				return UIText.RefSpecPanel_dstFetchDescription;
+			}
+
+			@Override
+			public Color getBackground(final Object element) {
+				if (isInvalidSpec(element))
+					return errorBackgroundColor;
+				return null;
+			}
+
+			@Override
+			public Color getToolTipForegroundColor(Object element) {
+				if (isInvalidSpec(element))
+					return errorTextColor;
+				return null;
+			}
+		});
+		column.setEditingSupport(new EditingSupport(tableViewer) {
+			@Override
+			protected boolean canEdit(final Object element) {
+				return true;
+			}
+
+			@Override
+			protected CellEditor getCellEditor(final Object element) {
+				return (pushSpecs ? remoteRefCellEditor : localRefCellEditor);
+			}
+
+			@Override
+			protected Object getValue(final Object element) {
+				return ((RefSpec) element).getDestination();
+			}
+
+			@Override
+			protected void setValue(final Object element, final Object value) {
+				if (value == null || ((String) value).length() == 0) {
+					// Ignore empty strings - do not set them in model.
+					// User won't loose any information if we just fall back
+					// to the old value.
+					return;
+				}
+
+				final RefSpec oldSpec = (RefSpec) element;
+				final RefSpec newSpec = setRefSpecDestination(oldSpec,
+						(String) value);
+				setRefSpec(oldSpec, newSpec);
+			}
+		});
+	}
+
+	private void createForceColumn(final TableColumnLayout columnLayout) {
+		final TableViewerColumn column = createColumn(columnLayout,
+				UIText.RefSpecPanel_columnForce, COLUMN_FORCE_WEIGHT,
+				SWT.CENTER);
+		column.setLabelProvider(new CheckboxLabelProvider(tableViewer
+				.getControl()) {
+			@Override
+			protected boolean isChecked(final Object element) {
+				return ((RefSpec) element).isForceUpdate();
+			}
+
+			@Override
+			protected boolean isEnabled(Object element) {
+				return !isDeleteRefSpec(element);
+			}
+
+			@Override
+			public String getToolTipText(Object element) {
+				if (!isEnabled(element))
+					return UIText.RefSpecPanel_forceDeleteDescription;
+				if (isChecked(element))
+					return UIText.RefSpecPanel_forceTrueDescription + '\n'
+							+ UIText.RefSpecPanel_clickToChange;
+				return UIText.RefSpecPanel_forceFalseDescription + '\n'
+						+ UIText.RefSpecPanel_clickToChange;
+			}
+		});
+		column.setEditingSupport(new EditingSupport(tableViewer) {
+			@Override
+			protected boolean canEdit(final Object element) {
+				return !isDeleteRefSpec(element);
+			}
+
+			@Override
+			protected CellEditor getCellEditor(final Object element) {
+				return forceUpdateCellEditor;
+			}
+
+			@Override
+			protected Object getValue(final Object element) {
+				return ((RefSpec) element).isForceUpdate();
+			}
+
+			@Override
+			protected void setValue(final Object element, final Object value) {
+				final RefSpec oldSpec = (RefSpec) element;
+				final RefSpec newSpec = oldSpec.setForceUpdate((Boolean) value);
+				setRefSpec(oldSpec, newSpec);
+			}
+		});
+	}
+
+	private void createRemoveColumn(TableColumnLayout columnLayout) {
+		final TableViewerColumn column = createColumn(columnLayout,
+				UIText.RefSpecPanel_columnRemove, COLUMN_REMOVE_WEIGHT,
+				SWT.CENTER);
+		column.setLabelProvider(new CenteredImageLabelProvider() {
+			@Override
+			public Image getImage(Object element) {
+				return imageRegistry.get(IMAGE_TRASH);
+			}
+
+			@Override
+			public String getToolTipText(Object element) {
+				return NLS.bind(UIText.RefSpecPanel_removeDescription,
+						typeString());
+			}
+		});
+		column.setEditingSupport(new EditingSupport(tableViewer) {
+			@Override
+			protected boolean canEdit(Object element) {
+				return true;
+			}
+
+			@Override
+			protected CellEditor getCellEditor(Object element) {
+				return removeSpecCellEditor;
+			}
+
+			@Override
+			protected Object getValue(Object element) {
+				return null;
+			}
+
+			@Override
+			protected void setValue(Object element, Object value) {
+				removeRefSpec((RefSpec) element);
+			}
+		});
+	}
+
+	private TableViewerColumn createColumn(
+			final TableColumnLayout columnLayout, final String text,
+			final int weight, final int style) {
+		final TableViewerColumn viewerColumn = new TableViewerColumn(
+				tableViewer, style);
+		final TableColumn column = viewerColumn.getColumn();
+		column.setText(text);
+		columnLayout.setColumnData(column, new ColumnWeightData(weight));
+		return viewerColumn;
+	}
+
+	private void createCellEditors(final Table table) {
+		modeCellEditor = new CheckboxCellEditor(table);
+		localRefCellEditor = createLocalRefCellEditor(table);
+		remoteRefCellEditor = createRemoteRefCellEditor(table);
+		forceUpdateCellEditor = new CheckboxCellEditor(table);
+		removeSpecCellEditor = new ClickableCellEditor(table);
+	}
+
+	private CellEditor createLocalRefCellEditor(final Table table) {
+		return createRefCellEditor(table, getRefsProposalProvider(true));
+	}
+
+	private CellEditor createRemoteRefCellEditor(final Table table) {
+		return createRefCellEditor(table, getRefsProposalProvider(false));
+	}
+
+	private CellEditor createRefCellEditor(final Table table,
+			final IContentProposalProvider proposalProvider) {
+		final CellEditor cellEditor = new TextCellEditor(table);
+
+		final Text text = (Text) cellEditor.getControl();
+		final ContentAssistCommandAdapter assist = new ContentAssistCommandAdapter(
+				text, new TextContentAdapter(), proposalProvider, null, null,
+				true);
+		assist
+				.setProposalAcceptanceStyle(ContentProposalAdapter.PROPOSAL_REPLACE);
+
+		return cellEditor;
+	}
+
+	private void createSpecsButtonsPanel(final Composite parent) {
+		final Composite specsPanel = new Composite(parent, SWT.NONE);
+		specsPanel.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, true,
+				false));
+		final RowLayout layout = new RowLayout();
+		layout.spacing = 10;
+		specsPanel.setLayout(layout);
+
+		forceUpdateAllButton = new Button(specsPanel, SWT.PUSH);
+		forceUpdateAllButton.setText(UIText.RefSpecPanel_forceAll);
+		forceUpdateAllButton.addSelectionListener(new SelectionAdapter() {
+			@Override
+			public void widgetSelected(SelectionEvent e) {
+				final List<RefSpec> specsCopy = new ArrayList<RefSpec>(specs);
+				for (final RefSpec spec : specsCopy) {
+					if (!isDeleteRefSpec(spec))
+						setRefSpec(spec, spec.setForceUpdate(true));
+				}
+			}
+		});
+		forceUpdateAllButton
+				.setToolTipText(UIText.RefSpecPanel_forceAllDescription);
+		updateForceUpdateAllButton();
+
+		removeAllSpecButton = new Button(specsPanel, SWT.PUSH);
+		removeAllSpecButton.setImage(imageRegistry.get(IMAGE_CLEAR));
+		removeAllSpecButton.setText(UIText.RefSpecPanel_removeAll);
+		removeAllSpecButton.addSelectionListener(new SelectionAdapter() {
+			@Override
+			public void widgetSelected(SelectionEvent e) {
+				clearRefSpecs();
+			}
+		});
+		removeAllSpecButton
+				.setToolTipText(UIText.RefSpecPanel_removeAllDescription);
+		updateRemoveAllSpecButton();
+
+		addRefSpecTableListener(new SelectionChangeListener() {
+			public void selectionChanged() {
+				updateForceUpdateAllButton();
+				updateRemoveAllSpecButton();
+			}
+		});
+	}
+
+	private void tryAutoCompleteSrcToDst() {
+		final String src = creationSrcCombo.getText();
+		final String dst = creationDstCombo.getText();
+
+		if (src == null || src.length() == 0)
+			return;
+
+		if (dst != null && dst.length() > 0) {
+			// dst is already there, just fix wildcards if needed
+			final String newDst;
+			if (RefSpec.isWildcard(src))
+				newDst = wildcardSpecComponent(dst);
+			else
+				newDst = unwildcardSpecComponent(dst, src);
+			creationDstCombo.setText(newDst);
+			return;
+		}
+
+		if (!isValidRefExpression(src)) {
+			// no way to be smarter than user here
+			return;
+		}
+
+		// dst is empty, src is ref or wildcard, so we can rewrite it as user
+		// would perhaps
+		if (pushSpecs)
+			creationDstCombo.setText(src);
+		else {
+			for (final RefSpec spec : predefinedConfigured) {
+				if (spec.matchSource(src)) {
+					final String newDst = spec.expandFromSource(src)
+							.getDestination();
+					creationDstCombo.setText(newDst);
+					return;
+				}
+			}
+			if (remoteName != null && src.startsWith(HEADS_PREFIX_S)) {
+				final String newDst = REMOTES_PREFIX_S + remoteName + '/'
+						+ src.substring(HEADS_PREFIX_S.length());
+				creationDstCombo.setText(newDst);
+			}
+		}
+	}
+
+	private void tryAutoCompleteDstToSrc() {
+		final String src = creationSrcCombo.getText();
+		final String dst = creationDstCombo.getText();
+
+		if (dst == null || dst.length() == 0)
+			return;
+
+		if (src != null && src.length() > 0) {
+			// src is already there, fix wildcards if needed
+			final String newSrc;
+			if (RefSpec.isWildcard(dst))
+				newSrc = wildcardSpecComponent(src);
+			else
+				newSrc = unwildcardSpecComponent(src, dst);
+			creationSrcCombo.setText(newSrc);
+			return;
+		}
+	}
+
+	private void validateCreationPanel() {
+		final String src = creationSrcCombo.getText();
+		final String dst = creationDstCombo.getText();
+
+		// check src ref field
+		boolean srcOk = false;
+		final boolean srcWildcard = RefSpec.isWildcard(src);
+		if (src == null || src.length() == 0)
+			setControlDecoration(creationSrcDecoration,
+					FieldDecorationRegistry.DEC_REQUIRED,
+					UIText.RefSpecPanel_validationSrcUpdateRequired);
+		else if (pushSpecs) {
+			if (!srcWildcard && !isLocalRef(src))
+				setControlDecoration(creationSrcDecoration,
+						FieldDecorationRegistry.DEC_ERROR, NLS.bind(
+								UIText.RefSpecPanel_validationRefInvalidLocal,
+								src));
+			else if (srcWildcard && !isValidRefExpression(src))
+				setControlDecoration(
+						creationSrcDecoration,
+						FieldDecorationRegistry.DEC_ERROR,
+						NLS
+								.bind(
+										UIText.RefSpecPanel_validationRefInvalidExpression,
+										src));
+			else {
+				srcOk = true;
+				if (srcWildcard && !isMatchingAny(src, localRefNames))
+					setControlDecoration(
+							creationSrcDecoration,
+							FieldDecorationRegistry.DEC_WARNING,
+							NLS
+									.bind(
+											UIText.RefSpecPanel_validationRefNonMatchingLocal,
+											src));
+				else
+					creationSrcDecoration.hide();
+			}
+		} else {
+			if (!srcWildcard && !isRemoteRef(src))
+				setControlDecoration(
+						creationSrcDecoration,
+						FieldDecorationRegistry.DEC_ERROR,
+						NLS
+								.bind(
+										UIText.RefSpecPanel_validationRefNonExistingRemote,
+										src));
+			else if (srcWildcard && !isMatchingAny(src, remoteRefNames)) {
+				setControlDecoration(
+						creationSrcDecoration,
+						FieldDecorationRegistry.DEC_WARNING,
+						NLS
+								.bind(
+										UIText.RefSpecPanel_validationRefNonMatchingRemote,
+										src));
+				srcOk = true;
+			} else {
+				srcOk = true;
+				creationSrcDecoration.hide();
+			}
+		}
+
+		// check dst ref field
+		boolean dstOk = false;
+		if (dst == null || dst.length() == 0)
+			setControlDecoration(creationDstDecoration,
+					FieldDecorationRegistry.DEC_REQUIRED,
+					UIText.RefSpecPanel_validationDstRequired);
+		else if (!isValidRefExpression(dst))
+			setControlDecoration(creationDstDecoration,
+					FieldDecorationRegistry.DEC_ERROR, NLS.bind(
+							UIText.RefSpecPanel_validationDstInvalidExpression,
+							dst));
+		else {
+			creationDstDecoration.hide();
+			dstOk = true;
+		}
+		// leave duplicates dst checking for validateSpecs()
+
+		// check the wildcard synergy
+		boolean wildcardOk = true;
+		if (srcOk && dstOk && (srcWildcard ^ RefSpec.isWildcard(dst))) {
+			setControlDecoration(creationSrcDecoration,
+					FieldDecorationRegistry.DEC_ERROR,
+					UIText.RefSpecPanel_validationWildcardInconsistent);
+			setControlDecoration(creationDstDecoration,
+					FieldDecorationRegistry.DEC_ERROR,
+					UIText.RefSpecPanel_validationWildcardInconsistent);
+			wildcardOk = false;
+		}
+
+		creationButton.setEnabled(srcOk && dstOk && wildcardOk);
+	}
+
+	private void validateDeleteCreationPanel() {
+		final String ref = deleteRefCombo.getText();
+
+		deleteButton.setEnabled(false);
+		if (ref == null || ref.length() == 0)
+			setControlDecoration(deleteRefDecoration,
+					FieldDecorationRegistry.DEC_REQUIRED,
+					UIText.RefSpecPanel_validationRefDeleteRequired);
+		else if (!isValidRefExpression(ref))
+			setControlDecoration(deleteRefDecoration,
+					FieldDecorationRegistry.DEC_ERROR, NLS.bind(
+							UIText.RefSpecPanel_validationRefInvalidExpression,
+							ref));
+		else if (RefSpec.isWildcard(ref))
+			setControlDecoration(deleteRefDecoration,
+					FieldDecorationRegistry.DEC_ERROR,
+					UIText.RefSpecPanel_validationRefDeleteWildcard);
+		else if (!isRemoteRef(ref))
+			setControlDecoration(
+					deleteRefDecoration,
+					FieldDecorationRegistry.DEC_ERROR,
+					NLS
+							.bind(
+									UIText.RefSpecPanel_validationRefNonExistingRemoteDelete,
+									ref));
+		else {
+			deleteRefDecoration.hide();
+			deleteButton.setEnabled(true);
+		}
+	}
+
+	private void validateSpecs() {
+		// validate spec; display max. 1 error message for user at time
+		final RefSpec oldInvalidSpec = invalidSpec;
+		final RefSpec oldInvalidSpecSameDst = invalidSpecSameDst;
+		errorMessage = null;
+		invalidSpec = null;
+		invalidSpecSameDst = null;
+		for (final RefSpec spec : specs) {
+			errorMessage = validateSpec(spec);
+			if (errorMessage != null) {
+				invalidSpec = spec;
+				break;
+			}
+		}
+		if (errorMessage == null)
+			validateSpecsCrossDst();
+		if (invalidSpec != oldInvalidSpec
+				|| invalidSpecSameDst != oldInvalidSpecSameDst)
+			tableViewer.refresh();
+	}
+
+	private String validateSpec(final RefSpec spec) {
+		final String src = spec.getSource();
+		final String dst = spec.getDestination();
+		final boolean wildcard = spec.isWildcard();
+
+		// check src
+		if (pushSpecs) {
+			if (!isDeleteRefSpec(spec)) {
+				if (src.length() == 0)
+					return UIText.RefSpecPanel_validationSrcUpdateRequired;
+				else if (!wildcard && !isLocalRef(src))
+					return NLS.bind(
+							UIText.RefSpecPanel_validationRefInvalidLocal, src);
+				else if (wildcard && !isValidRefExpression(src))
+					return NLS.bind(
+							UIText.RefSpecPanel_validationRefInvalidExpression,
+							src);
+				// ignore non-matching wildcard specs
+			}
+		} else {
+			if (src == null || src.length() == 0)
+				return UIText.RefSpecPanel_validationSrcUpdateRequired;
+			else if (!wildcard && !isRemoteRef(src))
+				return NLS
+						.bind(
+								UIText.RefSpecPanel_validationRefNonExistingRemote,
+								src);
+			// ignore non-matching wildcard specs
+		}
+
+		// check dst
+		if (dst == null || dst.length() == 0) {
+			if (isDeleteRefSpec(spec))
+				return UIText.RefSpecPanel_validationRefDeleteRequired;
+			return UIText.RefSpecPanel_validationDstRequired;
+		} else if (!isValidRefExpression(dst))
+			return NLS.bind(UIText.RefSpecPanel_validationRefInvalidExpression,
+					dst);
+		else if (isDeleteRefSpec(spec) && !isRemoteRef(dst))
+			return NLS.bind(
+					UIText.RefSpecPanel_validationRefNonExistingRemoteDelete,
+					dst);
+
+		return null;
+	}
+
+	private boolean isInvalidSpec(Object element) {
+		return element == invalidSpec || element == invalidSpecSameDst;
+	}
+
+	private void validateSpecsCrossDst() {
+		final Map<String, RefSpec> dstsSpecsMap = new HashMap<String, RefSpec>();
+		try {
+			for (final RefSpec spec : specs) {
+				if (!spec.isWildcard()) {
+					if (!tryAddDestination(dstsSpecsMap, spec.getDestination(),
+							spec))
+						return;
+				} else {
+					final Collection<String> srcNames;
+					if (pushSpecs)
+						srcNames = localRefNames;
+					else
+						srcNames = remoteRefNames;
+
+					for (final String src : srcNames) {
+						if (spec.matchSource(src)) {
+							final String dst = spec.expandFromSource(src)
+									.getDestination();
+							if (!tryAddDestination(dstsSpecsMap, dst, spec))
+								return;
+						}
+					}
+				}
+			}
+		} finally {
+			matchingAnyRefs = !dstsSpecsMap.isEmpty();
+		}
+	}
+
+	private boolean tryAddDestination(final Map<String, RefSpec> dstsSpecsMap,
+			final String dst, final RefSpec spec) {
+		final RefSpec other = dstsSpecsMap.put(dst, spec);
+		if (other != null) {
+			errorMessage = NLS
+					.bind(
+							UIText.RefSpecPanel_validationSpecificationsOverlappingDestination,
+							dst);
+			invalidSpec = other;
+			invalidSpecSameDst = spec;
+			return false;
+		}
+		return true;
+	}
+
+	private void updateAddPredefinedButton(final Button button,
+			final List<RefSpec> predefined) {
+		boolean enable = false;
+		for (final RefSpec pre : predefined) {
+			if (!specs.contains(pre)) {
+				enable = true;
+				break;
+			}
+		}
+		button.setEnabled(enable);
+	}
+
+	private void updateAddPredefinedButton(Button button,
+			final RefSpec predefined) {
+		button.setEnabled(!specs.contains(predefined));
+	}
+
+	private void updateForceUpdateAllButton() {
+		boolean enable = false;
+		for (final RefSpec spec : specs) {
+			if (!isDeleteRefSpec(spec) && !spec.isForceUpdate()) {
+				enable = true;
+				break;
+			}
+		}
+		forceUpdateAllButton.setEnabled(enable);
+	}
+
+	private void updateRemoveAllSpecButton() {
+		removeAllSpecButton.setEnabled(!specs.isEmpty());
+	}
+
+	private String typeString() {
+		return (pushSpecs ? UIText.RefSpecPanel_push
+				: UIText.RefSpecPanel_fetch);
+	}
+
+	private void addPredefinedRefSpecs(final RefSpec predefined) {
+		addPredefinedRefSpecs(Collections.singletonList(predefined));
+	}
+
+	private void addPredefinedRefSpecs(final List<RefSpec> predefined) {
+		for (final RefSpec pre : predefined) {
+			if (!specs.contains(pre))
+				addRefSpec(pre);
+		}
+	}
+
+	private List<RefContentProposal> createContentProposals(
+			final Collection<Ref> refs, final Ref HEAD) {
+		final TreeSet<Ref> set = new TreeSet<Ref>(new Comparator<Ref>() {
+			public int compare(Ref o1, Ref o2) {
+				// lexicographical ordering by name seems to be fine
+				return o1.getName().compareTo(o2.getName());
+			}
+		});
+		set.addAll(refs);
+		if (HEAD != null)
+			set.add(HEAD);
+
+		final List<RefContentProposal> result = new ArrayList<RefContentProposal>(
+				set.size());
+		for (final Ref r : set)
+			result.add(new RefContentProposal(localDb, r));
+		return result;
+	}
+
+	private List<RefContentProposal> createProposalsFilteredLocal(
+			final List<RefContentProposal> proposals) {
+		final List<RefContentProposal> result = new ArrayList<RefContentProposal>();
+		for (final RefContentProposal p : proposals) {
+			final String content = p.getContent();
+			if (pushSpecs) {
+				if (content.equals(Constants.HEAD)
+						|| content.startsWith(HEADS_PREFIX_S))
+					result.add(p);
+			} else {
+				if (content.startsWith(REMOTES_PREFIX_S))
+					result.add(p);
+			}
+		}
+		return result;
+	}
+
+	private boolean isRemoteRef(String ref) {
+		return remoteRefNames.contains(ref);
+	}
+
+	private boolean isLocalRef(final String ref) {
+		return tryResolveLocalRef(ref) != null;
+	}
+
+	private boolean isMatchingAny(final String ref,
+			final Collection<String> names) {
+		// strip wildcard sign
+		final String prefix = ref.substring(0, ref.length() - 1);
+		for (final String name : names)
+			if (name.startsWith(prefix))
+				return true;
+		return false;
+	}
+
+	private ObjectId tryResolveLocalRef(final String ref) {
+		try {
+			return localDb.resolve(ref);
+		} catch (final IOException e) {
+			Activator.logError(
+					"I/O error occurred during resolving expression: " //$NON-NLS-1$
+							+ ref, e);
+			return null;
+		}
+	}
+
+	private class RefContentProposalProvider implements
+			IContentProposalProvider {
+		private List<RefContentProposal> proposals = Collections.emptyList();
+
+		private final boolean tryResolvingLocally;
+
+		private RefContentProposalProvider(final boolean tryResolvingLocally) {
+			this.tryResolvingLocally = tryResolvingLocally;
+		}
+
+		private void setProposals(final List<RefContentProposal> proposals) {
+			this.proposals = proposals;
+		}
+
+		public IContentProposal[] getProposals(final String contents,
+				int position) {
+			final List<RefContentProposal> result = new ArrayList<RefContentProposal>();
+
+			if (contents.indexOf('*') != -1 || contents.indexOf('?') != -1) {
+				// contents contains wildcards
+
+				// check if contents can be safely added as wildcard spec
+				if (isValidRefExpression(contents))
+					result.add(new RefContentProposal(localDb, contents, null));
+
+				// let's expand wildcards
+				final String regex = ".*" //$NON-NLS-1$
+						+ contents.replace("*", ".*").replace("?", ".?") + ".*"; //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$ //$NON-NLS-5$
+				final Pattern p = Pattern.compile(regex);
+				for (final RefContentProposal prop : proposals)
+					if (p.matcher(prop.getContent()).matches())
+						result.add(prop);
+			} else {
+				for (final RefContentProposal prop : proposals)
+					if (prop.getContent().contains(contents))
+						result.add(prop);
+
+				if (tryResolvingLocally && result.isEmpty()) {
+					final ObjectId id = tryResolveLocalRef(contents);
+					if (id != null)
+						result
+								.add(new RefContentProposal(localDb, contents,
+										id));
+				}
+			}
+			return result.toArray(new IContentProposal[0]);
+		}
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 55f6c87..f2be3c1 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -76,6 +76,77 @@ CloneDestinationPage_fieldRequired={0} is required.
 CloneDestinationPage_browseButton=Browse
 CloneDestinationPage_errorNotEmptyDir={0} is not an empty directory.
 
+RefSpecPanel_clickToChange=[Click to change]
+RefSpecPanel_columnDst=Destination Ref
+RefSpecPanel_columnForce=Force Update
+RefSpecPanel_columnMode=Mode
+RefSpecPanel_columnRemove=Remove
+RefSpecPanel_columnSrc=Source Ref
+RefSpecPanel_creationButton=Add spec
+RefSpecPanel_creationButtonDescription=Add this create/update specification to set of {0} specifications. 
+RefSpecPanel_creationDst=Destination ref:
+RefSpecPanel_creationGroup=Add create/update specificaton
+RefSpecPanel_creationSrc=Source ref:
+RefSpecPanel_deletionButton=Add spec
+RefSpecPanel_deletionButtonDescription=Add this delete specification to set of push specifications.
+RefSpecPanel_deletionGroup=Add delete ref specificaton
+RefSpecPanel_deletionRef=Remote ref to delete:
+RefSpecPanel_dstFetchDescription=Local destination ref(s) to fetch to - create or update.
+RefSpecPanel_dstPushDescription=Remote destination ref(s) to push to - create or update.
+RefSpecPanel_dstDeletionDescription=Remote ref to delete.
+RefSpecPanel_errorRemoteConfigDescription=Can't parse remote configuration URIs.
+RefSpecPanel_errorRemoteConfigTitle=Remote configuration problem
+RefSpecPanel_fetch=fetch
+RefSpecPanel_forceAll=Force update all specs
+RefSpecPanel_forceAllDescription=Set force update setting to all speficications.
+RefSpecPanel_forceDeleteDescription=Delete specification is always unconditional.
+RefSpecPanel_forceFalseDescription=Allow only fast-forward update: old object must merge into new object.
+RefSpecPanel_forceTrueDescription=Allow non-fast-forward update: old object doesn't have to merge to new object.
+RefSpecPanel_modeDelete=Delete
+RefSpecPanel_modeDeleteDescription=This is a delete specification.
+RefSpecPanel_modeUpdate=Update
+RefSpecPanel_modeUpdateDescription=This is a create/update specification.
+RefSpecPanel_predefinedAll=Add all branches spec
+RefSpecPanel_predefinedAllDescription=Add specification covering all branches.
+RefSpecPanel_predefinedConfigured=Add configured {0} specs 
+RefSpecPanel_predefinedConfiguredDescription=Add previously configured specifications for this configured remote (if available).
+RefSpecPanel_predefinedGroup=Add predefined specification
+RefSpecPanel_predefinedTags=Add all tags spec
+RefSpecPanel_predefinedTagsDescription=Add specification covering all tags.
+RefSpecPanel_push=push
+RefSpecPanel_refChooseSome=choose/some/ref
+RefSpecPanel_refChooseSomeWildcard=choose/some/ref/*
+RefSpecPanel_removeAll=Remove all specs
+RefSpecPanel_removeAllDescription=Remove all speficications.
+RefSpecPanel_removeDescription=Click to remove this specification.
+RefSpecPanel_specifications=Specifications for {0}
+RefSpecPanel_srcFetchDescription=Remote source ref(s) to fetch from.
+RefSpecPanel_srcPushDescription=Local source ref(s) to push from.
+RefSpecPanel_srcDeleteDescription=Delete specification always has an empty source ref.
+RefSpecPanel_validationDstInvalidExpression={0} is not a valid ref expression for destination.
+RefSpecPanel_validationDstRequired=Destination ref is required.
+RefSpecPanel_validationRefDeleteRequired=Ref name to delete is required.
+RefSpecPanel_validationRefDeleteWildcard=Delete ref cannot be a wildcard.
+RefSpecPanel_validationRefInvalidExpression={0} is not a valid ref expression.
+RefSpecPanel_validationRefInvalidLocal={0} is not a valid ref in local repository.
+RefSpecPanel_validationRefNonExistingRemote={0} does not exist in remote repository.
+RefSpecPanel_validationRefNonExistingRemoteDelete={0} already does not exist in remote repository.
+RefSpecPanel_validationRefNonMatchingLocal={0} does not match any ref in local repository.
+RefSpecPanel_validationRefNonMatchingRemote={0} does not match any ref in remote repository.
+RefSpecPanel_validationSpecificationsOverlappingDestination=Two or more specifications point to {0} (the same destination).  
+RefSpecPanel_validationSrcUpdateRequired=Source ref is required for update/create specification.
+RefSpecPanel_validationWildcardInconsistent=Wildcard must be set either on both source and destination or on none of them.
+
+RefSpecPage_descriptionFetch=Select refs to fetch.
+RefSpecPage_descriptionPush=Select refs to push.
+RefSpecPage_errorDontMatchSrc=Specifications don't match any existing refs in source repository.
+RefSpecPage_errorTransportDialogMessage=Cannot get remote repository refs.
+RefSpecPage_errorTransportDialogTitle=Transport Error
+RefSpecPage_operationCancelled=Operation cancelled.
+RefSpecPage_saveSpecifications=Save specifications in "{0}" configuration
+RefSpecPage_titleFetch=Fetch Ref Specifications
+RefSpecPage_titlePush=Push Ref Specifications
+
 Decorator_failedLazyLoading=Resource decorator failed to load tree contents on demand.
 QuickDiff_failedLoading=Quick diff failed to obtain file data.
 
-- 
1.5.6.3
