From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 00/31] Push GUI, GUI improvements, various jgit stuff
Date: Sun, 17 Aug 2008 22:43:41 +0200
Message-ID: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:45:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp7r-0002oB-RR
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbYHQUoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbYHQUoU
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:44:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:31899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbYHQUoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:44:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489141fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=5F2uU6XXksIS0QRISfIDi39zQ+F8BwoRZsEc/+hSSDQ=;
        b=aElI+CD3OsRhZonzDmJLYKwZGVMiuW/SLYhsqu76AwrRgZeoYue9UsfzqLGrChb8fZ
         Azed2m7xkVke34BA5Q2xN4Q5Q/QX9R0M1a/3CAxXbYKkMUVsHLPu5LVA+miQM9my6Y6d
         /RFJjqcWbXwqEQ7hcfYl0AVuky4cBnnqxJgB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=cRbB0KM3QDmQYEvoJOVeg9LfXQQOOekM8wgYhaQiT7TSxBxdVNSQHBTNr0xvIhlml+
         k1PYnz3VWGYpmR7LnCBZgZb9pqJCsa1ynBWtL37Yqk43Znd0VusFgzZUhja87D2JXT4k
         YPYo3cdKgIltE9Kik+59KqVhQjmK0a3XQjNDI=
Received: by 10.86.90.13 with SMTP id n13mr4060124fgb.3.1219005857447;
        Sun, 17 Aug 2008 13:44:17 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id l12sm1427670fgb.6.2008.08.17.13.44.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:44:16 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92632>

That's the final series for one of my core tasks for GSoC: GUI related
stuff. Little late, but it required lot of polishing.

Traditionally, it's also available at
http://repo.or.cz/w/egit/zawir.git?a=shortlog;h=refs/heads/push
But wait... this time it was pushed from Eclipse! ;)

The series consists of few parts:
1) Various small fixes and improvements to jgit.
2) Lot of refactor, fixes, improvements in Git Clone Wizard.
3) Push GUI with some general purpose components.
(more in commit messages)

Fetch GUI is not implemented yet, although with this
Eclipse-experience and new stuff available in .components, I suspect
it we'll be *much* much easier to do it than this push GUI, so I may
try to do it as well, especially if you enjoy this one. I'm just
starting working on that.

Changes in plugin were tested on Eclipse 3.4 at Linux, Windows XP and
partially at MacOS 10.4 (there are some issues that makes it looking
worse there, one very annoying bug is reported to Eclipse' bugzilla).
I'm now using mostly Eclipse 3.4, but I've tried to use up to 3.3 API.
Shawn also tried this code at Eclipse 3.3 on OS X 10.5, at least up to
some stage.

Comments regarding this GUI are welcome, I hope that yet another mind
can bring some ideas. Recently (few days ago), Shawn brought some
great idea of making Eclipse view for results of operations on remote
(fetch, push) instead of dialog. That would be cool, although
unfortunatelly it was too late for me to do it - to change project at
this stage.

I've got some problem with icons right now, as I'm pretty far from
stating that I'm good at doing that sort of art.
Robin, Tor, I know that you were already contributing some graphics to
egit. If someone of you would like to do some icon for push/fetch with
pleasure, you are welcome. Otherwise I'll have to do some crappy icon
instead ;) Another matter are checkboxes screenshots. I'm not sure
about legality status of including them. Any ideas if/how we co use
them or some another set that we can for sure?

Although that's last big portion of code during this GSoC from me,
I may send some smaller things in next 2 days or fix this stuff if
needed.

Have fun with push;>
Marek / zawir

