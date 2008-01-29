From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH] History page find toolbar.
Date: Tue, 29 Jan 2008 19:39:50 -0200
Message-ID: <1201642790-18508-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 22:35:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJy6o-0001e8-1T
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 22:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757536AbYA2Vej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 16:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757415AbYA2Veh
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 16:34:37 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1195 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756425AbYA2Vec (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 16:34:32 -0500
Received: (qmail 6361 invoked by uid 0); 29 Jan 2008 19:37:13 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 1.284576 secs); 29 Jan 2008 21:37:13 -0000
Received: from unknown (HELO localhost.localdomain) (201.92.27.162)
  by cvxbsd.convex.com.br with SMTP; 29 Jan 2008 21:37:12 -0000
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71998>

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
Hi Robin,

Re-sending the patch.

[]s,
Roger.


 org.spearce.egit.ui/icons/elcl16/find.gif          |  Bin 0 -> 546 bytes
 org.spearce.egit.ui/icons/elcl16/next.gif          |  Bin 0 -> 353 bytes
 org.spearce.egit.ui/icons/elcl16/previous.gif      |  Bin 0 -> 352 bytes
 .../src/org/spearce/egit/ui/FindResults.java       |  184 ++++++++
 .../src/org/spearce/egit/ui/FindToolbar.java       |  442 ++++++++++++++++++++
 .../src/org/spearce/egit/ui/FindToolbarThread.java |  245 +++++++++++
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   97 ++++-
 .../egit/ui/PluginPreferenceInitializer.java       |    6 +
 .../src/org/spearce/egit/ui/UIIcons.java           |   10 +
 .../src/org/spearce/egit/ui/UIPreferences.java     |   12 +
 10 files changed, 984 insertions(+), 12 deletions(-)
 create mode 100644 org.spearce.egit.ui/icons/elcl16/find.gif
 create mode 100644 org.spearce.egit.ui/icons/elcl16/next.gif
 create mode 100644 org.spearce.egit.ui/icons/elcl16/previous.gif
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/FindResults.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbarThread.java

