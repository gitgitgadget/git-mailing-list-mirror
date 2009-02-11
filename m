From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH v2 09/12] Implement icon and text decorations of various resource states
Date: Wed, 11 Feb 2009 19:40:11 +0100
Message-ID: <1234377614-23798-10-git-send-email-torarnv@gmail.com>
References: <1234377614-23798-1-git-send-email-torarnv@gmail.com>
 <1234377614-23798-2-git-send-email-torarnv@gmail.com>
 <1234377614-23798-3-git-send-email-torarnv@gmail.com>
 <1234377614-23798-4-git-send-email-torarnv@gmail.com>
 <1234377614-23798-5-git-send-email-torarnv@gmail.com>
 <1234377614-23798-6-git-send-email-torarnv@gmail.com>
 <1234377614-23798-7-git-send-email-torarnv@gmail.com>
 <1234377614-23798-8-git-send-email-torarnv@gmail.com>
 <1234377614-23798-9-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:42:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK28-0005RI-NQ
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756781AbZBKSk0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 13:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756726AbZBKSkZ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:40:25 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:15213 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756974AbZBKSkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:40:16 -0500
Received: by fg-out-1718.google.com with SMTP id 16so108720fgg.17
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 10:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=2trZI2yKXQlThdaeZUtOc24GueSNYy38j6L2SA4yjeY=;
        b=szD5W2Wd96BeZ6i3KPf3dTudfmaJ3Ls9eXA+zGjqCtCgL1auZIV3rsbj1iJutdUgJL
         Pn6zuKW0qYNWQ1Bc7RZLm9kSOpZ2TjJNw22Pq8hcLXNOtRQHSPQhV+FxTu3dOI2rCxoi
         dDpFmeUdkT3tL30u39dfBHKRd4oxVM9usqJ3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qHM7NCM9EaYTArnReQP1rEnA1aPsSXNRfwCyeOGs8SWvm/xXP9DoMzRp932qQBpYZ6
         3lWyEn1Dso2duG3+GmsXDjMOOn7dXVTS9ERwvr9wzalqJ62Ae+IzXs/veZhHT52+Ckwg
         2eAxGzLqdmRyQuv74OatxAoDWztC7D1GJJgn8=
Received: by 10.86.84.18 with SMTP id h18mr842037fgb.69.1234377614891;
        Wed, 11 Feb 2009 10:40:14 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 3sm4855521fge.42.2009.02.11.10.39.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 10:39:41 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id C9894468006; Wed, 11 Feb 2009 19:40:14 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1234377614-23798-9-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109483>

  - Dirty
  - Staged
  - Conflict
  - Assume valid

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 org.spearce.egit.ui/icons/ovr/assume_valid.gif     |  Bin 0 -> 85 byte=
s
 org.spearce.egit.ui/icons/ovr/assumevalid.gif      |  Bin 64 -> 0 byte=
s
 org.spearce.egit.ui/icons/ovr/conflict.gif         |  Bin 64 -> 194 by=
tes
 org.spearce.egit.ui/icons/ovr/pending_add.gif      |  Bin 64 -> 0 byte=
s
 org.spearce.egit.ui/icons/ovr/pending_remove.gif   |  Bin 111 -> 0 byt=
es
 org.spearce.egit.ui/icons/ovr/staged.gif           |  Bin 0 -> 114 byt=
es
 org.spearce.egit.ui/icons/ovr/staged_added.gif     |  Bin 0 -> 169 byt=
es
 org.spearce.egit.ui/icons/ovr/staged_removed.gif   |  Bin 0 -> 176 byt=
es
 .../egit/ui/PluginPreferenceInitializer.java       |    3 +
 .../src/org/spearce/egit/ui/UIIcons.java           |   15 +-
 .../src/org/spearce/egit/ui/UIPreferences.java     |    6 +
 .../src/org/spearce/egit/ui/UIText.java            |   17 +-
 .../decorators/GitLightweightDecorator.java        |  299 ++++++++++++=
+++++---
 .../internal/decorators/IDecoratableResource.java  |   46 +++
 .../preferences/GitDecoratorPreferencePage.java    |  152 +++++++++--
 .../src/org/spearce/egit/ui/uitext.properties      |   15 +-
 16 files changed, 477 insertions(+), 76 deletions(-)
 create mode 100644 org.spearce.egit.ui/icons/ovr/assume_valid.gif
 delete mode 100644 org.spearce.egit.ui/icons/ovr/assumevalid.gif
 delete mode 100644 org.spearce.egit.ui/icons/ovr/pending_add.gif
 delete mode 100644 org.spearce.egit.ui/icons/ovr/pending_remove.gif
 create mode 100644 org.spearce.egit.ui/icons/ovr/staged.gif
 create mode 100644 org.spearce.egit.ui/icons/ovr/staged_added.gif
 create mode 100644 org.spearce.egit.ui/icons/ovr/staged_removed.gif