Marek Zawirski (31):
  Fix Repository.mapObject() for missing objects
  Fix Repository isValidRefName() for empty names
  Fix Repository.resolve() to not throw runtime exceptions
  Document/fix Transport open method for specific case
  Fix RefSpec javadoc regarding spec expanding
  Make wildcard checking public in RefSpec
  Add openAll() and applyConfig() methods to Transport
  Add dryRun option to Transport and console push
  Extract Transport findRemoteRefUpdatesFor() as static method
  Improve javadoc of Transport push()
  Clean up exception issues in RemoteRefUpdate
  Add another RemoteRefUpdate constructor, useful for 2-stage push
  Add getAllRemoteConfigs() to RemoteConfig
  Add setFetchRefSpecs and setPushRefSpecs to RemoteConfig
  Add simple abbreviate() method to ObjectId
  Remove debug/test console output from GitIndex
  Fix typo in uitext.properties message
  Refactor/rewrite CloneSourcePage to universal RepositorySelectionPage
  Clone wizard and related: refactor, clean-up, fixes or improvements
  Move clone logic away from GitCloneWizard to CloneOperation
  Add canCreateSubdir() heuristic in CloneDestinationPage
  Set FileDialog selection appropriately in clone wizard
  Allow selecting empty dir in clone wizard
  Clone wizard: force dir to suggested path only if repo selection
    change
  Create ListRemoteOperation for listing remote repo branches
  Make Clone's SourceBranchPage more user-friendly
  Add few EPL Eclipse icons
  Checkbox images/screenshots
  Universal GUI for specifications edition: RefSpecPanel and related
  Add PushOperation to plugin
  Push GUI

 .../src/org/spearce/egit/core/CoreText.java        |   18 +
 .../src/org/spearce/egit/core/coretext.properties  |    8 +
 .../org/spearce/egit/core/op/CloneOperation.java   |  129 ++-
 .../spearce/egit/core/op/ListRemoteOperation.java  |  104 ++
 .../org/spearce/egit/core/op/PushOperation.java    |  148 ++
 .../spearce/egit/core/op/PushOperationResult.java  |  273 +++
 .../egit/core/op/PushOperationSpecification.java   |   82 +
 .../icons/checkboxes/disabled_checked.gif          |  Bin 0 -> 166 bytes
 .../icons/checkboxes/disabled_unchecked.gif        |  Bin 0 -> 125 bytes
 .../icons/checkboxes/enabled_checked.gif           |  Bin 0 -> 166 bytes
 .../icons/checkboxes/enabled_unchecked.gif         |  Bin 0 -> 157 bytes
 org.spearce.egit.ui/icons/elcl16/add.gif           |  Bin 0 -> 318 bytes
 org.spearce.egit.ui/icons/elcl16/clear.gif         |  Bin 0 -> 595 bytes
 org.spearce.egit.ui/icons/elcl16/delete.gif        |  Bin 0 -> 351 bytes
 org.spearce.egit.ui/icons/elcl16/trash.gif         |  Bin 0 -> 590 bytes
 org.spearce.egit.ui/plugin.properties              |    3 +
 org.spearce.egit.ui/plugin.xml                     |   15 +
 .../src/org/spearce/egit/ui/UIIcons.java           |   25 +
 .../src/org/spearce/egit/ui/UIText.java            |  398 ++++-
 .../egit/ui/internal/actions/PushAction.java       |   47 +
 .../ui/internal/clone/BranchChangeListener.java    |   13 -
 .../ui/internal/clone/CloneDestinationPage.java    |  165 ++-
 .../egit/ui/internal/clone/CloneSourcePage.java    |  460 -----
 .../egit/ui/internal/clone/GitCloneWizard.java     |   92 +-
 .../egit/ui/internal/clone/SourceBranchPage.java   |  327 ++--
 .../ui/internal/components/BaseWizardPage.java     |   58 +
 .../components/CenteredImageLabelProvider.java     |   52 +
 .../internal/components/CheckboxLabelProvider.java |  138 ++
 .../internal/components/ClickableCellEditor.java   |   68 +
 .../internal/components/ComboLabelingSupport.java  |   77 +
 .../ui/internal/components/RefContentProposal.java |  140 ++
 .../egit/ui/internal/components/RefSpecPage.java   |  237 +++
 .../egit/ui/internal/components/RefSpecPanel.java  | 1823 ++++++++++++++++++++
 .../internal/components/RepositorySelection.java   |  133 ++
 .../components/RepositorySelectionPage.java        |  663 +++++++
 .../SelectionChangeListener.java}                  |   19 +-
 .../egit/ui/internal/push/ConfirmationPage.java    |  211 +++
 .../egit/ui/internal/push/PushResultTable.java     |  327 ++++
 .../spearce/egit/ui/internal/push/PushWizard.java  |  250 +++
 .../ui/internal/push/RefUpdateContentProvider.java |   62 +
 .../egit/ui/internal/push/RefUpdateElement.java    |   67 +
 .../egit/ui/internal/push/ResultDialog.java        |   65 +
 .../src/org/spearce/egit/ui/uitext.properties      |  163 ++-
 .../src/org/spearce/jgit/pgm/Fetch.java            |   10 +-
 .../src/org/spearce/jgit/pgm/Push.java             |   55 +-
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |    4 -
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |   15 +
 .../src/org/spearce/jgit/lib/GitIndex.java         |    3 -
 .../src/org/spearce/jgit/lib/Repository.java       |   64 +-
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   21 +
 .../org/spearce/jgit/transport/PushProcess.java    |   18 +-
 .../src/org/spearce/jgit/transport/RefSpec.java    |   29 +-
 .../org/spearce/jgit/transport/RemoteConfig.java   |   50 +
 .../spearce/jgit/transport/RemoteRefUpdate.java    |   40 +-
 .../src/org/spearce/jgit/transport/Transport.java  |  283 +++-
 55 files changed, 6471 insertions(+), 981 deletions(-)
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/op/ListRemoteOperation.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationResult.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationSpecification.java
 create mode 100644 org.spearce.egit.ui/icons/checkboxes/disabled_checked.gif
 create mode 100644 org.spearce.egit.ui/icons/checkboxes/disabled_unchecked.gif
 create mode 100644 org.spearce.egit.ui/icons/checkboxes/enabled_checked.gif
 create mode 100644 org.spearce.egit.ui/icons/checkboxes/enabled_unchecked.gif
 create mode 100644 org.spearce.egit.ui/icons/elcl16/add.gif
 create mode 100644 org.spearce.egit.ui/icons/elcl16/clear.gif
 create mode 100644 org.spearce.egit.ui/icons/elcl16/delete.gif
 create mode 100644 org.spearce.egit.ui/icons/elcl16/trash.gif
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/PushAction.java
 delete mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/BranchChangeListener.java
 delete mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneSourcePage.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/BaseWizardPage.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/CenteredImageLabelProvider.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/CheckboxLabelProvider.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/ClickableCellEditor.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/ComboLabelingSupport.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefContentProposal.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelection.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
 rename org.spearce.egit.ui/src/org/spearce/egit/ui/internal/{clone/URIishChangeListener.java => components/SelectionChangeListener.java} (51%)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ConfirmationPage.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultTable.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushWizard.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/RefUpdateContentProvider.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/RefUpdateElement.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ResultDialog.java
