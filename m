From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 26/31] Make Clone's SourceBranchPage more user-friendly
Date: Sun, 17 Aug 2008 22:44:07 +0200
Message-ID: <1219005852-21496-27-git-send-email-marek.zawirski@gmail.com>
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
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:48:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUpAJ-0003WL-8F
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbYHQUp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754809AbYHQUpz
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:55 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbYHQUpx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:45:53 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yPbWkD0CY1Z+SYYPq74+w4xOOjK0ptQi0yKRdSeEFsc=;
        b=THBwzFjDmJhdYv7A9FW0DhYvsAurV3xAmHfq+RiYp4K0cjmAN4WrzH+w+AkSehScxz
         y5SKyy28fYsuLBKUAZoCKMZerhNG5vCpS8HfoUUZ20yccnM3Wkp1y8tdsRch15NQJWPM
         L4X5QkhusyOLZNRkDOgRk9jaucSysTPo+atgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=L3LnUuqapvruT9B8+C7WlrSZ1ZH4cpTlExFGH2q/9e09TXDzdgYP76ZwEVxXL2Jbeo
         vuw0sjLlHAtQZTkO9g9N+hhjaFsnZzo87yg8tl87tZCUCf+YEFwmNhw/RIiOBvDlb1WS
         FqoSwc6OViqtLAs1UQAoY2uySFGB6KxvM8gPw=
Received: by 10.103.18.19 with SMTP id v19mr3460742mui.113.1219005952226;
        Sun, 17 Aug 2008 13:45:52 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id u9sm3174247muf.9.2008.08.17.13.45.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:45:51 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-26-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92659>

-Show page description and progress monitor so user get some feedback
what's happening when we're listing remote refs (which may take some
time... sometimes).
-Don't display error during connection to remote repo.
-Set page error before showing error dialog (avoid flashing over Our
Dear User eyers).
-Enable/disable select all and unselect all buttons in response to
current selections.
-Use ListRemoteOperation instead of our own anonymous class. This
introduces some progress information. It also remove unnecessary
(wrong?) code for cancellation handling and always close Transport (even
if fetch is not supported by Transport).