diff --git a/org.spearce.egit.ui/icons/elcl16/find.gif b/org.spearce.egit.ui/icons/elcl16/find.gif
new file mode 100644
index 0000000000000000000000000000000000000000..eba31f7545aaa9ae6917ee49fdc99f8252fd2f1e
GIT binary patch
literal 546
zcmZ?wbhEHb6krfwI2OoI>F>~#m)BXC(^Zt+Rg}|Hl+{^U++9}G)Y;M4Giy#~)4Z<6
z&WSU6rY-KBwq(lm36o|moIPXqyje3A%xzdQuVTgg!UYSbFI_Tq{j!pc%S#un+PZB`
z!<J36_H3WBe*59AJGN}zd2rXR4SV;j*|z7%uD!c<?>}(l;M!wHwx2$_{LrzJ2aa7h
zb$sKcbK5RnI(O;v`Ab)>UA=nl^7UI+Z$7wr^Va>l7jE5qaO>WqyZ0a7dGPqo!zcG1
zK6&)$_M^v79zK5l?Af!&&tE-${`%>QS1(??c=_ht%Qx@ezkB`e!>4y2KY#l4>C2Zd
z-@knR{PpXXZ{NRt|NisWZy@;h@8AEy1QdU=Fmf@}Gw3h?0Vqxw*y|hWo0?l%TXZC(
zr6o1mnq}4OJUl&3MEkVWodV_r_`8a<2^;$@UFIue-70S5vu?e&fl{lOx%>7VZn}!C
z{Q52j4m!*0wW_F^I-GK_cjV~f(KIx(w6GEo>Z|AFQ&5)T6!hZ0WveA;6j;y2z<R5V
Vg@O5fD-#3zmlih0pKXl{)&N)1Y_<RZ

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/elcl16/next.gif b/org.spearce.egit.ui/icons/elcl16/next.gif
new file mode 100644
index 0000000000000000000000000000000000000000..cd84203b6b1081fde08c2c9fc89733c318ffe83d
GIT binary patch
literal 353
zcmZ?wbhEHb6krfwSZc_yEL&iCj=+jMfz<_qs|$qI7748>7F=H{w7yh$W4Z9Aa^Z~?
z!ka3Dw^RX<$o3kMZM7mh>O^+di|lF?-Q6g<r%7yYi`ehG&A;z={kh-u`{Cr@kAP^(
zpGTAbJeu<R>HI%W=l^~-{|^woT>a<enm=!M{`q+P@5f_*f#jFV|Gr%Q`}OkQANT+L
zy!ZFli+{gf{`>vnKPf=*pP+M5YGO%hib8p2Nrr;Er*8m*;!hSvE(UuB9R?r(d6a=I
z^T7N94;`ucX-l4ZY&npy?)s#kt8EsGzUn`ev^7F_ZOYWBl}b?^FI${!xAach^Ta|;
zf{QKlNW97?7Y_Mm1qCGqMFn|wS2kHWDLENwX*pJRW{Fvn5|S(-OyY~gnWF3&7cnk#
MVqjRk%#pzw044ms4gdfE

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/elcl16/previous.gif b/org.spearce.egit.ui/icons/elcl16/previous.gif
new file mode 100644
index 0000000000000000000000000000000000000000..a53606bdb5b8ba72b35e9ab8d90e33cad92ca15a
GIT binary patch
literal 352
zcmZ?wbhEHb6krfwSZc_yEL&iCj=+jMfz<_qs|$qI7748>7F=H{w7yh$W4Z9Aa^Z~?
z!ka3Dw^RX<$o3kMZM7mh>O^+di|lF?-Q6g<r%7yYi`ehG&A;z={kh-u`{Cr@kAP^(
zpGTAbJeu<R>HI%W=l^~-{|^woT>a<enm=!M{`q+P@5f_*f#jFV|Gr%Q`}OkQANT+L
zy!ZFli+{gf{`>vnKPf=*pP+M5YGO%hib8p2Nrr;Er*8m*;!hSvE(UuB9R?r(d6a=I
z<G}m^4;`sih65KRcEm89UU=Z8hzt9S9Ja}dGQ6_=#}41jv1wI$beOHtWr4tpVg)q`
zF1E}g@hYF(c~zTL`2y_))YLUJ_}hiFHMO+_+eLJAbajN=MGXw}^hMjn<}Va$w-;Nz
KVr9D{gEasd9K1CE

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindResults.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindResults.java
new file mode 100644
index 0000000..d3005fe
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindResults.java
@@ -0,0 +1,184 @@
+/*
+ *  Copyright (C) 2008  Roger C. Soares
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License, version 2.1, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.egit.ui;
+
+import java.util.Arrays;
+import java.util.Iterator;
+import java.util.LinkedHashMap;
+import java.util.Map;
+
+/**
+ * Results for the find toolbar. This object stores the rows in the history
+ * table that contain a match to a given pattern.
+ * 
+ * @see FindToolbar
+ * @see FindToolbarThread
+ */
+public class FindResults {
+	private Map<Integer, Integer> matchesMap = new LinkedHashMap<Integer, Integer>();
+
+	Integer[] keysArray;
+
+	private int matchesCount;
+
+	/**
+	 * Returns if the index in the history table matches the find pattern.
+	 * 
+	 * @param index
+	 *            history table item index.
+	 * @return boolean <code>true</code> if the history table
+	 *         <code>index</code> contains a match to the find pattern,
+	 *         <code>false</code> otherwise
+	 */
+	public synchronized boolean isFoundAt(int index) {
+		return matchesMap.containsKey(new Integer(index));
+	}
+
+	/**
+	 * Returns the first table item index after <code>index</code> that
+	 * contains a match to the find pattern.
+	 * 
+	 * @param index
+	 *            the history table item index
+	 * @return the index after <code>index</code> that contains a match.
+	 *         Returns -1 if there isn't a match after <code>index</code>
+	 */
+	public synchronized int getIndexAfter(int index) {
+		Integer[] matches = getkeysArray();
+		int sres = Arrays.binarySearch(matches, new Integer(index));
+		if (sres >= 0 && sres != matches.length - 1) {
+			return matches[sres + 1].intValue();
+		} else if (sres < 0) {
+			sres = -sres - 1;
+			if (sres < matches.length) {
+				return matches[sres].intValue();
+			}
+		}
+
+		return -1;
+	}
+
+	/**
+	 * Returns the first table item index before <code>index</code> that
+	 * contains a match to the find pattern.
+	 * 
+	 * @param index
+	 *            the history table item index
+	 * @return the index before <code>index</code> that contains a match.
+	 *         Returns -1 if there isn't a match before <code>index</code>
+	 */
+	public synchronized int getIndexBefore(int index) {
+		Integer[] matches = getkeysArray();
+		int sres = Arrays.binarySearch(matches, new Integer(index));
+		if (sres >= 0 && sres != 0) {
+			return matches[sres - 1].intValue();
+		} else if (sres < -1) {
+			sres = -sres;
+			return matches[sres - 2].intValue();
+		}
+
+		return -1;
+	}
+
+	/**
+	 * Returns the first table item index that contains a match to the find
+	 * pattern.
+	 * 
+	 * @return the first index that contains a match. Returns -1 if there isn't
+	 *         any match
+	 */
+	public synchronized int getFirstIndex() {
+		Iterator iter = matchesMap.keySet().iterator();
+		if (iter.hasNext()) {
+			return ((Integer) iter.next()).intValue();
+		}
+
+		return -1;
+	}
+
+	/**
+	 * Returns the last table item index that contains a match to the find
+	 * pattern.
+	 * 
+	 * @return the last index that contains a match. Returns -1 if there isn't
+	 *         any match
+	 */
+	public synchronized int getLastIndex() {
+		Integer[] matches = getkeysArray();
+		if (matches.length > 0) {
+			return matches[matches.length - 1].intValue();
+		}
+
+		return -1;
+	}
+
+	/**
+	 * Returns the index in the matches list for the history table item
+	 * <code>index</code>.
+	 * 
+	 * @param index
+	 *            the history table item index
+	 * @return the position of the <code>index</code> in the total matches
+	 *         list. Returns -1 if <code>index</code> doesn't contain a match
+	 */
+	public synchronized int getMatchNumberFor(int index) {
+		Integer ix = matchesMap.get(new Integer(index));
+		if (ix != null) {
+			return ix.intValue();
+		}
+
+		return -1;
+	}
+
+	/**
+	 * @return int
+	 */
+	public int size() {
+		return matchesCount;
+	}
+
+	/**
+	 * Cleans the find results. All match item indexes are removed.
+	 */
+	public synchronized void clear() {
+		matchesMap.clear();
+		keysArray = null;
+		matchesCount = 0;
+	}
+
+	/**
+	 * Adds a history table item index (<code>matchIx</code>) to the find
+	 * results matches list.
+	 * 
+	 * @param matchIx
+	 *            the history table item index that matches a find pattern.
+	 */
+	public synchronized void add(int matchIx) {
+		matchesMap.put(new Integer(matchIx), new Integer(++matchesCount));
+		keysArray = null;
+	}
+
+	private Integer[] getkeysArray() {
+		if (keysArray == null) {
+			keysArray = matchesMap.keySet().toArray(
+					new Integer[matchesMap.size()]);
+		}
+
+		return keysArray;
+	}
+
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
new file mode 100644
index 0000000..310032a
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
@@ -0,0 +1,442 @@
+/*
+ *  Copyright (C) 2008  Roger C. Soares
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License, version 2.1, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.egit.ui;
+
+import java.util.ArrayList;
+import java.util.List;
+
+import org.eclipse.core.runtime.Preferences;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.events.ModifyEvent;
+import org.eclipse.swt.events.ModifyListener;
+import org.eclipse.swt.events.SelectionAdapter;
+import org.eclipse.swt.events.SelectionEvent;
+import org.eclipse.swt.graphics.Color;
+import org.eclipse.swt.graphics.Image;
+import org.eclipse.swt.graphics.Point;
+import org.eclipse.swt.graphics.RGB;
+import org.eclipse.swt.graphics.Rectangle;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.layout.GridLayout;
+import org.eclipse.swt.widgets.Button;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Display;
+import org.eclipse.swt.widgets.Event;
+import org.eclipse.swt.widgets.Label;
+import org.eclipse.swt.widgets.Listener;
+import org.eclipse.swt.widgets.Menu;
+import org.eclipse.swt.widgets.MenuItem;
+import org.eclipse.swt.widgets.ProgressBar;
+import org.eclipse.swt.widgets.Table;
+import org.eclipse.swt.widgets.Text;
+import org.eclipse.swt.widgets.ToolBar;
+import org.eclipse.swt.widgets.ToolItem;
+import org.eclipse.swt.widgets.Widget;
+import org.eclipse.team.core.history.IFileRevision;
+
+/**
+ * A toolbar for the history page.
+ * 
+ * @see FindToolbarThread
+ * @see FindResults
+ * @see GitHistoryPage
+ */
+public class FindToolbar extends Composite {
+	private Color errorBackgroundColor;
+
+	/**
+	 * The results (matches) of the current find operation.
+	 */
+	public final FindResults findResults = new FindResults();
+
+	Preferences prefs = Activator.getDefault().getPluginPreferences();
+
+	List<Listener> eventList = new ArrayList<Listener>();
+
+	private Image nextIcon;
+
+	private Image previousIcon;
+
+	Table historyTable;
+
+	List<IFileRevision> fileRevisions;
+
+	Text patternField;
+
+	Button nextButton;
+
+	Button previousButton;
+
+	Label currentPositionLabel;
+
+	ProgressBar progressBar;
+
+	private String lastErrorPattern;
+
+	/**
+	 * Creates the toolbar.
+	 * 
+	 * @param parent
+	 *            the parent widget
+	 */
+	public FindToolbar(Composite parent) {
+		super(parent, SWT.NULL);
+		createToolbar();
+	}
+
+	private void createToolbar() {
+		errorBackgroundColor = new Color(getDisplay(), new RGB(255, 150, 150));
+		nextIcon = UIIcons.ELCL16_NEXT.createImage();
+		previousIcon = UIIcons.ELCL16_PREVIOUS.createImage();
+
+		GridLayout findLayout = new GridLayout();
+		findLayout.marginHeight = 2;
+		findLayout.marginWidth = 2;
+		findLayout.numColumns = 8;
+		setLayout(findLayout);
+		setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, false));
+
+		Label findLabel = new Label(this, SWT.NULL);
+		findLabel.setText("Find:");
+
+		patternField = new Text(this, SWT.SEARCH);
+		GridData findTextData = new GridData(SWT.FILL, SWT.FILL, true, false);
+		findTextData.minimumWidth = 50;
+		patternField.setLayoutData(findTextData);
+		patternField.setText("");
+		patternField.setTextLimit(100);
+
+		nextButton = new Button(this, SWT.HORIZONTAL);
+		nextButton.setImage(nextIcon);
+		nextButton.setText("next");
+
+		previousButton = new Button(this, SWT.HORIZONTAL);
+		previousButton.setImage(previousIcon);
+		previousButton.setText("previous");
+
+		final ToolBar toolBar = new ToolBar(this, SWT.FLAT);
+		new ToolItem(toolBar, SWT.SEPARATOR);
+
+		final ToolItem prefsItem = new ToolItem(toolBar, SWT.DROP_DOWN);
+		final Menu prefsMenu = new Menu(this.getShell(), SWT.POP_UP);
+		final MenuItem caseItem = new MenuItem(prefsMenu, SWT.CHECK);
+		caseItem.setText("Ignore case");
+		new MenuItem(prefsMenu, SWT.SEPARATOR);
+		final MenuItem commitIdItem = new MenuItem(prefsMenu, SWT.CHECK);
+		commitIdItem.setText("Revision");
+		final MenuItem commentsItem = new MenuItem(prefsMenu, SWT.CHECK);
+		commentsItem.setText("Comments");
+		final MenuItem authorItem = new MenuItem(prefsMenu, SWT.CHECK);
+		authorItem.setText("Author");
+		final MenuItem committerItem = new MenuItem(prefsMenu, SWT.CHECK);
+		committerItem.setText("Committer");
+
+		prefsItem.addListener(SWT.Selection, new Listener() {
+			public void handleEvent(Event event) {
+				if (event.detail == SWT.ARROW) {
+					Rectangle itemBounds = prefsItem.getBounds();
+					Point point = toolBar.toDisplay(itemBounds.x, itemBounds.y
+							+ itemBounds.height);
+					prefsMenu.setLocation(point);
+					prefsMenu.setVisible(true);
+				}
+			}
+		});
+
+		currentPositionLabel = new Label(this, SWT.NULL);
+		GridData totalLabelData = new GridData();
+		totalLabelData.horizontalAlignment = SWT.FILL;
+		totalLabelData.grabExcessHorizontalSpace = true;
+		currentPositionLabel.setLayoutData(totalLabelData);
+		currentPositionLabel.setAlignment(SWT.RIGHT);
+		currentPositionLabel.setText("");
+
+		progressBar = new ProgressBar(this, SWT.HORIZONTAL);
+		GridData findProgressBarData = new GridData();
+		findProgressBarData.heightHint = 12;
+		findProgressBarData.widthHint = 35;
+		progressBar.setLayoutData(findProgressBarData);
+		progressBar.setMinimum(0);
+		progressBar.setMaximum(100);
+
+		final FindToolbar thisToolbar = this;
+		patternField.addModifyListener(new ModifyListener() {
+			public void modifyText(ModifyEvent e) {
+				final FindToolbarThread finder = new FindToolbarThread();
+				finder.pattern = ((Text) e.getSource()).getText();
+				finder.fileRevisions = fileRevisions;
+				finder.toolbar = thisToolbar;
+				finder.ignoreCase = caseItem.getSelection();
+				finder.findInCommitId = commitIdItem.getSelection();
+				finder.findInComments = commentsItem.getSelection();
+				finder.findInAuthor = authorItem.getSelection();
+				finder.findInCommitter = committerItem.getSelection();
+				Display.getDefault().timerExec(200, new Runnable() {
+					public void run() {
+						finder.start();
+					}
+				});
+			}
+		});
+
+		Listener findButtonsListener = new Listener() {
+			public void handleEvent(Event event) {
+				if (patternField.getText().length() > 0
+						&& findResults.size() == 0) {
+					// If the toolbar was cleared and has a pattern typed,
+					// then we redo the find with the new table data.
+					final FindToolbarThread finder = new FindToolbarThread();
+					finder.pattern = patternField.getText();
+					finder.fileRevisions = fileRevisions;
+					finder.toolbar = thisToolbar;
+					finder.ignoreCase = caseItem.getSelection();
+					finder.findInCommitId = commitIdItem.getSelection();
+					finder.findInComments = commentsItem.getSelection();
+					finder.findInAuthor = authorItem.getSelection();
+					finder.findInCommitter = committerItem.getSelection();
+					finder.start();
+					patternField.setSelection(0, 0);
+				} else {
+					int currentIx = historyTable.getSelectionIndex();
+					int newIx = -1;
+					if (event.widget == nextButton) {
+						newIx = findResults.getIndexAfter(currentIx);
+						if (newIx == -1) {
+							newIx = findResults.getFirstIndex();
+						}
+					} else {
+						newIx = findResults.getIndexBefore(currentIx);
+						if (newIx == -1) {
+							newIx = findResults.getLastIndex();
+						}
+					}
+					historyTable.setSelection(newIx);
+					sendEvent(event.widget, newIx);
+
+					String current = null;
+					int currentValue = findResults.getMatchNumberFor(newIx);
+					if (currentValue == -1) {
+						current = "-";
+					} else {
+						current = String.valueOf(currentValue);
+					}
+					currentPositionLabel.setText(current + "/"
+							+ findResults.size());
+				}
+			}
+		};
+		nextButton.addListener(SWT.Selection, findButtonsListener);
+		previousButton.addListener(SWT.Selection, findButtonsListener);
+
+		caseItem.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(SelectionEvent e) {
+				prefs.setValue(UIPreferences.FINDTOOLBAR_IGNORE_CASE, caseItem
+						.getSelection());
+				Activator.getDefault().savePluginPreferences();
+				clear();
+			}
+		});
+		caseItem.setSelection(prefs
+				.getBoolean(UIPreferences.FINDTOOLBAR_IGNORE_CASE));
+
+		commitIdItem.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(SelectionEvent e) {
+				prefs.setValue(UIPreferences.FINDTOOLBAR_COMMIT_ID,
+						commitIdItem.getSelection());
+				Activator.getDefault().savePluginPreferences();
+				clear();
+			}
+		});
+		commitIdItem.setSelection(prefs
+				.getBoolean(UIPreferences.FINDTOOLBAR_COMMIT_ID));
+
+		commentsItem.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(SelectionEvent e) {
+				prefs.setValue(UIPreferences.FINDTOOLBAR_COMMENTS, commentsItem
+						.getSelection());
+				Activator.getDefault().savePluginPreferences();
+				clear();
+			}
+		});
+		commentsItem.setSelection(prefs
+				.getBoolean(UIPreferences.FINDTOOLBAR_COMMENTS));
+
+		authorItem.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(SelectionEvent e) {
+				prefs.setValue(UIPreferences.FINDTOOLBAR_AUTHOR, authorItem
+						.getSelection());
+				Activator.getDefault().savePluginPreferences();
+				clear();
+			}
+		});
+		authorItem.setSelection(prefs
+				.getBoolean(UIPreferences.FINDTOOLBAR_AUTHOR));
+
+		committerItem.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(SelectionEvent e) {
+				prefs.setValue(UIPreferences.FINDTOOLBAR_COMMITTER, committerItem
+						.getSelection());
+				Activator.getDefault().savePluginPreferences();
+				clear();
+			}
+		});
+		committerItem.setSelection(prefs
+				.getBoolean(UIPreferences.FINDTOOLBAR_COMMITTER));
+	}
+
+	@Override
+	public void dispose() {
+		errorBackgroundColor.dispose();
+		nextIcon.dispose();
+		previousIcon.dispose();
+		super.dispose();
+	}
+
+	/**
+	 * Sets the table that will have its selected items changed by this toolbar.
+	 * 
+	 * @param historyTable
+	 *            the history page <code>Table</code>
+	 */
+	public void setHistoryTable(Table historyTable) {
+		this.historyTable = historyTable;
+	}
+
+	/**
+	 * Sets the list to be searched.
+	 * 
+	 * @param fileRevisions
+	 *            the revision list to be searched
+	 */
+	public void setFileRevisions(List<IFileRevision> fileRevisions) {
+		this.fileRevisions = fileRevisions;
+	}
+
+	void progressUpdate(int percent) {
+		int total = findResults.size();
+		currentPositionLabel.setText("-/" + total);
+		currentPositionLabel.setForeground(null);
+		if (total > 0) {
+			nextButton.setEnabled(true);
+			previousButton.setEnabled(true);
+			patternField.setBackground(null);
+		} else {
+			nextButton.setEnabled(false);
+			previousButton.setEnabled(false);
+		}
+		progressBar.setSelection(percent);
+		historyTable.clearAll();
+	}
+
+	void findCompletionUpdate(String pattern, boolean overflow) {
+		int total = findResults.size();
+		if (total > 0) {
+			if (overflow) {
+				currentPositionLabel.setText("Results limit exceed 1/" + total);
+			} else {
+				currentPositionLabel.setText("1/" + total);
+			}
+			int ix = findResults.getFirstIndex();
+			historyTable.setSelection(ix);
+			sendEvent(null, ix);
+
+			patternField.setBackground(null);
+			nextButton.setEnabled(true);
+			previousButton.setEnabled(true);
+			lastErrorPattern = null;
+		} else {
+			if (pattern.length() > 0) {
+				patternField.setBackground(errorBackgroundColor);
+				currentPositionLabel.setText("String not found");
+				// Don't keep beeping every time if the user is deleting
+				// a long not found pattern
+				if (lastErrorPattern == null
+						|| (lastErrorPattern != null && !lastErrorPattern
+								.startsWith(pattern))) {
+					Display.getDefault().beep();
+					nextButton.setEnabled(false);
+					previousButton.setEnabled(false);
+				}
+				lastErrorPattern = pattern;
+			} else {
+				patternField.setBackground(null);
+				currentPositionLabel.setText("");
+				nextButton.setEnabled(false);
+				previousButton.setEnabled(false);
+				lastErrorPattern = null;
+			}
+		}
+		progressBar.setSelection(0);
+		historyTable.clearAll();
+
+		if (overflow) {
+			Display display = Display.getCurrent();
+			currentPositionLabel.setForeground(display
+					.getSystemColor(SWT.COLOR_RED));
+			display.beep();
+		} else {
+			currentPositionLabel.setForeground(null);
+		}
+	}
+
+	/**
+	 * Clears the toolbar.
+	 */
+	public void clear() {
+		patternField.setBackground(null);
+		if (patternField.getText().length() > 0) {
+			patternField.selectAll();
+			nextButton.setEnabled(true);
+			previousButton.setEnabled(true);
+		} else {
+			nextButton.setEnabled(false);
+			previousButton.setEnabled(false);
+		}
+		currentPositionLabel.setText("");
+		progressBar.setSelection(0);
+		lastErrorPattern = null;
+
+		findResults.clear();
+		if (historyTable != null) {
+			historyTable.clearAll();
+		}
+
+		FindToolbarThread.updateGlobalThreadIx();
+	}
+
+	/* private */void sendEvent(Widget widget, int index) {
+		Event event = new Event();
+		event.type = SWT.Selection;
+		event.index = index;
+		event.widget = widget;
+		for (Listener listener : eventList) {
+			listener.handleEvent(event);
+		}
+	}
+
+	/**
+	 * Adds a selection event listener. The toolbar generates events when it
+	 * selects an item in the history table
+	 * 
+	 * @param listener
+	 *            the listener that will receive the event
+	 */
+	public void addSelectionListener(Listener listener) {
+		eventList.add(listener);
+	}
+
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbarThread.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbarThread.java
new file mode 100644
index 0000000..20083f4
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbarThread.java
@@ -0,0 +1,245 @@
+/*
+ *  Copyright (C) 2008  Roger C. Soares
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License, version 2.1, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.egit.ui;
+
+import java.util.List;
+
+import org.eclipse.swt.widgets.Display;
+import org.eclipse.team.core.history.IFileRevision;
+import org.spearce.egit.core.internal.mapping.GitCommitFileRevision;
+
+/**
+ * This class executes the search function for the find toolbar. Only one thread
+ * is executed at a time.
+ * <p>
+ * This class maintains a <code>globalThreadIx</code> internal variable that
+ * is incremented for each new thread started and the current running thread
+ * constantly checks this variable. If the current thread has the same value as
+ * <code>globalThreadIx</code> it continues executing, if it has a lower value
+ * it means that a more recent search needs to be done and the current isn't
+ * necessary any more, so the current thread returns.
+ * </p>
+ * <p>
+ * To avoid consuming all the memory in the system, this class limits the
+ * maximum results it stores.
+ * </p>
+ * 
+ * @see FindToolbar
+ * @see FindResults
+ */
+public class FindToolbarThread extends Thread {
+
+	private static final int MAX_RESULTS = 20000;
+
+	String pattern;
+
+	List<IFileRevision> fileRevisions;
+
+	FindToolbar toolbar;
+
+	boolean ignoreCase;
+
+	boolean findInCommitId;
+
+	boolean findInComments;
+
+	boolean findInAuthor;
+
+	boolean findInCommitter;
+
+	private static Display display = Display.getDefault();
+
+	private static int globalThreadIx = 0;
+
+	private int currentThreadIx;
+
+	/**
+	 * Creates a new object and increments the internal
+	 * <code>globalThreadIx</code> variable causing any earlier running thread
+	 * to return.
+	 */
+	public FindToolbarThread() {
+		super("history_find_thread" + ++globalThreadIx);
+		currentThreadIx = globalThreadIx;
+	}
+
+	public void run() {
+		execFind(currentThreadIx, fileRevisions, pattern, toolbar, ignoreCase,
+				findInCommitId, findInComments, findInAuthor, findInCommitter);
+	}
+
+	private synchronized static void execFind(int threadIx,
+			List<IFileRevision> fileRevisions, final String pattern,
+			final FindToolbar toolbar, boolean ignoreCase,
+			boolean findInCommitId, boolean findInComments,
+			boolean findInAuthor, boolean findInCommitter) {
+		// If it isn't the last event, just ignore it.
+		if (threadIx < globalThreadIx) {
+			return;
+		}
+
+		FindResults findResults = toolbar.findResults;
+		findResults.clear();
+
+		boolean maxResultsOverflow = false;
+		if (pattern.length() > 0 && fileRevisions != null) {
+			String findPattern = pattern;
+			if (ignoreCase) {
+				findPattern = pattern.toLowerCase();
+			}
+
+			long lastUIUpdate = System.currentTimeMillis();
+
+			int totalRevisions = fileRevisions.size();
+			int totalMatches = 0;
+			boolean notFound = true;
+			for (int i = 0; i < totalRevisions; i++) {
+				// If a new find event was generated, ends the current thread.
+				if (display.isDisposed() || threadIx < globalThreadIx) {
+					return;
+				}
+
+				// Updates the toolbar with in process info.
+				if (System.currentTimeMillis() - lastUIUpdate > 500) {
+					final int percentage = (int) (((i + 1F) / totalRevisions) * 100);
+					display.asyncExec(new Runnable() {
+						public void run() {
+							if (toolbar.isDisposed()) {
+								return;
+							}
+							toolbar.progressUpdate(percentage);
+						}
+					});
+					lastUIUpdate = System.currentTimeMillis();
+				}
+
+				// Finds for the pattern in the revision history.
+				notFound = true;
+				IFileRevision fileRevision = fileRevisions.get(i);
+				if (fileRevision instanceof GitCommitFileRevision) {
+					GitCommitFileRevision revision = (GitCommitFileRevision) fileRevision;
+
+					if (findInCommitId) {
+						String contentId = revision.getContentIdentifier();
+						if (contentId != null) {
+							if (ignoreCase) {
+								contentId = contentId.toLowerCase();
+							}
+							if (contentId.indexOf(findPattern) != -1) {
+								totalMatches++;
+								findResults.add(i);
+								notFound = false;
+							}
+						}
+					}
+
+					if (findInComments && notFound) {
+						String comment = revision.getComment();
+						if (comment != null) {
+							if (ignoreCase) {
+								comment = comment.toLowerCase();
+							}
+							if (comment.indexOf(findPattern) != -1) {
+								totalMatches++;
+								findResults.add(i);
+								notFound = false;
+							}
+						}
+					}
+
+					if (findInAuthor && notFound) {
+						String author = revision.getCommit().getAuthor()
+								.getName();
+						if (author != null) {
+							if (ignoreCase) {
+								author = author.toLowerCase();
+							}
+							if (author.indexOf(findPattern) != -1) {
+								totalMatches++;
+								findResults.add(i);
+								notFound = false;
+							}
+						}
+						if (notFound) {
+							String email = revision.getCommit().getAuthor()
+									.getEmailAddress();
+							if (email != null) {
+								if (ignoreCase) {
+									email = email.toLowerCase();
+								}
+								if (email.indexOf(findPattern) != -1) {
+									totalMatches++;
+									findResults.add(i);
+									notFound = false;
+								}
+							}
+						}
+					}
+
+					if (findInCommitter && notFound) {
+						String committer = revision.getCommit().getCommitter()
+								.getName();
+						if (committer != null) {
+							if (ignoreCase) {
+								committer = committer.toLowerCase();
+							}
+							if (committer.indexOf(findPattern) != -1) {
+								totalMatches++;
+								findResults.add(i);
+								notFound = false;
+							}
+						}
+						if (notFound) {
+							String email = revision.getCommit().getCommitter()
+									.getEmailAddress();
+							if (email != null) {
+								if (ignoreCase) {
+									email = email.toLowerCase();
+								}
+								if (email.indexOf(findPattern) != -1) {
+									totalMatches++;
+									findResults.add(i);
+									notFound = false;
+								}
+							}
+						}
+					}
+				}
+
+				if (totalMatches == MAX_RESULTS) {
+					maxResultsOverflow = true;
+					break;
+				}
+			}
+		}
+
+		// Updates the toolbar with the result find info.
+		final boolean overflow = maxResultsOverflow;
+		display.syncExec(new Runnable() {
+			public void run() {
+				if (toolbar.isDisposed()) {
+					return;
+				}
+				toolbar.findCompletionUpdate(pattern, overflow);
+			}
+		});
+	}
+
+	static void updateGlobalThreadIx() {
+		++globalThreadIx;
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 289331c..5cdbcea 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -18,6 +18,7 @@ package org.spearce.egit.ui;
 
 import java.io.IOException;
 import java.text.SimpleDateFormat;
+import java.util.Collections;
 import java.util.Date;
 import java.util.HashMap;
 import java.util.List;
@@ -60,6 +61,8 @@ import org.eclipse.swt.events.MouseEvent;
 import org.eclipse.swt.events.MouseMoveListener;
 import org.eclipse.swt.events.SelectionAdapter;
 import org.eclipse.swt.events.SelectionEvent;
+import org.eclipse.swt.graphics.Font;
+import org.eclipse.swt.graphics.FontData;
 import org.eclipse.swt.graphics.Point;
 import org.eclipse.swt.layout.GridData;
 import org.eclipse.swt.layout.GridLayout;
@@ -111,9 +114,12 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	private static final String PREF_SHOWALLFOLDERVERSIONS = "org.spearce.egit.ui.githistorypage.showallfolderversions";
 	/* private */static final SimpleDateFormat DATETIME_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm");
 	/* private */static final SimpleDateFormat DATETIMETZ_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss z");
+	/* private */Font BANNER_FONT_BOLD;
 
+	private Composite parentComposite;
 	private SashForm localComposite;
 	private SashForm revisionInfoComposite;
+	/* private */FindToolbar findToolbar;
 
 	/* private */Preferences prefs = Activator.getDefault().getPluginPreferences();
 
@@ -124,6 +130,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	/* private */IAction toggleRevDetailAction;
 	/* private */IAction toggleRevCommentAction;
 	/* private */IAction toggleTooltipsAction;
+	/* private */IAction findAction;
 
 	/* private */Table table;
 	private MouseMoveListener tableMouseMoveListener;
@@ -162,16 +169,35 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	}
 
 	public void createControl(Composite parent) {
-		localComposite = new SashForm(parent, SWT.VERTICAL);
-
-		GridLayout layout = new GridLayout();
-		layout.marginHeight = 0;
-		layout.marginWidth = 0;
-		localComposite.setLayout(layout);
+		Font bannerFont = JFaceResources.getBannerFont();
+		BANNER_FONT_BOLD = new Font(parent.getDisplay(), 
+				new FontData(bannerFont.getFontData()[0].getName(), bannerFont.getFontData()[0].getHeight(), SWT.BOLD));
+
+		parentComposite = new Composite(parent, SWT.NULL);
+		GridLayout parentLayout = new GridLayout();
+		parentLayout.marginHeight = 0;
+		parentLayout.marginWidth = 0;
+		parentLayout.verticalSpacing = 0;
+		parentComposite.setLayout(parentLayout);
+		GridData parentData = new GridData(SWT.FILL, SWT.FILL, true, true);
+		parentComposite.setLayoutData(parentData);
+
+		localComposite = new SashForm(parentComposite, SWT.VERTICAL);
 		GridData data = new GridData(SWT.FILL, SWT.FILL, true, true);
-		data.grabExcessVerticalSpace = true;
 		localComposite.setLayoutData(data);
 
+		findToolbar = new FindToolbar(parentComposite);
+		findToolbar.addSelectionListener(new Listener() {
+			public void handleEvent(Event event) {
+				cleanRevisionInfoTextViewers();
+				int ix = table.getSelectionIndex();
+				IFileRevision revision = fileRevisions.get(ix);
+				if(revision instanceof GitCommitFileRevision) {
+					setRevisionInfoTextViewers((GitCommitFileRevision) revision);
+				}
+			}
+		});
+
 		createTable(localComposite);
 
 		revisionInfoComposite = new SashForm(localComposite, SWT.HORIZONTAL);
@@ -278,6 +304,18 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		ResourcesPlugin.getWorkspace().addResourceChangeListener(
 				resourceListener, IResourceChangeEvent.POST_CHANGE);
 
+		findAction = new Action("Fi", UIIcons.ELCL16_FIND) {
+			public void run() {
+				showHideFindToolbar();
+				prefs.setValue(UIPreferences.RESOURCEHISTORY_SHOW_FINDTOOLBAR, findAction.isChecked());
+				Activator.getDefault().savePluginPreferences();
+			}
+		};
+		findAction.setToolTipText("Find");
+		findAction.setChecked(prefs.getBoolean(UIPreferences.RESOURCEHISTORY_SHOW_FINDTOOLBAR));
+		getSite().getActionBars().getToolBarManager()
+				.add(findAction);
+
 		Action showAllRepoVersionsAction = new Action("R") {
 			public void run() {
 				setShowAllRepoVersions(isChecked());
@@ -378,6 +416,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		actionBars.updateActionBars();
 		updateResourceHistoryComposites();
 		updateShowTooltips();
+		showHideFindToolbar();
 
 		localComposite.setWeights(new int[] {65, 35});
 		revisionInfoComposite.setWeights(new int[] {40, 60});
@@ -420,6 +459,18 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		}
 	}
 
+	/* private */void showHideFindToolbar() {
+		boolean showFindToobar = findAction.isChecked();
+
+		if(showFindToobar) {
+			((GridData) findToolbar.getLayoutData()).heightHint = SWT.DEFAULT;
+		} else {
+			((GridData) findToolbar.getLayoutData()).heightHint = 0;
+			findToolbar.clear();
+		}
+		parentComposite.layout();
+	}
+
 	/* private */boolean isShowAllRepoVersions() {
 		return showAllRepoVersions;
 	}
@@ -735,7 +786,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		return sb.toString();
 	}
 
-	/* private */void cleanRevisionInfoTextViewers() {
+	void cleanRevisionInfoTextViewers() {
 		if(revDetailTextViewer != null && revCommentTextViewer != null) {
 			revDetailTextViewer.setDocument(new Document(""));
 			revCommentTextViewer.setDocument(new Document(""));
@@ -756,6 +807,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		GridData data = new GridData(SWT.FILL, SWT.FILL, true, true);
 		table.setLayoutData(data);
 		table.setData("HEAD");
+		findToolbar.setHistoryTable(table);
+		findToolbar.clear();
 		table.addListener(SWT.SetData, new Listener() {
 			public void handleEvent(Event event) {
 				try {
@@ -780,7 +833,12 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 						else
 							item.setForeground(Display.getCurrent().getSystemColor(SWT.COLOR_DARK_GRAY));
 					}
-					item.setFont(0,JFaceResources.getBannerFont());
+
+					if (findToolbar.findResults.isFoundAt(event.index)) {
+						item.setFont(BANNER_FONT_BOLD);
+					} else {
+						item.setFont(0,JFaceResources.getBannerFont());
+					}
 				} catch (Throwable b) {
 					b.printStackTrace();
 				}
@@ -992,7 +1050,16 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 								-1,
 								monitor,
 								isShowAllRepoVersions());
-				fileRevisions = fileHistoryFor.getFileRevisionsList();
+				fileRevisions = Collections.synchronizedList(fileHistoryFor.getFileRevisionsList());
+				findToolbar.setFileRevisions(fileRevisions);
+				Display.getDefault().syncExec(new Runnable() {
+					public void run() {
+						if (findToolbar.isDisposed()) {
+							return;
+						}
+						findToolbar.clear();
+					}
+				});
 				final Map fnewappliedPatches = newappliedPatches;
 				final Map<ObjectId,Tag[]> ftags = newtags;
 	
@@ -1118,11 +1185,11 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	}
 
 	public Control getControl() {
-		return localComposite;
+		return parentComposite;
 	}
 
 	public void setFocus() {
-		localComposite.setFocus();
+		parentComposite.setFocus();
 	}
 
 	public String getDescription() {
@@ -1218,4 +1285,10 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		return result.toString();
 	}
 
+	@Override
+	public void dispose() {
+		BANNER_FONT_BOLD.dispose();
+		super.dispose();
+	}
+
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
index ab89bec..ecb79b8 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
@@ -41,6 +41,12 @@ public class PluginPreferenceInitializer extends AbstractPreferenceInitializer {
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_REV_DETAIL, true);
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_REV_COMMENT, true);
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_TOOLTIPS, false);
+
+		prefs.setDefault(UIPreferences.FINDTOOLBAR_IGNORE_CASE, true);
+		prefs.setDefault(UIPreferences.FINDTOOLBAR_COMMIT_ID, true);
+		prefs.setDefault(UIPreferences.FINDTOOLBAR_COMMENTS, true);
+		prefs.setDefault(UIPreferences.FINDTOOLBAR_AUTHOR, false);
+		prefs.setDefault(UIPreferences.FINDTOOLBAR_COMMITTER, false);
 	}
 
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
index bc3706a..881265d 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
@@ -40,6 +40,13 @@ public class UIIcons {
 	/** Decoration for tracked resources that we want to ignore changes in. */
 	public static final ImageDescriptor OVR_ASSUMEVALID;
 
+	/** Find icon */
+	public static final ImageDescriptor ELCL16_FIND;
+	/** Next arrow icon */
+	public static final ImageDescriptor ELCL16_NEXT;
+	/** Previous arrow icon */
+	public static final ImageDescriptor ELCL16_PREVIOUS;
+
 	private static final URL base;
 
 	static {
@@ -49,6 +56,9 @@ public class UIIcons {
 		OVR_SHARED = map("ovr/shared.gif");
 		OVR_CONFLICT = map("ovr/conflict.gif");
 		OVR_ASSUMEVALID = map("ovr/assumevalid.gif");
+		ELCL16_FIND = map("elcl16/find.gif");
+		ELCL16_NEXT = map("elcl16/next.gif");
+		ELCL16_PREVIOUS = map("elcl16/previous.gif");
 	}
 
 	private static ImageDescriptor map(final String icon) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
index 900023a..cb9443b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
@@ -29,4 +29,16 @@ public class UIPreferences {
 	public final static String RESOURCEHISTORY_SHOW_REV_COMMENT = "resourcehistory_show_rev_comment";
 	/** */
 	public final static String RESOURCEHISTORY_SHOW_TOOLTIPS = "resourcehistory_show_tooltips";
+	/** */
+	public final static String RESOURCEHISTORY_SHOW_FINDTOOLBAR = "resourcehistory_show_findtoolbar";
+	/** */
+	public final static String FINDTOOLBAR_IGNORE_CASE = "findtoolbar_ignore_case";
+	/** */
+	public final static String FINDTOOLBAR_COMMIT_ID = "findtoolbar_commit_id";
+	/** */
+	public final static String FINDTOOLBAR_COMMENTS = "findtoolbar_comments";
+	/** */
+	public final static String FINDTOOLBAR_AUTHOR = "findtoolbar_author";
+	/** */
+	public final static String FINDTOOLBAR_COMMITTER = "findtoolbar_committer";
 }
-- 
1.5.3.7