diff --git a/org.spearce.egit.ui/icons/ovr/assume_valid.gif b/org.spear=
ce.egit.ui/icons/ovr/assume_valid.gif
new file mode 100644
index 0000000000000000000000000000000000000000..b6d7167cb38b147aa0fcc11=
5121f3166276f6688
GIT binary patch
literal 85
zcmZ?wbhEHb<Y3@pSj5Wk|Nno6&}sGa_b)s3!M=3DV!hzkaaKUo+V7+4u}Ks=3DCI24<;<
gU94*oY!sY|O?Vb;E(m>L;^NQ~(4hBvvkHSX0J)kQGXMYp

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/ovr/assumevalid.gif b/org.spearc=
e.egit.ui/icons/ovr/assumevalid.gif
deleted file mode 100644
index c7262ed4e3f9437a51806f70fbc851e3a6f951d3..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 64
zcmZ?wbhEHbWM|-D_{abP{~H+o{|7M?f3h$#FfcRdfH)v|1}4Ed_6CP$GF;`pupzry
Lj9oc|fx#L8z0(dE

diff --git a/org.spearce.egit.ui/icons/ovr/conflict.gif b/org.spearce.e=
git.ui/icons/ovr/conflict.gif
index b444be94a2d09561b212138b1514d5c07610cc07..fce456a49a0d6b19feaef4e=
1fb8615d8083c674c 100644
GIT binary patch
literal 194
zcmZ?wbhEHb<YwSvIKsfNSXBI}k=3Daul+s7VW3poWA@dz#iA)&<rB8vn>o~Y|S);7GW
zV|+_e`Ie;0T?OrX8YZiZHCF1XE!R_9uBNn9O6ro5(lQ147ctTQ!GHl3DE?$&WMGhD
z&;bd9>||iIU!ayIII}ZDEm63-?}`D3QE8g^;`e8!hE6+n_+o~G)HE-)gh(9`Kkf%@
d8(7v&JK{arFoJ8^;WC#KQvzQ|Td^=3D$0|4|&KIZ@c

literal 64
zcmZ?wbhEHbWM|-D_{hM}z`*dI0SXj<vM@3*Ffr(W_#k-(Cc!EF3&kHON*Qck_+rIG
KhIgS14AuZ~{td7I

diff --git a/org.spearce.egit.ui/icons/ovr/pending_add.gif b/org.spearc=
e.egit.ui/icons/ovr/pending_add.gif
deleted file mode 100644
index f2306024b2872e50db4143a790bca93189ef8d5f..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 64
zcmZ?wbhEHbWM|-Dn8?6je1?HxCd2>#{}~t<6o0a?iZC!S=3Dm6OaAbAER!723%B?Oj5
R<v1{ie-xgi8_2+54FJ_W4pRUC

diff --git a/org.spearce.egit.ui/icons/ovr/pending_remove.gif b/org.spe=
arce.egit.ui/icons/ovr/pending_remove.gif
deleted file mode 100644
index 4ecce038e66f904af8345f88c2c007706a4bc3d0..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 111
zcmZ?wbhEHbWM|-D*v!E2;Qr&bwzj&uy5i#Ew6wIy$jG3eAU{99|Ns9pU;~OjSy)AY
sT6I8@ATt<PWC|uQx@~OiE8rFvPw;68lw@ATcdKBBRM#03Aw~vk0Ht*t9{>OV

diff --git a/org.spearce.egit.ui/icons/ovr/staged.gif b/org.spearce.egi=
t.ui/icons/ovr/staged.gif
new file mode 100644
index 0000000000000000000000000000000000000000..dc0b8c01673b32fde0f9b11=
c8302ad1ca0a1e902
GIT binary patch
literal 114
zcmZ?wbhEHb<Y3@n*v!E2>(@D15q3p!E=3D^fpC2=3Dk-SzZ$rK|38WV-+D!6DfNgu|P{%
zPh+VN3xogv|1&T!DE?$&WMJT9&;hc6CU7t?u*hFHX*qrG>5bPI{QDmDwl|kFq+1-m
RA=3D-DKlJ_A?g`5k6H30u&A6)<d

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/ovr/staged_added.gif b/org.spear=
ce.egit.ui/icons/ovr/staged_added.gif
new file mode 100644
index 0000000000000000000000000000000000000000..c65d16a191f259e0feb55c9=
244e7545c9063f2ee
GIT binary patch
literal 169
zcmZ?wbhEHb<Y3@nI3mv=3D<D+lc6C~rUFXwNhSM8ymWTTpFZ&2l?k?oi~MbDtt!(w8P
zX13k6n|3NGHU_nBa)HL3YfROWEiL<k^{d^EU9;|4ZK_}8(Y4mhqBp>NLa2<7LGmO+
zwPfqgH75W6|5yCU!pOiN&!EEq1Ry&ZSk)e=3D_dO9$3EpXP>xYb&Yrys66%*4FPo$Ud
U`8i&abQEg7#HJw7%D`X^09=3Dzc+W-In

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/ovr/staged_removed.gif b/org.spe=
arce.egit.ui/icons/ovr/staged_removed.gif
new file mode 100644
index 0000000000000000000000000000000000000000..8aaadfb9b9300594a344898=
6650b82841398287c
GIT binary patch
literal 176
zcmZ?wbhEHb<Y3@nI3mX2@9!TQ8ygf96c`wooSa-&SLf&FS5i_E8XDTx)|Q{29~>Oq
z-rk;)l2TY$7#SHE5D<`;mlqcoS6p2D;Qr&HqN4x*|1;nQia%Kx85qPEbU;c#b~3Q)
zE>P`DcJ&Dn4ViXC=3DE@Y0u&)L|A2*0x3h8BCs@CD4#4P3#=3D;_K}%6y8ku!Vua8UVS)
BGb{iA

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferen=
ceInitializer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/Plugin=
PreferenceInitializer.java
index 7465444..a3196f4 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceIniti=
alizer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceIniti=
alizer.java
@@ -44,6 +44,9 @@ public void initializeDefaultPreferences() {
 				UIText.DecoratorPreferencesPage_projectFormatDefault);
 		prefs.setDefault(UIPreferences.DECORATOR_SHOW_TRACKED_ICON, true);
 		prefs.setDefault(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON, true);
+		prefs.setDefault(UIPreferences.DECORATOR_SHOW_STAGED_ICON, true);
+		prefs.setDefault(UIPreferences.DECORATOR_SHOW_CONFLICTS_ICON, true);
+		prefs.setDefault(UIPreferences.DECORATOR_SHOW_ASSUME_VALID_ICON, tru=
e);
=20
 		w =3D new int[] { 500, 500 };
 		UIPreferences.setDefault(prefs,
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java b=
/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
index 4c0d189..952816c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
@@ -18,11 +18,15 @@
  * Icons for the the Eclipse plugin. Mostly decorations.
  */
 public class UIIcons {
+
+	/** Decoration for resource in the index but not yet committed. */
+	public static final ImageDescriptor OVR_STAGED;
+
 	/** Decoration for resource added to index but not yet committed. */
-	public static final ImageDescriptor OVR_PENDING_ADD;
+	public static final ImageDescriptor OVR_STAGED_ADD;
=20
 	/** Decoration for resource removed from the index but not commit. */
-	public static final ImageDescriptor OVR_PENDING_REMOVE;
+	public static final ImageDescriptor OVR_STAGED_REMOVE;
=20
 	/** Decoration for resource not being tracked by Git */
 	public static final ImageDescriptor OVR_UNTRACKED;
@@ -84,11 +88,12 @@
=20
 	static {
 		base =3D init();
-		OVR_PENDING_ADD =3D map("ovr/pending_add.gif");
-		OVR_PENDING_REMOVE =3D map("ovr/pending_remove.gif");
+		OVR_STAGED =3D map("ovr/staged.gif");
+		OVR_STAGED_ADD =3D map("ovr/staged_added.gif");
+		OVR_STAGED_REMOVE =3D map("ovr/staged_removed.gif");
 		OVR_UNTRACKED =3D map("ovr/untracked.gif");
 		OVR_CONFLICT =3D map("ovr/conflict.gif");
-		OVR_ASSUMEVALID =3D map("ovr/assumevalid.gif");
+		OVR_ASSUMEVALID =3D map("ovr/assume_valid.gif");
 		ELCL16_FIND =3D map("elcl16/find.gif");
 		ELCL16_NEXT =3D map("elcl16/next.gif");
 		ELCL16_PREVIOUS =3D map("elcl16/previous.gif");
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.=
java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
index 7916cea..e812716 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
@@ -64,6 +64,12 @@
 	public final static String DECORATOR_SHOW_TRACKED_ICON =3D "decorator=
_show_tracked_icon";
 	/** */
 	public final static String DECORATOR_SHOW_UNTRACKED_ICON =3D "decorat=
or_show_untracked_icon";
+	/** */
+	public final static String DECORATOR_SHOW_STAGED_ICON =3D "decorator_=
show_staged_icon";
+	/** */
+	public final static String DECORATOR_SHOW_CONFLICTS_ICON =3D "decorat=
or_show_conflicts_icon";
+	/** */
+	public final static String DECORATOR_SHOW_ASSUME_VALID_ICON =3D "deco=
rator_show_assume_valid_icon";
=20
 	/**
 	 * Get the preference values associated with a fixed integer array.
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/=
org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 60e4eaa..7e26337 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -968,12 +968,18 @@
 	public static String DecoratorPreferencesPage_generalTabFolder;
=20
 	/** */
-	public static String DecoratorPreferencesPage_nameResourceVariable;
+	public static String DecoratorPreferencesPage_bindingResourceName;
=20
 	/** */
 	public static String DecoratorPreferencesPage_bindingBranchName;
=20
 	/** */
+	public static String DecoratorPreferencesPage_bindingDirtyFlag;
+
+	/** */
+	public static String DecoratorPreferencesPage_bindingStagedFlag;
+
+	/** */
 	public static String DecoratorPreferencesPage_selectFormats;
=20
 	/** */
@@ -994,6 +1000,15 @@
 	/** */
 	public static String DecoratorPreferencesPage_iconsShowUntracked;
=20
+	/** */
+	public static String DecoratorPreferencesPage_iconsShowStaged;
+
+	/** */
+	public static String DecoratorPreferencesPage_iconsShowConflicts;
+
+	/** */
+	public static String DecoratorPreferencesPage_iconsShowAssumeValid;
+
 	static {
 		initializeMessages(UIText.class.getPackage().getName() + ".uitext",
 				UIText.class);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decor=
ators/GitLightweightDecorator.java b/org.spearce.egit.ui/src/org/spearc=
e/egit/ui/internal/decorators/GitLightweightDecorator.java
index b20070a..c23ce24 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/G=
itLightweightDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/G=
itLightweightDecorator.java
@@ -60,9 +60,12 @@
 import org.spearce.egit.ui.UIIcons;
 import org.spearce.egit.ui.UIPreferences;
 import org.spearce.egit.ui.UIText;
+import org.spearce.egit.ui.internal.decorators.IDecoratableResource.St=
aged;
 import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheEntry;
 import org.spearce.jgit.dircache.DirCacheIterator;
 import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.IndexChangedEvent;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.RefsChangedEvent;
@@ -200,6 +203,20 @@ public void decorate(Object element, IDecoration d=
ecoration) {
=20
 		private boolean ignored =3D false;
=20
+		private boolean dirty =3D false;
+
+		private boolean conflicts =3D false;
+
+		private boolean assumeValid =3D false;
+
+		private Staged staged =3D Staged.NOT_STAGED;
+
+		static final int T_HEAD =3D 0;
+
+		static final int T_INDEX =3D 1;
+
+		static final int T_WORKSPACE =3D 2;
+
 		public DecoratableResourceAdapter(IResource resourceToWrap)
 				throws IOException {
 			resource =3D resourceToWrap;
@@ -207,59 +224,162 @@ public DecoratableResourceAdapter(IResource reso=
urceToWrap)
 			repository =3D mapping.getRepository();
 			headId =3D repository.resolve(Constants.HEAD);
=20
-			initializeValues();
+			switch (resource.getType()) {
+			case IResource.FILE:
+				extractFileProperties();
+				break;
+			case IResource.FOLDER:
+				extractContainerProperties();
+				break;
+			case IResource.PROJECT:
+				extractProjectProperties();
+				break;
+			}
 		}
=20
-		/**
-		 * Initialize the various values that are used for making decoration
-		 * decisions later on.
-		 *=20
-		 * We might as well pre-load these now, instead of using lazy
-		 * initialization, because they are all read by the decorator when
-		 * building variable bindings and computing the preferred overlay.
-		 *=20
-		 * @throws IOException
-		 */
-		private void initializeValues() throws IOException {
-
-			// Resolve current branch
-			branch =3D repository.getBranch();
+		private void extractFileProperties() throws IOException {
+			TreeWalk treeWalk =3D createHeadVsIndexTreeWalk();
+			if (treeWalk =3D=3D null)
+				return;
=20
-			// Resolve tracked state
-			if (getType() =3D=3D IResource.PROJECT) {
+			if (treeWalk.next())
 				tracked =3D true;
+			else
+				return;
+
+			// TODO: Also read ignores from .git/info/excludes et al.
+			if (Team.isIgnoredHint(resource)) {
+				ignored =3D true;
+				return;
+			}
+
+			final DirCacheIterator indexIterator =3D treeWalk.getTree(T_INDEX,
+					DirCacheIterator.class);
+			final DirCacheEntry indexEntry =3D indexIterator !=3D null ? indexI=
terator
+					.getDirCacheEntry()
+					: null;
+
+			if (indexEntry =3D=3D null) {
+				staged =3D Staged.REMOVED;
 			} else {
-				final TreeWalk treeWalk =3D new TreeWalk(repository);
-
-				Set<String> repositoryPaths =3D Collections.singleton(mapping
-						.getRepoRelativePath(resource));
-				if (!(repositoryPaths.isEmpty() || repositoryPaths.contains(""))) =
{
-					treeWalk.setFilter(PathFilterGroup
-							.createFromStrings(repositoryPaths));
-					treeWalk.setRecursive(treeWalk.getFilter()
-							.shouldBeRecursive());
-					treeWalk.reset();
-
-					if (headId !=3D null)
-						treeWalk.addTree(new RevWalk(repository)
-								.parseTree(headId));
-					else
-						treeWalk.addTree(new EmptyTreeIterator());
+				if (indexEntry.isAssumeValid()) {
+					dirty =3D false;
+					assumeValid =3D true;
+				} else if (indexEntry.getStage() > 0) {
+					conflicts =3D true;
+				} else if (treeWalk.getRawMode(T_HEAD) =3D=3D FileMode.MISSING
+						.getBits()) {
+					staged =3D Staged.ADDED;
+				} else {
+					long indexEntryLastModified =3D indexEntry.getLastModified();
+					long resourceLastModified =3D resource.getLocalTimeStamp();
+
+					// C-Git under Windows stores timestamps with 1-seconds
+					// resolution, so we need to check to see if this is the
+					// case here, and possibly fix the timestamp of the resource
+					// to match the resolution of the index.
+					if (indexEntryLastModified % 1000 =3D=3D 0) {
+						resourceLastModified -=3D resourceLastModified % 1000;
+					}
+
+					if (resourceLastModified !=3D indexEntryLastModified) {
+						// TODO: Consider doing a content check here, to rule
+						// out false positives, as we might get mismatch between
+						// timestamps, even if the content is the same
+						dirty =3D true;
+					}
=20
-					treeWalk.addTree(new DirCacheIterator(DirCache
-							.read(repository)));
-					if (treeWalk.next()) {
-						tracked =3D true;
+					if (treeWalk.getRawMode(T_HEAD) !=3D treeWalk
+							.getRawMode(T_INDEX)
+							|| !treeWalk.idEqual(T_HEAD, T_INDEX)) {
+						staged =3D Staged.MODIFIED;
 					}
 				}
 			}
=20
-			// Resolve ignored state (currently only reads the global Eclipse
-			// ignores)
+		}
+
+		private void extractContainerProperties() throws IOException {
+			TreeWalk treeWalk =3D createHeadVsIndexTreeWalk();
+			if (treeWalk =3D=3D null)
+				return;
+
+			if (treeWalk.next())
+				tracked =3D true;
+			else
+				return;
+
 			// TODO: Also read ignores from .git/info/excludes et al.
 			if (Team.isIgnoredHint(resource)) {
 				ignored =3D true;
+				return;
 			}
+
+			// TODO: Compute dirty state for folder, using ContainerTreeIterato=
r
+			// and ContainerDiffFilter
+
+		}
+
+		private void extractProjectProperties() throws IOException {
+			branch =3D repository.getBranch();
+			tracked =3D true;
+
+			// TODO: Compute dirty state for folder, using ContainerTreeIterato=
r
+			// and ContainerDiffFilter
+
+		}
+
+		/**
+		 * Adds a filter to the specified tree walk limiting the results to =
only
+		 * those matching the resource specified by
+		 * <code>resourceToFilterBy</code>
+		 * <p>
+		 * If the resource does not exists in the current repository, or it =
has
+		 * an empty path (it is the project itself), the filter is not added=
,
+		 * and the method returns <code>null</code>.
+		 *=20
+		 * @param treeWalk
+		 *            the tree walk to add the filter to
+		 * @param resourceToFilterBy
+		 *            the resource to filter by
+		 *=20
+		 * @return <code>true</code> if the filter could be added,
+		 *         <code>false</code> otherwise
+		 */
+		private boolean addResourceFilter(final TreeWalk treeWalk,
+				final IResource resourceToFilterBy) {
+			Set<String> repositoryPaths =3D Collections.singleton(mapping
+					.getRepoRelativePath(resourceToFilterBy));
+			if (repositoryPaths.isEmpty() || repositoryPaths.contains(""))
+				return false;
+
+			treeWalk.setFilter(PathFilterGroup
+					.createFromStrings(repositoryPaths));
+			return true;
+		}
+
+		/**
+		 * Helper method to create a new tree walk between HEAD and the inde=
x.
+		 *=20
+		 * @return the created tree walk, or null if it could not be created
+		 * @throws IOException
+		 *             if there were errors when creating the tree walk
+		 */
+		private TreeWalk createHeadVsIndexTreeWalk() throws IOException {
+			final TreeWalk treeWalk =3D new TreeWalk(repository);
+			if (!addResourceFilter(treeWalk, resource))
+				return null;
+
+			treeWalk.setRecursive(treeWalk.getFilter().shouldBeRecursive());
+			treeWalk.reset();
+
+			if (headId !=3D null)
+				treeWalk.addTree(new RevWalk(repository).parseTree(headId));
+			else
+				treeWalk.addTree(new EmptyTreeIterator());
+
+			treeWalk.addTree(new DirCacheIterator(DirCache.read(repository)));
+			return treeWalk;
 		}
=20
 		public String getName() {
@@ -281,6 +401,22 @@ public boolean isTracked() {
 		public boolean isIgnored() {
 			return ignored;
 		}
+
+		public boolean isDirty() {
+			return dirty;
+		}
+
+		public Staged staged() {
+			return staged;
+		}
+
+		public boolean hasConflicts() {
+			return conflicts;
+		}
+
+		public boolean isAssumeValid() {
+			return assumeValid;
+		}
 	}
=20
 	/**
@@ -298,6 +434,12 @@ public boolean isIgnored() {
 		/** */
 		public static final String BINDING_BRANCH_NAME =3D "branch"; //$NON-=
NLS-1$
=20
+		/** */
+		public static final String BINDING_DIRTY_FLAG =3D "dirty"; //$NON-NL=
S-1$
+
+		/** */
+		public static final String BINDING_STAGED_FLAG =3D "staged"; //$NON-=
NLS-1$
+
 		private IPreferenceStore store;
=20
 		/**
@@ -325,10 +467,26 @@ public ImageData getImageData() {
=20
 		private static ImageDescriptor untrackedImage;
=20
+		private static ImageDescriptor stagedImage;
+
+		private static ImageDescriptor stagedAddedImage;
+
+		private static ImageDescriptor stagedRemovedImage;
+
+		private static ImageDescriptor conflictImage;
+
+		private static ImageDescriptor assumeValidImage;
+
 		static {
 			trackedImage =3D new CachedImageDescriptor(TeamImages
 					.getImageDescriptor(ISharedImages.IMG_CHECKEDIN_OVR));
 			untrackedImage =3D new CachedImageDescriptor(UIIcons.OVR_UNTRACKED)=
;
+			stagedImage =3D new CachedImageDescriptor(UIIcons.OVR_STAGED);
+			stagedAddedImage =3D new CachedImageDescriptor(UIIcons.OVR_STAGED_A=
DD);
+			stagedRemovedImage =3D new CachedImageDescriptor(
+					UIIcons.OVR_STAGED_REMOVE);
+			conflictImage =3D new CachedImageDescriptor(UIIcons.OVR_CONFLICT);
+			assumeValidImage =3D new CachedImageDescriptor(UIIcons.OVR_ASSUMEVA=
LID);
 		}
=20
 		/**
@@ -354,6 +512,9 @@ public DecorationHelper(IPreferenceStore preference=
sStore) {
 		 */
 		public void decorate(IDecoration decoration,
 				IDecoratableResource resource) {
+			if (resource.isIgnored())
+				return;
+
 			decorateText(decoration, resource);
 			decorateIcons(decoration, resource);
 		}
@@ -379,22 +540,49 @@ private void decorateText(IDecoration decoration,
 			Map<String, String> bindings =3D new HashMap<String, String>();
 			bindings.put(BINDING_RESOURCE_NAME, resource.getName());
 			bindings.put(BINDING_BRANCH_NAME, resource.getBranch());
+			bindings.put(BINDING_DIRTY_FLAG, resource.isDirty() ? ">" : null);
+			bindings.put(BINDING_STAGED_FLAG,
+					resource.staged() !=3D Staged.NOT_STAGED ? "*" : null);
=20
 			decorate(decoration, format, bindings);
 		}
=20
 		private void decorateIcons(IDecoration decoration,
 				IDecoratableResource resource) {
-			if (resource.isIgnored())
-				return;
+			ImageDescriptor overlay =3D null;
=20
 			if (resource.isTracked()) {
 				if (store.getBoolean(UIPreferences.DECORATOR_SHOW_TRACKED_ICON))
-					decoration.addOverlay(trackedImage);
-			} else if (store
-					.getBoolean(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON)) {
-				decoration.addOverlay(untrackedImage);
+					overlay =3D trackedImage;
+
+				if (store
+						.getBoolean(UIPreferences.DECORATOR_SHOW_ASSUME_VALID_ICON)
+						&& resource.isAssumeValid())
+					overlay =3D assumeValidImage;
+
+				// Staged overrides tracked
+				Staged staged =3D resource.staged();
+				if (store.getBoolean(UIPreferences.DECORATOR_SHOW_STAGED_ICON)
+						&& staged !=3D Staged.NOT_STAGED) {
+					if (staged =3D=3D Staged.ADDED)
+						overlay =3D stagedAddedImage;
+					else if (staged =3D=3D Staged.REMOVED)
+						overlay =3D stagedRemovedImage;
+					else
+						overlay =3D stagedImage;
+				}
+
+				// Conflicts override everything
+				if (store.getBoolean(UIPreferences.DECORATOR_SHOW_CONFLICTS_ICON)
+						&& resource.hasConflicts())
+					overlay =3D conflictImage;
+
+			} else if (store.getBoolean(UIPreferences.DECORATOR_SHOW_UNTRACKED_=
ICON)) {
+				overlay =3D untrackedImage;
 			}
+
+			// Overlays can only be added once, so do it at the end
+			decoration.addOverlay(overlay);
 		}
=20
 		/**
@@ -411,7 +599,7 @@ private void decorateIcons(IDecoration decoration,
 		 *            values
 		 */
 		public static void decorate(IDecoration decoration, String format,
-				Map bindings) {
+				Map<String, String> bindings) {
 			StringBuffer prefix =3D new StringBuffer();
 			StringBuffer suffix =3D new StringBuffer();
 			StringBuffer output =3D prefix;
@@ -426,6 +614,15 @@ public static void decorate(IDecoration decoration=
, String format,
 						String key =3D format.substring(end + 1, start);
 						String s;
=20
+						// Allow users to override the binding
+						if (key.indexOf(':') > -1) {
+							String[] keyAndBinding =3D key.split(":", 2);
+							key =3D keyAndBinding[0];
+							if (keyAndBinding.length > 1
+									&& bindings.get(key) !=3D null)
+								bindings.put(key, keyAndBinding[1]);
+						}
+
 						// We use the BINDING_RESOURCE_NAME key to determine if
 						// we are doing the prefix or suffix. The name isn't
 						// actually part of either.
@@ -433,7 +630,7 @@ public static void decorate(IDecoration decoration,=
 String format,
 							output =3D suffix;
 							s =3D null;
 						} else {
-							s =3D (String) bindings.get(key);
+							s =3D bindings.get(key);
 						}
=20
 						if (s !=3D null) {
@@ -522,6 +719,14 @@ public void resourceChanged(IResourceChangeEvent e=
vent) {
 				public boolean visit(IResourceDelta delta) throws CoreException {
 					final IResource resource =3D delta.getResource();
=20
+					// If the resource is not part of a project under Git
+					// revision control
+					final RepositoryMapping mapping =3D RepositoryMapping
+							.getMapping(resource);
+					if (mapping =3D=3D null) {
+						// Ignore the change
+						return true;
+					}
 					if (resource.getType() =3D=3D IResource.ROOT) {
 						// Continue with the delta
 						return true;
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decor=
ators/IDecoratableResource.java b/org.spearce.egit.ui/src/org/spearce/e=
git/ui/internal/decorators/IDecoratableResource.java
index f144214..b864a10 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/I=
DecoratableResource.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/I=
DecoratableResource.java
@@ -16,6 +16,22 @@
 public interface IDecoratableResource {
=20
 	/**
+	 * Set of possible staging states for a resource
+	 */
+	public enum Staged {
+		/** Represents a resource that is not staged */
+		NOT_STAGED,
+		/** Represents a resource that has been modified */
+		MODIFIED,
+		/** Represents a resource that is added to Git */
+		ADDED,
+		/** Represents a resource that is removed from Git */
+		REMOVED,
+		/** Represents a resource that has been renamed */
+		RENAMED
+	}
+
+	/**
 	 * Gets the type of the resource as defined by {@link IResource}
 	 *=20
 	 * @return the type of the resource
@@ -51,4 +67,34 @@
 	 * @return whether or not the resource is ignored
 	 */
 	boolean isIgnored();
+
+	/**
+	 * Returns whether or not the resource has changes that are not stage=
d
+	 *=20
+	 * @return whether or not the resource is dirty
+	 */
+	boolean isDirty();
+
+	/**
+	 * Returns the staged state of the resource
+	 *=20
+	 * The set of allowed values are defined by the <code>Staged</code> e=
num
+	 *=20
+	 * @return the staged state of the resource
+	 */
+	Staged staged();
+
+	/**
+	 * Returns whether or not the resource has merge conflicts
+	 *=20
+	 * @return whether or not the resource has merge conflicts
+	 */
+	boolean hasConflicts();
+
+	/**
+	 * Returns whether or not the resource is assumed valid
+	 *=20
+	 * @return whether or not the resource is assumed valid
+	 */
+	boolean isAssumeValid();
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/prefe=
rences/GitDecoratorPreferencePage.java b/org.spearce.egit.ui/src/org/sp=
earce/egit/ui/internal/preferences/GitDecoratorPreferencePage.java
index 7b637e3..f72ceb7 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/=
GitDecoratorPreferencePage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/=
GitDecoratorPreferencePage.java
@@ -55,6 +55,7 @@
 import org.eclipse.swt.widgets.Composite;
 import org.eclipse.swt.widgets.Control;
 import org.eclipse.swt.widgets.Event;
+import org.eclipse.swt.widgets.Label;
 import org.eclipse.swt.widgets.Listener;
 import org.eclipse.swt.widgets.TabFolder;
 import org.eclipse.swt.widgets.TabItem;
@@ -71,8 +72,9 @@
 import org.spearce.egit.ui.UIPreferences;
 import org.spearce.egit.ui.UIText;
 import org.spearce.egit.ui.internal.SWTUtils;
-import org.spearce.egit.ui.internal.decorators.GitLightweightDecorator=
=2EDecorationHelper;
 import org.spearce.egit.ui.internal.decorators.IDecoratableResource;
+import org.spearce.egit.ui.internal.decorators.GitLightweightDecorator=
=2EDecorationHelper;
+import org.spearce.egit.ui.internal.decorators.IDecoratableResource.St=
aged;
=20
 /**
  * Preference page for customizing Git label decorations
@@ -94,22 +96,43 @@
=20
 	private Preview preview;
=20
+	private Button showStaged;
+
+	private Button showConflicts;
+
+	private Button showAssumeValid;
+
 	private static final Collection PREVIEW_FILESYSTEM_ROOT;
=20
 	private static IPropertyChangeListener themeListener;
=20
 	static {
 		final PreviewResource project =3D new PreviewResource(
-				"Project", IResource.PROJECT, "master", true, false); //$NON-NLS-1=
$1
+				"Project", IResource.PROJECT, "master", true, false, false, Staged=
=2ENOT_STAGED, false, false); //$NON-NLS-1$1
 		final ArrayList<PreviewResource> children =3D new ArrayList<PreviewR=
esource>();
+
+		children.add(new PreviewResource(
+						"folder", IResource.FOLDER, null, true, false, false, Staged.NOT=
_STAGED, false, false)); //$NON-NLS-1$
+		children.add(new PreviewResource(
+						"tracked.txt", IResource.FILE, null, true, false, false, Staged.=
NOT_STAGED, false, false)); //$NON-NLS-1$
 		children.add(new PreviewResource(
-				"folder", IResource.FOLDER, null, true, false)); //$NON-NLS-1$
+						"untracked.txt", IResource.FILE, null, false, false, false, Stag=
ed.NOT_STAGED, false, false)); //$NON-NLS-1$
 		children.add(new PreviewResource(
-				"file.txt", IResource.FILE, null, true, false)); //$NON-NLS-1$
+						"ignored.txt", IResource.FILE, null, false, true, false, Staged.=
NOT_STAGED, false, false)); //$NON-NLS-1$
 		children.add(new PreviewResource(
-				"untracked.txt", IResource.FILE, null, false, false)); //$NON-NLS-=
1$
+						"dirty.txt", IResource.FILE, null, true, false, true, Staged.NOT=
_STAGED, false, false)); //$NON-NLS-1$
 		children.add(new PreviewResource(
-				"ignored.txt", IResource.FILE, null, false, true)); //$NON-NLS-1$
+						"staged.txt", IResource.FILE, null, true, false, false, Staged.M=
ODIFIED, false, false)); //$NON-NLS-1$
+		children.add(new PreviewResource(
+						"partially-staged.txt", IResource.FILE, null, true, false, true,=
 Staged.MODIFIED, false, false)); //$NON-NLS-1$
+		children.add(new PreviewResource(
+						"added.txt", IResource.FILE, null, true, false, false, Staged.AD=
DED, false, false)); //$NON-NLS-1$
+		children.add(new PreviewResource(
+						"removed.txt", IResource.FILE, null, true, false, false, Staged.=
REMOVED, false, false)); //$NON-NLS-1$
+		children.add(new PreviewResource(
+						"conflict.txt", IResource.FILE, null, true, false, true, Staged.=
NOT_STAGED, true, false)); //$NON-NLS-1$
+		children.add(new PreviewResource(
+						"assume-valid.txt", IResource.FILE, null, true, false, false, St=
aged.NOT_STAGED, false, true)); //$NON-NLS-1$
 		project.children =3D children;
 		PREVIEW_FILESYSTEM_ROOT =3D Collections.singleton(project);
 	}
@@ -190,22 +213,29 @@ private Control createTextDecoratorPage(Composite=
 parent) {
 		Composite fileTextGroup =3D SWTUtils.createHVFillComposite(parent,
 				SWTUtils.MARGINS_DEFAULT, 3);
=20
+		int labelWidth =3D convertWidthInCharsToPixels(Math.max(
+				UIText.DecoratorPreferencesPage_fileFormatLabel.length(),
+				Math.max(UIText.DecoratorPreferencesPage_folderFormatLabel
+						.length(),
+						UIText.DecoratorPreferencesPage_projectFormatLabel
+								.length())));
+
 		TextPair format =3D createFormatEditorControl(fileTextGroup,
 				UIText.DecoratorPreferencesPage_fileFormatLabel,
 				UIText.DecoratorPreferencesPage_addVariablesAction,
-				getFileBindingDescriptions());
+				getFileBindingDescriptions(), labelWidth);
 		fileTextFormat =3D format.t1;
=20
 		format =3D createFormatEditorControl(fileTextGroup,
 				UIText.DecoratorPreferencesPage_folderFormatLabel,
 				UIText.DecoratorPreferencesPage_addVariablesAction,
-				getFolderBindingDescriptions());
+				getFolderBindingDescriptions(), labelWidth);
 		folderTextFormat =3D format.t1;
=20
 		format =3D createFormatEditorControl(fileTextGroup,
 				UIText.DecoratorPreferencesPage_projectFormatLabel,
 				UIText.DecoratorPreferencesPage_addVariablesAction,
-				getProjectBindingDescriptions());
+				getProjectBindingDescriptions(), labelWidth);
 		projectTextFormat =3D format.t1;
=20
 		return fileTextGroup;
@@ -219,17 +249,29 @@ private Control createIconDecoratorPage(Composite=
 parent) {
 				UIText.DecoratorPreferencesPage_iconsShowTracked);
 		showUntracked =3D SWTUtils.createCheckBox(imageGroup,
 				UIText.DecoratorPreferencesPage_iconsShowUntracked);
+		showStaged =3D SWTUtils.createCheckBox(imageGroup,
+				UIText.DecoratorPreferencesPage_iconsShowStaged);
+		showConflicts =3D SWTUtils.createCheckBox(imageGroup,
+				UIText.DecoratorPreferencesPage_iconsShowConflicts);
+		showAssumeValid =3D SWTUtils.createCheckBox(imageGroup,
+				UIText.DecoratorPreferencesPage_iconsShowAssumeValid);
=20
 		return imageGroup;
 	}
=20
 	private TextPair createFormatEditorControl(Composite composite,
-			String title, String buttonText, final Map supportedBindings) {
+			String title, String buttonText, final Map supportedBindings,
+			int labelWidth) {
=20
-		SWTUtils.createLabel(composite, title);
+		Label label =3D SWTUtils.createLabel(composite, title);
+		GridData labelGridData =3D new GridData();
+		labelGridData.widthHint =3D labelWidth;
+		label.setLayoutData(labelGridData);
=20
 		Text format =3D new Text(composite, SWT.BORDER);
-		format.setLayoutData(new GridData(GridData.FILL_HORIZONTAL));
+		GridData textGridData =3D new GridData(GridData.FILL_HORIZONTAL);
+		textGridData.widthHint =3D 200;
+		format.setLayoutData(textGridData);
 		format.addModifyListener(new ModifyListener() {
 			public void modifyText(ModifyEvent e) {
 				updatePreview();
@@ -273,16 +315,25 @@ private void initializeValues() {
 				.getBoolean(UIPreferences.DECORATOR_SHOW_TRACKED_ICON));
 		showUntracked.setSelection(store
 				.getBoolean(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON));
+		showStaged.setSelection(store
+				.getBoolean(UIPreferences.DECORATOR_SHOW_STAGED_ICON));
+		showConflicts.setSelection(store
+				.getBoolean(UIPreferences.DECORATOR_SHOW_CONFLICTS_ICON));
+		showAssumeValid.setSelection(store
+				.getBoolean(UIPreferences.DECORATOR_SHOW_ASSUME_VALID_ICON));
=20
 		SelectionListener selectionListener =3D new SelectionAdapter() {
 			public void widgetSelected(SelectionEvent e) {
-				fPreview.refresh();
+				preview.refresh();
 			}
 		};
=20
 		computeDeepDirtyState.addSelectionListener(selectionListener);
 		showTracked.addSelectionListener(selectionListener);
 		showUntracked.addSelectionListener(selectionListener);
+		showStaged.addSelectionListener(selectionListener);
+		showConflicts.addSelectionListener(selectionListener);
+		showAssumeValid.addSelectionListener(selectionListener);
=20
 		setValid(true);
 	}
@@ -334,6 +385,12 @@ private boolean performOk(IPreferenceStore store) =
{
 				.getSelection());
 		store.setValue(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON,
 				showUntracked.getSelection());
+		store.setValue(UIPreferences.DECORATOR_SHOW_STAGED_ICON, showStaged
+				.getSelection());
+		store.setValue(UIPreferences.DECORATOR_SHOW_CONFLICTS_ICON,
+				showConflicts.getSelection());
+		store.setValue(UIPreferences.DECORATOR_SHOW_ASSUME_VALID_ICON,
+				showAssumeValid.getSelection());
=20
 		return true;
 	}
@@ -363,6 +420,14 @@ protected void performDefaults() {
 		showUntracked
 				.setSelection(store
 						.getDefaultBoolean(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON))=
;
+		showStaged.setSelection(store
+				.getDefaultBoolean(UIPreferences.DECORATOR_SHOW_STAGED_ICON));
+		showConflicts
+				.setSelection(store
+						.getDefaultBoolean(UIPreferences.DECORATOR_SHOW_CONFLICTS_ICON))=
;
+		showAssumeValid
+				.setSelection(store
+						.getDefaultBoolean(UIPreferences.DECORATOR_SHOW_ASSUME_VALID_ICO=
N));
 	}
=20
 	/**
@@ -473,7 +538,11 @@ TextPair(Text t1, Text t2) {
 	private Map getFileBindingDescriptions() {
 		Map<String, String> bindings =3D new HashMap<String, String>();
 		bindings.put(DecorationHelper.BINDING_RESOURCE_NAME,
-				UIText.DecoratorPreferencesPage_nameResourceVariable);
+				UIText.DecoratorPreferencesPage_bindingResourceName);
+		bindings.put(DecorationHelper.BINDING_DIRTY_FLAG,
+				UIText.DecoratorPreferencesPage_bindingDirtyFlag);
+		bindings.put(DecorationHelper.BINDING_STAGED_FLAG,
+				UIText.DecoratorPreferencesPage_bindingStagedFlag);
 		return bindings;
 	}
=20
@@ -486,7 +555,11 @@ private Map getFileBindingDescriptions() {
 	private Map getFolderBindingDescriptions() {
 		Map<String, String> bindings =3D new HashMap<String, String>();
 		bindings.put(DecorationHelper.BINDING_RESOURCE_NAME,
-				UIText.DecoratorPreferencesPage_nameResourceVariable);
+				UIText.DecoratorPreferencesPage_bindingResourceName);
+		bindings.put(DecorationHelper.BINDING_DIRTY_FLAG,
+				UIText.DecoratorPreferencesPage_bindingDirtyFlag);
+		bindings.put(DecorationHelper.BINDING_STAGED_FLAG,
+				UIText.DecoratorPreferencesPage_bindingStagedFlag);
 		return bindings;
 	}
=20
@@ -499,7 +572,11 @@ private Map getFolderBindingDescriptions() {
 	private Map getProjectBindingDescriptions() {
 		Map<String, String> bindings =3D new HashMap<String, String>();
 		bindings.put(DecorationHelper.BINDING_RESOURCE_NAME,
-				UIText.DecoratorPreferencesPage_nameResourceVariable);
+				UIText.DecoratorPreferencesPage_bindingResourceName);
+		bindings.put(DecorationHelper.BINDING_DIRTY_FLAG,
+				UIText.DecoratorPreferencesPage_bindingDirtyFlag);
+		bindings.put(DecorationHelper.BINDING_STAGED_FLAG,
+				UIText.DecoratorPreferencesPage_bindingStagedFlag);
 		bindings.put(DecorationHelper.BINDING_BRANCH_NAME,
 				UIText.DecoratorPreferencesPage_bindingBranchName);
 		return bindings;
@@ -658,14 +735,28 @@ private PreviewDecoration getDecoration(Object el=
ement) {
=20
 		private boolean ignored;
=20
+		private boolean dirty;
+
+		private boolean conflicts;
+
+		private Staged staged;
+
+		private boolean assumeValid;
+
 		public PreviewResource(String name, int type, String branch,
-				boolean tracked, boolean ignored) {
+				boolean tracked, boolean ignored, boolean dirty, Staged staged,
+				boolean conflicts, boolean assumeValid) {
+
 			this.name =3D name;
 			this.branch =3D branch;
 			this.type =3D type;
 			this.children =3D Collections.EMPTY_LIST;
 			this.tracked =3D tracked;
 			this.ignored =3D ignored;
+			this.dirty =3D dirty;
+			this.staged =3D staged;
+			this.conflicts =3D conflicts;
+			this.assumeValid =3D assumeValid;=20
 		}
=20
 		public String getName() {
@@ -687,6 +778,22 @@ public boolean isTracked() {
 		public boolean isIgnored() {
 			return ignored;
 		}
+
+		public boolean isDirty() {
+			return dirty;
+		}
+
+		public Staged staged() {
+			return staged;
+		}
+
+		public boolean hasConflicts() {
+			return conflicts;
+		}
+
+		public boolean isAssumeValid() {
+			return assumeValid;
+		}
 	}
=20
 	private class PreviewDecoration implements IDecoration {
@@ -703,12 +810,19 @@ public boolean isIgnored() {
=20
 		private Color foregroundColor;
=20
+		/**
+		 * Adds an icon overlay to the decoration
+		 * <p>
+		 * Copies the behavior of <code>DecorationBuilder</code> of only
+		 * allowing the overlay to be set once.
+		 */
 		public void addOverlay(ImageDescriptor overlayImage) {
-			overlay =3D overlayImage;
+			if (overlay =3D=3D null)
+				overlay =3D overlayImage;
 		}
=20
 		public void addOverlay(ImageDescriptor overlayImage, int quadrant) {
-			overlay =3D overlayImage;
+			addOverlay(overlayImage);
 		}
=20
 		public void addPrefix(String prefix) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.propert=
ies b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 9940177..e9a2321 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -358,17 +358,24 @@ DecoratorPreferencesPage_preview=3DPreview:
 DecoratorPreferencesPage_fileFormatLabel=3D&Files:
 DecoratorPreferencesPage_folderFormatLabel=3DF&olders:
 DecoratorPreferencesPage_projectFormatLabel=3D&Projects:
-DecoratorPreferencesPage_fileFormatDefault=3D{name}
-DecoratorPreferencesPage_folderFormatDefault=3D{name}
-DecoratorPreferencesPage_projectFormatDefault=3D{name} [{branch}]
+DecoratorPreferencesPage_fileFormatDefault=3D{dirty:>} {name}
+DecoratorPreferencesPage_folderFormatDefault=3D{dirty:>} {name}
+DecoratorPreferencesPage_projectFormatDefault=3D{dirty:>} {name} [{bra=
nch}]
 DecoratorPreferencesPage_labelDecorationsLink=3DSee <a>''{0}''</a> to =
enable or disable Git decorations.
 DecoratorPreferencesPage_generalTabFolder=3D&General
-DecoratorPreferencesPage_nameResourceVariable=3Dname of the resource b=
eing decorated
+DecoratorPreferencesPage_bindingResourceName=3Dname of the resource be=
ing decorated
 DecoratorPreferencesPage_bindingBranchName=3Dcurrent branch of the pro=
ject
+DecoratorPreferencesPage_bindingDirtyFlag=3Dflag indicating whether or=
 not the resource is dirty
+DecoratorPreferencesPage_bindingStagedFlag=3Dflag indicating whether o=
r not the resource is staged
 DecoratorPreferencesPage_selectFormats=3DSelect the format for file, f=
olders, and project text labels:
 DecoratorPreferencesPage_selectVariablesToAdd=3DSelect the &variables =
to add to the decoration format:
 DecoratorPreferencesPage_textLabel=3DT&ext Decorations
 DecoratorPreferencesPage_iconLabel=3D&Icon Decorations
 DecoratorPreferencesPage_iconsShowTracked=3DTracked resources
 DecoratorPreferencesPage_iconsShowUntracked=3DUntracked resources
+DecoratorPreferencesPage_iconsShowStaged=3DStaged resources
+DecoratorPreferencesPage_iconsShowConflicts=3DConflicting resources
+DecoratorPreferencesPage_iconsShowAssumeValid=3DAssumed unchanged reso=
urces
+
+Decorator_exceptionMessage=3DErrors occurred while applying Git decora=
tions to resources.
=20
--=20
1.6.1.2.309.g2ea3