Perhaps-making-too-big-commit...

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |    9 +-
 .../egit/ui/internal/clone/GitCloneWizard.java     |    1 +
 .../egit/ui/internal/clone/SourceBranchPage.java   |  134 +++++++++-----------
 .../src/org/spearce/egit/ui/uitext.properties      |    3 +-
 4 files changed, 67 insertions(+), 80 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 189b769..9b290f3 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -119,6 +119,9 @@ public class UIText extends NLS {
 	public static String SourceBranchPage_title;
 
 	/** */
+	public static String SourceBranchPage_description;
+
+	/** */
 	public static String SourceBranchPage_branchList;
 
 	/** */
@@ -134,15 +137,15 @@ public class UIText extends NLS {
 	public static String SourceBranchPage_transportError;
 
 	/** */
-	public static String SourceBranchPage_interrupted;
-
-	/** */
 	public static String SourceBranchPage_cannotListBranches;
 
 	/** */
 	public static String SourceBranchPage_remoteListingCancelled;
 
 	/** */
+	public static String SourceBranchPage_cannotCreateTemp;
+
+	/** */
 	public static String CloneDestinationPage_title;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
index 10b2cd4..a69dc52 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
@@ -44,6 +44,7 @@ public class GitCloneWizard extends Wizard implements IImportWizard {
 	public void init(IWorkbench arg0, IStructuredSelection arg1) {
 		setWindowTitle(UIText.GitCloneWizard_title);
 		setDefaultPageImageDescriptor(UIIcons.WIZBAN_IMPORT_REPO);
+		setNeedsProgressMonitor(true);
 		cloneSource = new RepositorySelectionPage(true);
 		validSource = new SourceBranchPage(cloneSource);
 		cloneDestination = new CloneDestinationPage(cloneSource, validSource);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
index 7710612..030419d 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
@@ -10,20 +10,16 @@
 package org.spearce.egit.ui.internal.clone;
 
 import java.io.File;
+import java.io.IOException;
 import java.lang.reflect.InvocationTargetException;
 import java.util.ArrayList;
-import java.util.Collection;
 import java.util.Collections;
 import java.util.Comparator;
 import java.util.List;
 
-import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.IStatus;
-import org.eclipse.core.runtime.NullProgressMonitor;
-import org.eclipse.core.runtime.OperationCanceledException;
 import org.eclipse.core.runtime.Status;
 import org.eclipse.jface.dialogs.ErrorDialog;
-import org.eclipse.jface.operation.IRunnableWithProgress;
 import org.eclipse.osgi.util.NLS;
 import org.eclipse.swt.SWT;
 import org.eclipse.swt.events.SelectionAdapter;
@@ -36,6 +32,7 @@ import org.eclipse.swt.widgets.Composite;
 import org.eclipse.swt.widgets.Label;
 import org.eclipse.swt.widgets.Table;
 import org.eclipse.swt.widgets.TableItem;
+import org.spearce.egit.core.op.ListRemoteOperation;
 import org.spearce.egit.ui.Activator;
 import org.spearce.egit.ui.UIText;
 import org.spearce.egit.ui.internal.components.BaseWizardPage;
@@ -45,8 +42,7 @@ import org.spearce.egit.ui.internal.components.SelectionChangeListener;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
-import org.spearce.jgit.transport.FetchConnection;
-import org.spearce.jgit.transport.Transport;
+import org.spearce.jgit.transport.URIish;
 
 class SourceBranchPage extends BaseWizardPage {
 	private final RepositorySelectionPage sourcePage;
@@ -69,7 +65,8 @@ class SourceBranchPage extends BaseWizardPage {
 		super(SourceBranchPage.class.getName());
 		sourcePage = sp;
 		setTitle(UIText.SourceBranchPage_title);
-
+		setDescription(UIText.SourceBranchPage_description);
+		
 		sourcePage.addSelectionListener(new SelectionChangeListener() {
 			public void selectionChanged() {
 				if (!sourcePage.selectionEquals(validatedRepoSelection))
@@ -134,10 +131,10 @@ class SourceBranchPage extends BaseWizardPage {
 
 		final Composite bPanel = new Composite(panel, SWT.NONE);
 		bPanel.setLayout(new RowLayout());
-		Button b;
-		b = new Button(bPanel, SWT.PUSH);
-		b.setText(UIText.SourceBranchPage_selectAll);
-		b.addSelectionListener(new SelectionAdapter() {
+		final Button selectB;
+		selectB = new Button(bPanel, SWT.PUSH);
+		selectB.setText(UIText.SourceBranchPage_selectAll);
+		selectB.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(final SelectionEvent e) {
 				for (int i = 0; i < refsTable.getItemCount(); i++)
 					refsTable.getItem(i).setChecked(true);
@@ -147,9 +144,9 @@ class SourceBranchPage extends BaseWizardPage {
 				checkPage();
 			}
 		});
-		b = new Button(bPanel, SWT.PUSH);
-		b.setText(UIText.SourceBranchPage_selectNone);
-		b.addSelectionListener(new SelectionAdapter() {
+		final Button unselectB = new Button(bPanel, SWT.PUSH);
+		unselectB.setText(UIText.SourceBranchPage_selectNone);
+		unselectB.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(final SelectionEvent e) {
 				for (int i = 0; i < refsTable.getItemCount(); i++)
 					refsTable.getItem(i).setChecked(false);
@@ -160,6 +157,13 @@ class SourceBranchPage extends BaseWizardPage {
 		});
 		bPanel.setLayoutData(new GridData(SWT.FILL, SWT.TOP, true, false));
 
+		addSelectionListener(new SelectionChangeListener() {
+			public void selectionChanged() {
+				selectB.setEnabled(selectedRefs.size() != availableRefs.size());
+				unselectB.setEnabled(selectedRefs.size() != 0);
+			}
+		});
+
 		setControl(panel);
 		checkPage();
 	}
@@ -210,7 +214,8 @@ class SourceBranchPage extends BaseWizardPage {
 		availableRefs.clear();
 		selectedRefs.clear();
 		refsTable.removeAll();
-		checkPage();
+		setPageComplete(false);
+		setErrorMessage(null);
 		label.getDisplay().asyncExec(new Runnable() {
 			public void run() {
 				revalidateImpl(newRepoSelection);
@@ -222,73 +227,50 @@ class SourceBranchPage extends BaseWizardPage {
 		if (label.isDisposed() || !isCurrentPage())
 			return;
 
+		final ListRemoteOperation listRemoteOp; 
 		try {
-			getContainer().run(true, true, new IRunnableWithProgress() {
-				public void run(final IProgressMonitor pm)
-						throws InvocationTargetException, InterruptedException {
-					final IProgressMonitor monitor;
-					if (pm == null)
-						monitor = new NullProgressMonitor();
-					else
-						monitor = pm;
-					try {
-						final Repository db = new Repository(new File("/tmp"));
-						final Transport tn = Transport.open(db,
-								newRepoSelection.getURI());
-						final Collection<Ref> adv;
-						final FetchConnection fn = tn.openFetch();
-						try {
-							adv = fn.getRefs();
-						} finally {
-							fn.close();
-							tn.close();
-						}
-
-						final Ref idHEAD = fn.getRef(Constants.HEAD);
-						head = null;
-						for (final Ref r : adv) {
-							final String n = r.getName();
-							if (!n.startsWith(Constants.HEADS_PREFIX + "/"))
-								continue;
-							availableRefs.add(r);
-							if (idHEAD == null || head != null)
-								continue;
-							if (r.getObjectId().equals(idHEAD.getObjectId()))
-								head = r;
-						}
-						Collections.sort(availableRefs, new Comparator<Ref>() {
-							public int compare(final Ref o1, final Ref o2) {
-								return o1.getName().compareTo(o2.getName());
-							}
-						});
-						if (idHEAD != null && head == null) {
-							head = idHEAD;
-							availableRefs.add(0, idHEAD);
-						}
-					} catch (Exception err) {
-						throw new InvocationTargetException(err);
-					}
-					monitor.done();
-				}
-			});
+			final URIish uri = newRepoSelection.getURI();
+			final Repository db = new Repository(new File("/tmp"));
+			listRemoteOp = new ListRemoteOperation(db, uri);
+			getContainer().run(true, true, listRemoteOp);
 		} catch (InvocationTargetException e) {
 			Throwable why = e.getCause();
-			if ((why instanceof OperationCanceledException)) {
-				transportError(UIText.SourceBranchPage_remoteListingCancelled);
-				return;
-			} else {
-				ErrorDialog.openError(getShell(),
-						UIText.SourceBranchPage_transportError,
-						UIText.SourceBranchPage_cannotListBranches, new Status(
-								IStatus.ERROR, Activator.getPluginId(), 0, why
-										.getMessage(), why.getCause()));
-				transportError(why.getMessage());
-			}
+			transportError(why.getMessage());
+			ErrorDialog.openError(getShell(),
+					UIText.SourceBranchPage_transportError,
+					UIText.SourceBranchPage_cannotListBranches, new Status(
+							IStatus.ERROR, Activator.getPluginId(), 0, why
+									.getMessage(), why.getCause()));
+			return;
+		} catch (IOException e) {
+			transportError(UIText.SourceBranchPage_cannotCreateTemp);
 			return;
 		} catch (InterruptedException e) {
-			transportError(UIText.SourceBranchPage_interrupted);
+			transportError(UIText.SourceBranchPage_remoteListingCancelled);
 			return;
 		}
+		
+		final Ref idHEAD = listRemoteOp.getRemoteRef(Constants.HEAD);
+		head = null;
+		for (final Ref r : listRemoteOp.getRemoteRefs()) {
+			final String n = r.getName();
+			if (!n.startsWith(Constants.HEADS_PREFIX + "/"))
+				continue;
+			availableRefs.add(r);
+			if (idHEAD == null || head != null)
+				continue;
+			if (r.getObjectId().equals(idHEAD.getObjectId()))
+				head = r;
+		}
+		Collections.sort(availableRefs, new Comparator<Ref>() {
+			public int compare(final Ref o1, final Ref o2) {
+				return o1.getName().compareTo(o2.getName());
+			}
+		});
+		if (idHEAD != null && head == null) {
+			head = idHEAD;
+			availableRefs.add(0, idHEAD);
+		}
 
 		validatedRepoSelection = newRepoSelection;
 		for (final Ref r : availableRefs) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index f46e183..55f6c87 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -54,14 +54,15 @@ RepositorySelectionPage_fileNotFound={0} does not exist.
 RepositorySelectionPage_internalError=Internal error; consult Eclipse error log.
 
 SourceBranchPage_title=Source Git Repository
+SourceBranchPage_description=Select branches to clone from remote repository.
 SourceBranchPage_branchList=Branches of {0}:
 SourceBranchPage_selectAll=Select All
 SourceBranchPage_selectNone=Deselect All
 SourceBranchPage_errorBranchRequired=At least one branch must be selected.
 SourceBranchPage_transportError=Transport Error
 SourceBranchPage_cannotListBranches=Cannot list the available branches.
-SourceBranchPage_interrupted=Connection attempt interrupted.
 SourceBranchPage_remoteListingCancelled=Operation cancelled
+SourceBranchPage_cannotCreateTemp=Couldn't create temporary repository.
 
 
 CloneDestinationPage_title=Local Destination
-- 
1.5.6.3
