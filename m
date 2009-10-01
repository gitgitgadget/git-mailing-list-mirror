From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT PATCH] mavenisation of the eclipse.org branch
Date: Thu,  1 Oct 2009 22:32:07 +0200
Message-ID: <1254429128-18222-1-git-send-email-struberg@yahoo.de>
Cc: Mark Struberg <struberg@yahoo.de>
To: git@vger.kernel.org, spearce@spearce.org, jonas.fonseca@gmail.com,
	robin.rosenberg.lists@dewire.com
X-From: git-owner@vger.kernel.org Thu Oct 01 22:38:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtSQO-0004h8-VG
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 22:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517AbZJAUim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 16:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755550AbZJAUil
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 16:38:41 -0400
Received: from smtp114.plus.mail.re1.yahoo.com ([69.147.102.77]:39656 "HELO
	smtp114.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756266AbZJAUij (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Oct 2009 16:38:39 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2009 16:38:38 EDT
Received: (qmail 57052 invoked from network); 1 Oct 2009 20:32:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Cc:Subject:Date:Message-Id:X-Mailer;
  b=xGVJKBEJbUhsB0ruHUbVmUnb82YOx1Gz1aS5eHmpi+vReDCMwusMkJMRIyPFpx2PHOTVMveUlamfPf5noQFkekPEi5dVfUKmaf2m6VjIWOhfuTPZAwZF0L/xzTkFGbpJbdCwormcxsADIhSouyZ9G0AV0Kg9b/pdJcZqDO3PaN8=  ;
Received: from chello062178039060.14.11.vie.surfer.at (struberg@62.178.39.60 with login)
        by smtp114.plus.mail.re1.yahoo.com with SMTP; 01 Oct 2009 13:31:58 -0700 PDT
X-Yahoo-SMTP: 81dhI.iswBBq7boyzRoOX6xuRIe8
X-YMail-OSG: QSA5bc4VM1n.8ZAGo4_BWL05NH3fT3ksUWCLv8k6yxhE1Fchyl2U.oCImm7tIdAlaSP8NgbE70Dd0lx94heuMZVKFmWIKZdsMYhN_GvJDRKAurTCVYyJfNTWtFyNCEsrgWRm3OfY8WCBMZB5PV3VI3INQh.CZCMV7y.FwAfvaM29jzgteQK3edbQNnZ34fHKG72.ce6AWvl0ZzAopB1ESxkFg2ZZADGvAbZq0IBb_QOWZbAtmD4c.nRFoi0ba15lYBwF_NTxOs4Z4CJnXzOVSez6G4HqMimdkUui4SpwXN0dc.pt1J.1mCIUXuQ9giUFPG3p64HqLenpFXw6UfW4ldRgUtRjIwSFyz94vaoW9zzr1WxrVmznHNPjHlYNTFuAUeZYK2qCRBQ9YSAPPA--
X-Yahoo-Newman-Property: ymail-3
X-Mailer: git-send-email 1.6.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129410>

Hi!

I did all the work of the last weeks again on the eclipse.org branch.
This work is also available via git at 
http://github.com/sonatype/JGit/commits/eclipse.org.mavenized

LieGrue,
strub

Mark Struberg (1):
  mavenizing JGit Signed-off-by: Mark Struberg <struberg@yahoo.de>

 .gitignore                                         |    1 +
 {org.eclipse.jgit => jgit-core}/.classpath         |    0
 {org.eclipse.jgit => jgit-core}/.fbprefs           |    0
 jgit-core/.gitignore                               |    2 +
 {org.eclipse.jgit => jgit-core}/.project           |    0
 .../.settings/org.eclipse.core.resources.prefs     |    0
 .../.settings/org.eclipse.core.runtime.prefs       |    0
 .../.settings/org.eclipse.jdt.core.prefs           |    0
 .../.settings/org.eclipse.jdt.ui.prefs             |    0
 {org.eclipse.jgit => jgit-core}/build.properties   |    0
 .../findBugs/FindBugsExcludeFilter.xml             |    0
 ...e.jgit.core--All-External-Tests (Java 6).launch |    0
 ...rg.eclipse.jgit.core--All-External-Tests.launch |    0
 ...rg.eclipse.jgit.core--All-Tests (Java 6).launch |    0
 .../org.eclipse.jgit.core--All-Tests.launch        |    0
 {org.eclipse.jgit => jgit-core}/plugin.properties  |    0
 jgit-core/pom.xml                                  |  141 +++++++++
 .../org/eclipse/jgit/awtui/AWTPlotRenderer.java    |    0
 .../org/eclipse/jgit/awtui/AwtAuthenticator.java   |    0
 .../org/eclipse/jgit/awtui/CommitGraphPane.java    |    0
 .../org/eclipse/jgit/awtui/SwingCommitList.java    |    0
 .../java}/org/eclipse/jgit/diff/DiffFormatter.java |    0
 .../src/main/java}/org/eclipse/jgit/diff/Edit.java |    0
 .../main/java}/org/eclipse/jgit/diff/EditList.java |    0
 .../main/java}/org/eclipse/jgit/diff/RawText.java  |    0
 .../main/java}/org/eclipse/jgit/diff/Sequence.java |    0
 .../eclipse/jgit/dircache/BaseDirCacheEditor.java  |    0
 .../java}/org/eclipse/jgit/dircache/DirCache.java  |    0
 .../jgit/dircache/DirCacheBuildIterator.java       |    0
 .../org/eclipse/jgit/dircache/DirCacheBuilder.java |    0
 .../org/eclipse/jgit/dircache/DirCacheEditor.java  |    0
 .../org/eclipse/jgit/dircache/DirCacheEntry.java   |    0
 .../eclipse/jgit/dircache/DirCacheIterator.java    |    0
 .../org/eclipse/jgit/dircache/DirCacheTree.java    |    0
 .../jgit/errors/CheckoutConflictException.java     |    0
 .../org/eclipse/jgit/errors/CompoundException.java |    0
 .../jgit/errors/ConfigInvalidException.java        |    0
 .../jgit/errors/CorruptObjectException.java        |    0
 .../eclipse/jgit/errors/EntryExistsException.java  |    0
 .../jgit/errors/GitlinksNotSupportedException.java |    0
 .../jgit/errors/IncorrectObjectTypeException.java  |    0
 .../jgit/errors/InvalidObjectIdException.java      |    0
 .../jgit/errors/InvalidPatternException.java       |    0
 .../errors/MissingBundlePrerequisiteException.java |    0
 .../jgit/errors/MissingObjectException.java        |    0
 .../jgit/errors/NoClosingBracketException.java     |    0
 .../jgit/errors/NoRemoteRepositoryException.java   |    0
 .../eclipse/jgit/errors/NotSupportedException.java |    0
 .../jgit/errors/ObjectWritingException.java        |    0
 .../eclipse/jgit/errors/PackInvalidException.java  |    0
 .../eclipse/jgit/errors/PackMismatchException.java |    0
 .../eclipse/jgit/errors/PackProtocolException.java |    0
 .../jgit/errors/RepositoryNotFoundException.java   |    0
 .../org/eclipse/jgit/errors/RevWalkException.java  |    0
 .../jgit/errors/RevisionSyntaxException.java       |    0
 .../org/eclipse/jgit/errors/StopWalkException.java |    0
 .../jgit/errors/SymlinksNotSupportedException.java |    0
 .../eclipse/jgit/errors/TransportException.java    |    0
 .../eclipse/jgit/errors/UnmergedPathException.java |    0
 .../org/eclipse/jgit/fnmatch/AbstractHead.java     |    0
 .../org/eclipse/jgit/fnmatch/CharacterHead.java    |    0
 .../org/eclipse/jgit/fnmatch/FileNameMatcher.java  |    0
 .../java}/org/eclipse/jgit/fnmatch/GroupHead.java  |    0
 .../main/java}/org/eclipse/jgit/fnmatch/Head.java  |    0
 .../java}/org/eclipse/jgit/fnmatch/LastHead.java   |    0
 .../jgit/fnmatch/RestrictedWildCardHead.java       |    0
 .../org/eclipse/jgit/fnmatch/WildCardHead.java     |    0
 .../org/eclipse/jgit/lib/AbbreviatedObjectId.java  |    0
 .../eclipse/jgit/lib/AbstractIndexTreeVisitor.java |    0
 .../jgit/lib/AlternateRepositoryDatabase.java      |    0
 .../java}/org/eclipse/jgit/lib/AnyObjectId.java    |    0
 .../java}/org/eclipse/jgit/lib/BinaryDelta.java    |    0
 .../org/eclipse/jgit/lib/BlobBasedConfig.java      |    0
 .../org/eclipse/jgit/lib/ByteArrayWindow.java      |    0
 .../org/eclipse/jgit/lib/ByteBufferWindow.java     |    0
 .../java}/org/eclipse/jgit/lib/ByteWindow.java     |    0
 .../main/java}/org/eclipse/jgit/lib/Commit.java    |    0
 .../main/java}/org/eclipse/jgit/lib/Config.java    |    0
 .../main/java}/org/eclipse/jgit/lib/Constants.java |    0
 .../java}/org/eclipse/jgit/lib/CoreConfig.java     |    0
 .../jgit/lib/DeltaOfsPackedObjectLoader.java       |    0
 .../eclipse/jgit/lib/DeltaPackedObjectLoader.java  |    0
 .../jgit/lib/DeltaRefPackedObjectLoader.java       |    0
 .../org/eclipse/jgit/lib/FileBasedConfig.java      |    0
 .../main/java}/org/eclipse/jgit/lib/FileMode.java  |    0
 .../java}/org/eclipse/jgit/lib/FileTreeEntry.java  |    0
 .../java}/org/eclipse/jgit/lib/ForceModified.java  |    0
 .../main/java}/org/eclipse/jgit/lib/GitIndex.java  |    0
 .../org/eclipse/jgit/lib/GitlinkTreeEntry.java     |    0
 .../org/eclipse/jgit/lib/IndexChangedEvent.java    |    0
 .../main/java}/org/eclipse/jgit/lib/IndexDiff.java |    0
 .../org/eclipse/jgit/lib/IndexTreeVisitor.java     |    0
 .../org/eclipse/jgit/lib/IndexTreeWalker.java      |    0
 .../java}/org/eclipse/jgit/lib/InflaterCache.java  |    0
 .../main/java}/org/eclipse/jgit/lib/LockFile.java  |    0
 .../org/eclipse/jgit/lib/MutableObjectId.java      |    0
 .../org/eclipse/jgit/lib/NullProgressMonitor.java  |    0
 .../java}/org/eclipse/jgit/lib/ObjectChecker.java  |    0
 .../java}/org/eclipse/jgit/lib/ObjectDatabase.java |    0
 .../org/eclipse/jgit/lib/ObjectDirectory.java      |    0
 .../main/java}/org/eclipse/jgit/lib/ObjectId.java  |    0
 .../org/eclipse/jgit/lib/ObjectIdSubclassMap.java  |    0
 .../java}/org/eclipse/jgit/lib/ObjectLoader.java   |    0
 .../java}/org/eclipse/jgit/lib/ObjectWriter.java   |    0
 .../java}/org/eclipse/jgit/lib/OffsetCache.java    |    0
 .../main/java}/org/eclipse/jgit/lib/PackFile.java  |    0
 .../main/java}/org/eclipse/jgit/lib/PackIndex.java |    0
 .../java}/org/eclipse/jgit/lib/PackIndexV1.java    |    0
 .../java}/org/eclipse/jgit/lib/PackIndexV2.java    |    0
 .../org/eclipse/jgit/lib/PackIndexWriter.java      |    0
 .../org/eclipse/jgit/lib/PackIndexWriterV1.java    |    0
 .../org/eclipse/jgit/lib/PackIndexWriterV2.java    |    0
 .../main/java}/org/eclipse/jgit/lib/PackLock.java  |    0
 .../org/eclipse/jgit/lib/PackOutputStream.java     |    0
 .../org/eclipse/jgit/lib/PackReverseIndex.java     |    0
 .../java}/org/eclipse/jgit/lib/PackWriter.java     |    0
 .../org/eclipse/jgit/lib/PackedObjectLoader.java   |    0
 .../java}/org/eclipse/jgit/lib/PersonIdent.java    |    0
 .../org/eclipse/jgit/lib/ProgressMonitor.java      |    0
 .../src/main/java}/org/eclipse/jgit/lib/Ref.java   |    0
 .../java}/org/eclipse/jgit/lib/RefComparator.java  |    0
 .../java}/org/eclipse/jgit/lib/RefDatabase.java    |    0
 .../java}/org/eclipse/jgit/lib/RefLogWriter.java   |    0
 .../main/java}/org/eclipse/jgit/lib/RefRename.java |    0
 .../main/java}/org/eclipse/jgit/lib/RefUpdate.java |    0
 .../main/java}/org/eclipse/jgit/lib/RefWriter.java |    0
 .../java}/org/eclipse/jgit/lib/ReflogReader.java   |    0
 .../org/eclipse/jgit/lib/RefsChangedEvent.java     |    0
 .../java}/org/eclipse/jgit/lib/Repository.java     |    0
 .../org/eclipse/jgit/lib/RepositoryAdapter.java    |    0
 .../org/eclipse/jgit/lib/RepositoryCache.java      |    0
 .../eclipse/jgit/lib/RepositoryChangedEvent.java   |    0
 .../org/eclipse/jgit/lib/RepositoryConfig.java     |    0
 .../org/eclipse/jgit/lib/RepositoryListener.java   |    0
 .../org/eclipse/jgit/lib/RepositoryState.java      |    0
 .../org/eclipse/jgit/lib/SymlinkTreeEntry.java     |    0
 .../src/main/java}/org/eclipse/jgit/lib/Tag.java   |    0
 .../org/eclipse/jgit/lib/TextProgressMonitor.java  |    0
 .../java}/org/eclipse/jgit/lib/TransferConfig.java |    0
 .../src/main/java}/org/eclipse/jgit/lib/Tree.java  |    0
 .../main/java}/org/eclipse/jgit/lib/TreeEntry.java |    0
 .../java}/org/eclipse/jgit/lib/TreeIterator.java   |    0
 .../java}/org/eclipse/jgit/lib/TreeVisitor.java    |    0
 .../jgit/lib/TreeVisitorWithCurrentDirectory.java  |    0
 .../main/java}/org/eclipse/jgit/lib/Treeish.java   |    0
 .../org/eclipse/jgit/lib/UnpackedObjectCache.java  |    0
 .../org/eclipse/jgit/lib/UnpackedObjectLoader.java |    0
 .../java}/org/eclipse/jgit/lib/UserConfig.java     |    0
 .../eclipse/jgit/lib/WholePackedObjectLoader.java  |    0
 .../java}/org/eclipse/jgit/lib/WindowCache.java    |    0
 .../org/eclipse/jgit/lib/WindowCacheConfig.java    |    0
 .../java}/org/eclipse/jgit/lib/WindowCursor.java   |    0
 .../org/eclipse/jgit/lib/WorkDirCheckout.java      |    0
 .../main/java}/org/eclipse/jgit/lib/WriteTree.java |    0
 .../org/eclipse/jgit/merge/MergeStrategy.java      |    0
 .../main/java}/org/eclipse/jgit/merge/Merger.java  |    0
 .../org/eclipse/jgit/merge/StrategyOneSided.java   |    0
 .../jgit/merge/StrategySimpleTwoWayInCore.java     |    0
 .../eclipse/jgit/merge/ThreeWayMergeStrategy.java  |    0
 .../org/eclipse/jgit/merge/ThreeWayMerger.java     |    0
 .../java}/org/eclipse/jgit/patch/BinaryHunk.java   |    0
 .../org/eclipse/jgit/patch/CombinedFileHeader.java |    0
 .../org/eclipse/jgit/patch/CombinedHunkHeader.java |    0
 .../java}/org/eclipse/jgit/patch/FileHeader.java   |    0
 .../java}/org/eclipse/jgit/patch/FormatError.java  |    0
 .../java}/org/eclipse/jgit/patch/HunkHeader.java   |    0
 .../main/java}/org/eclipse/jgit/patch/Patch.java   |    0
 .../eclipse/jgit/revplot/AbstractPlotRenderer.java |    0
 .../java}/org/eclipse/jgit/revplot/PlotCommit.java |    0
 .../org/eclipse/jgit/revplot/PlotCommitList.java   |    0
 .../java}/org/eclipse/jgit/revplot/PlotLane.java   |    0
 .../java}/org/eclipse/jgit/revplot/PlotWalk.java   |    0
 .../org/eclipse/jgit/revwalk/AbstractRevQueue.java |    0
 .../org/eclipse/jgit/revwalk/BlockObjQueue.java    |    0
 .../org/eclipse/jgit/revwalk/BlockRevQueue.java    |    0
 .../eclipse/jgit/revwalk/BoundaryGenerator.java    |    0
 .../org/eclipse/jgit/revwalk/DateRevQueue.java     |    0
 .../org/eclipse/jgit/revwalk/DelayRevQueue.java    |    0
 .../org/eclipse/jgit/revwalk/EndGenerator.java     |    0
 .../org/eclipse/jgit/revwalk/FIFORevQueue.java     |    0
 .../jgit/revwalk/FixUninterestingGenerator.java    |    0
 .../java}/org/eclipse/jgit/revwalk/FooterKey.java  |    0
 .../java}/org/eclipse/jgit/revwalk/FooterLine.java |    0
 .../java}/org/eclipse/jgit/revwalk/Generator.java  |    0
 .../org/eclipse/jgit/revwalk/LIFORevQueue.java     |    0
 .../eclipse/jgit/revwalk/MergeBaseGenerator.java   |    0
 .../java}/org/eclipse/jgit/revwalk/ObjectWalk.java |    0
 .../org/eclipse/jgit/revwalk/PendingGenerator.java |    0
 .../java}/org/eclipse/jgit/revwalk/RevBlob.java    |    0
 .../java}/org/eclipse/jgit/revwalk/RevCommit.java  |    0
 .../org/eclipse/jgit/revwalk/RevCommitList.java    |    0
 .../java}/org/eclipse/jgit/revwalk/RevFlag.java    |    0
 .../java}/org/eclipse/jgit/revwalk/RevFlagSet.java |    0
 .../java}/org/eclipse/jgit/revwalk/RevObject.java  |    0
 .../org/eclipse/jgit/revwalk/RevObjectList.java    |    0
 .../java}/org/eclipse/jgit/revwalk/RevSort.java    |    0
 .../java}/org/eclipse/jgit/revwalk/RevTag.java     |    0
 .../java}/org/eclipse/jgit/revwalk/RevTree.java    |    0
 .../java}/org/eclipse/jgit/revwalk/RevWalk.java    |    0
 .../org/eclipse/jgit/revwalk/RewriteGenerator.java |    0
 .../eclipse/jgit/revwalk/RewriteTreeFilter.java    |    0
 .../org/eclipse/jgit/revwalk/StartGenerator.java   |    0
 .../eclipse/jgit/revwalk/TopoSortGenerator.java    |    0
 .../eclipse/jgit/revwalk/filter/AndRevFilter.java  |    0
 .../jgit/revwalk/filter/AuthorRevFilter.java       |    0
 .../jgit/revwalk/filter/CommitTimeRevFilter.java   |    0
 .../jgit/revwalk/filter/CommitterRevFilter.java    |    0
 .../jgit/revwalk/filter/MessageRevFilter.java      |    0
 .../eclipse/jgit/revwalk/filter/NotRevFilter.java  |    0
 .../eclipse/jgit/revwalk/filter/OrRevFilter.java   |    0
 .../jgit/revwalk/filter/PatternMatchRevFilter.java |    0
 .../org/eclipse/jgit/revwalk/filter/RevFilter.java |    0
 .../eclipse/jgit/revwalk/filter/RevFlagFilter.java |    0
 .../jgit/revwalk/filter/SubStringRevFilter.java    |    0
 .../java}/org/eclipse/jgit/transport/AmazonS3.java |    0
 .../org/eclipse/jgit/transport/BaseConnection.java |    0
 .../jgit/transport/BaseFetchConnection.java        |    0
 .../eclipse/jgit/transport/BasePackConnection.java |    0
 .../jgit/transport/BasePackFetchConnection.java    |    0
 .../jgit/transport/BasePackPushConnection.java     |    0
 .../jgit/transport/BundleFetchConnection.java      |    0
 .../org/eclipse/jgit/transport/BundleWriter.java   |    0
 .../org/eclipse/jgit/transport/Connection.java     |    0
 .../java}/org/eclipse/jgit/transport/Daemon.java   |    0
 .../org/eclipse/jgit/transport/DaemonClient.java   |    0
 .../org/eclipse/jgit/transport/DaemonService.java  |    0
 .../jgit/transport/DefaultSshSessionFactory.java   |    0
 .../eclipse/jgit/transport/FetchConnection.java    |    0
 .../eclipse/jgit/transport/FetchHeadRecord.java    |    0
 .../org/eclipse/jgit/transport/FetchProcess.java   |    0
 .../org/eclipse/jgit/transport/FetchResult.java    |    0
 .../org/eclipse/jgit/transport/HttpTransport.java  |    0
 .../org/eclipse/jgit/transport/IndexPack.java      |    0
 .../java}/org/eclipse/jgit/transport/LongMap.java  |    0
 .../org/eclipse/jgit/transport/OpenSshConfig.java  |    0
 .../eclipse/jgit/transport/OperationResult.java    |    0
 .../org/eclipse/jgit/transport/PackTransport.java  |    0
 .../eclipse/jgit/transport/PackedObjectInfo.java   |    0
 .../org/eclipse/jgit/transport/PacketLineIn.java   |    0
 .../org/eclipse/jgit/transport/PacketLineOut.java  |    0
 .../eclipse/jgit/transport/PostReceiveHook.java    |    0
 .../org/eclipse/jgit/transport/PreReceiveHook.java |    0
 .../org/eclipse/jgit/transport/PushConnection.java |    0
 .../org/eclipse/jgit/transport/PushProcess.java    |    0
 .../org/eclipse/jgit/transport/PushResult.java     |    0
 .../org/eclipse/jgit/transport/ReceiveCommand.java |    0
 .../org/eclipse/jgit/transport/ReceivePack.java    |    0
 .../org/eclipse/jgit/transport/RefAdvertiser.java  |    0
 .../java}/org/eclipse/jgit/transport/RefSpec.java  |    0
 .../org/eclipse/jgit/transport/RemoteConfig.java   |    0
 .../eclipse/jgit/transport/RemoteRefUpdate.java    |    0
 .../jgit/transport/SideBandInputStream.java        |    0
 .../jgit/transport/SideBandOutputStream.java       |    0
 .../jgit/transport/SideBandProgressMonitor.java    |    0
 .../jgit/transport/SshConfigSessionFactory.java    |    0
 .../eclipse/jgit/transport/SshSessionFactory.java  |    0
 .../org/eclipse/jgit/transport/SshTransport.java   |    0
 .../java}/org/eclipse/jgit/transport/TagOpt.java   |    0
 .../org/eclipse/jgit/transport/TcpTransport.java   |    0
 .../eclipse/jgit/transport/TrackingRefUpdate.java  |    0
 .../org/eclipse/jgit/transport/Transport.java      |    0
 .../eclipse/jgit/transport/TransportAmazonS3.java  |    0
 .../eclipse/jgit/transport/TransportBundle.java    |    0
 .../jgit/transport/TransportBundleFile.java        |    0
 .../jgit/transport/TransportBundleStream.java      |    0
 .../eclipse/jgit/transport/TransportGitAnon.java   |    0
 .../eclipse/jgit/transport/TransportGitSsh.java    |    0
 .../org/eclipse/jgit/transport/TransportHttp.java  |    0
 .../org/eclipse/jgit/transport/TransportLocal.java |    0
 .../org/eclipse/jgit/transport/TransportSftp.java  |    0
 .../java}/org/eclipse/jgit/transport/URIish.java   |    0
 .../org/eclipse/jgit/transport/UploadPack.java     |    0
 .../org/eclipse/jgit/transport/WalkEncryption.java |    0
 .../jgit/transport/WalkFetchConnection.java        |    0
 .../eclipse/jgit/transport/WalkPushConnection.java |    0
 .../jgit/transport/WalkRemoteObjectDatabase.java   |    0
 .../org/eclipse/jgit/transport/WalkTransport.java  |    0
 .../jgit/treewalk/AbstractTreeIterator.java        |    0
 .../eclipse/jgit/treewalk/CanonicalTreeParser.java |    0
 .../eclipse/jgit/treewalk/EmptyTreeIterator.java   |    0
 .../eclipse/jgit/treewalk/FileTreeIterator.java    |    0
 .../jgit/treewalk/NameConflictTreeWalk.java        |    0
 .../java}/org/eclipse/jgit/treewalk/TreeWalk.java  |    0
 .../eclipse/jgit/treewalk/WorkingTreeIterator.java |    0
 .../jgit/treewalk/filter/AndTreeFilter.java        |    0
 .../jgit/treewalk/filter/NotTreeFilter.java        |    0
 .../eclipse/jgit/treewalk/filter/OrTreeFilter.java |    0
 .../eclipse/jgit/treewalk/filter/PathFilter.java   |    0
 .../jgit/treewalk/filter/PathFilterGroup.java      |    0
 .../jgit/treewalk/filter/PathSuffixFilter.java     |    0
 .../eclipse/jgit/treewalk/filter/TreeFilter.java   |    0
 .../main/java}/org/eclipse/jgit/util/Base64.java   |    0
 .../src/main/java}/org/eclipse/jgit/util/FS.java   |    0
 .../org/eclipse/jgit/util/FS_POSIX_Java5.java      |    0
 .../org/eclipse/jgit/util/FS_POSIX_Java6.java      |    0
 .../main/java}/org/eclipse/jgit/util/FS_Win32.java |    0
 .../org/eclipse/jgit/util/FS_Win32_Cygwin.java     |    0
 .../java}/org/eclipse/jgit/util/HttpSupport.java   |    0
 .../main/java}/org/eclipse/jgit/util/IntList.java  |    0
 .../org/eclipse/jgit/util/MutableInteger.java      |    0
 .../src/main/java}/org/eclipse/jgit/util/NB.java   |    0
 .../java}/org/eclipse/jgit/util/QuotedString.java  |    0
 .../org/eclipse/jgit/util/RawCharSequence.java     |    0
 .../java}/org/eclipse/jgit/util/RawParseUtils.java |    0
 .../org/eclipse/jgit/util/RawSubStringPattern.java |    0
 .../java}/org/eclipse/jgit/util/StringUtils.java   |    0
 .../java}/org/eclipse/jgit/util/SystemReader.java  |    0
 .../org/eclipse/jgit/util/TemporaryBuffer.java     |    0
 .../org/eclipse/jgit/util/io/InterruptTimer.java   |    0
 .../eclipse/jgit/util/io/TimeoutInputStream.java   |    0
 .../eclipse/jgit/util/io/TimeoutOutputStream.java  |    0
 .../src/main/resources}/META-INF/MANIFEST.MF       |    0
 .../eclipse/jgit/diff/DiffFormatterReflowTest.java |    0
 .../java}/org/eclipse/jgit/diff/EditListTest.java  |    0
 .../test/java}/org/eclipse/jgit/diff/EditTest.java |    0
 .../java}/org/eclipse/jgit/diff/RawTextTest.java   |    0
 .../eclipse/jgit/dircache/DirCacheBasicTest.java   |    0
 .../jgit/dircache/DirCacheBuilderIteratorTest.java |    0
 .../eclipse/jgit/dircache/DirCacheBuilderTest.java |    0
 .../dircache/DirCacheCGitCompatabilityTest.java    |    0
 .../eclipse/jgit/dircache/DirCacheFindTest.java    |    0
 .../jgit/dircache/DirCacheIteratorTest.java        |    0
 .../jgit/dircache/DirCacheLargePathTest.java       |    0
 .../eclipse/jgit/dircache/DirCacheTreeTest.java    |    0
 .../eclipse/jgit/fnmatch/FileNameMatcherTest.java  |    0
 .../eclipse/jgit/lib/AbbreviatedObjectIdTest.java  |    0
 .../org/eclipse/jgit/lib/ConcurrentRepackTest.java |    0
 .../eclipse/jgit/lib/ConstantsEncodingTest.java    |    0
 .../java}/org/eclipse/jgit/lib/IndexDiffTest.java  |    0
 .../org/eclipse/jgit/lib/IndexTreeWalkerTest.java  |    0
 .../org/eclipse/jgit/lib/MockSystemReader.java     |    0
 .../org/eclipse/jgit/lib/ObjectCheckerTest.java    |    0
 .../org/eclipse/jgit/lib/PackIndexTestCase.java    |    0
 .../org/eclipse/jgit/lib/PackIndexV1Test.java      |    0
 .../org/eclipse/jgit/lib/PackIndexV2Test.java      |    0
 .../org/eclipse/jgit/lib/PackReverseIndexTest.java |    0
 .../java}/org/eclipse/jgit/lib/PackWriterTest.java |    0
 .../java}/org/eclipse/jgit/lib/ReadTreeTest.java   |    0
 .../test/java}/org/eclipse/jgit/lib/RefTest.java   |    0
 .../java}/org/eclipse/jgit/lib/RefUpdateTest.java  |    0
 .../org/eclipse/jgit/lib/ReflogReaderTest.java     |    0
 .../org/eclipse/jgit/lib/RepositoryCacheTest.java  |    0
 .../org/eclipse/jgit/lib/RepositoryConfigTest.java |    0
 .../org/eclipse/jgit/lib/RepositoryTestCase.java   |    0
 .../java}/org/eclipse/jgit/lib/SpeedTestBase.java  |    0
 .../java}/org/eclipse/jgit/lib/T0001_ObjectId.java |    0
 .../org/eclipse/jgit/lib/T0001_PersonIdent.java    |    0
 .../java}/org/eclipse/jgit/lib/T0002_Tree.java     |    0
 .../java}/org/eclipse/jgit/lib/T0003_Basic.java    |    0
 .../org/eclipse/jgit/lib/T0004_PackReader.java     |    0
 .../jgit/lib/T0005_ShallowSpeedTckTest.java        |    4 +-
 .../eclipse/jgit/lib/T0006_DeepSpeedTckTest.java   |    4 +-
 .../java}/org/eclipse/jgit/lib/T0007_Index.java    |    0
 .../org/eclipse/jgit/lib/T0008_testparserev.java   |    0
 .../eclipse/jgit/lib/TreeIteratorLeafOnlyTest.java |    0
 .../jgit/lib/TreeIteratorPostOrderTest.java        |    0
 .../eclipse/jgit/lib/TreeIteratorPreOrderTest.java |    0
 .../org/eclipse/jgit/lib/ValidRefNameTest.java     |    0
 .../org/eclipse/jgit/lib/WindowCacheGetTest.java   |    0
 .../jgit/lib/WindowCacheReconfigureTest.java       |    0
 .../org/eclipse/jgit/lib/WorkDirCheckoutTest.java  |    0
 .../java}/org/eclipse/jgit/lib/XInputStream.java   |    0
 .../java}/org/eclipse/jgit/lib/empty.gitindex.dat  |  Bin 32 -> 32 bytes
 .../org/eclipse/jgit/lib/sorttest.gitindex.dat     |  Bin 288 -> 288 bytes
 .../org/eclipse/jgit/merge/CherryPickTest.java     |    0
 .../org/eclipse/jgit/merge/SimpleMergeTest.java    |    0
 .../jgit/patch/EGitPatchHistoryTckTest.java        |    2 +-
 .../java}/org/eclipse/jgit/patch/EditListTest.java |    0
 .../org/eclipse/jgit/patch/FileHeaderTest.java     |    0
 .../java}/org/eclipse/jgit/patch/GetTextTest.java  |    0
 .../org/eclipse/jgit/patch/PatchCcErrorTest.java   |    0
 .../java}/org/eclipse/jgit/patch/PatchCcTest.java  |    0
 .../org/eclipse/jgit/patch/PatchErrorTest.java     |    0
 .../java}/org/eclipse/jgit/patch/PatchTest.java    |    0
 .../jgit/revwalk/AlwaysEmptyRevQueueTest.java      |    0
 .../org/eclipse/jgit/revwalk/DateRevQueueTest.java |    0
 .../org/eclipse/jgit/revwalk/FIFORevQueueTest.java |    0
 .../org/eclipse/jgit/revwalk/FooterLineTest.java   |    0
 .../org/eclipse/jgit/revwalk/LIFORevQueueTest.java |    0
 .../org/eclipse/jgit/revwalk/ObjectWalkTest.java   |    0
 .../eclipse/jgit/revwalk/RevCommitParseTest.java   |    0
 .../org/eclipse/jgit/revwalk/RevFlagSetTest.java   |    0
 .../org/eclipse/jgit/revwalk/RevObjectTest.java    |    0
 .../org/eclipse/jgit/revwalk/RevQueueTestCase.java |    0
 .../org/eclipse/jgit/revwalk/RevTagParseTest.java  |    0
 .../org/eclipse/jgit/revwalk/RevWalkCullTest.java  |    0
 .../eclipse/jgit/revwalk/RevWalkFilterTest.java    |    0
 .../eclipse/jgit/revwalk/RevWalkMergeBaseTest.java |    0
 .../jgit/revwalk/RevWalkPathFilter1Test.java       |    0
 .../jgit/revwalk/RevWalkPathFilter6012Test.java    |    0
 .../org/eclipse/jgit/revwalk/RevWalkSortTest.java  |    0
 .../org/eclipse/jgit/revwalk/RevWalkTestCase.java  |    0
 .../eclipse/jgit/transport/BundleWriterTest.java   |    0
 .../org/eclipse/jgit/transport/IndexPackTest.java  |    0
 .../org/eclipse/jgit/transport/LongMapTest.java    |    0
 .../eclipse/jgit/transport/OpenSshConfigTest.java  |    0
 .../eclipse/jgit/transport/PacketLineInTest.java   |    0
 .../eclipse/jgit/transport/PacketLineOutTest.java  |    0
 .../eclipse/jgit/transport/PushProcessTest.java    |    0
 .../org/eclipse/jgit/transport/RefSpecTest.java    |    0
 .../eclipse/jgit/transport/RemoteConfigTest.java   |    0
 .../jgit/transport/SideBandOutputStreamTest.java   |    0
 .../org/eclipse/jgit/transport/TransportTest.java  |    0
 .../org/eclipse/jgit/transport/URIishTest.java     |    0
 .../jgit/treewalk/AbstractTreeIteratorTest.java    |    0
 .../jgit/treewalk/CanonicalTreeParserTest.java     |    0
 .../jgit/treewalk/EmptyTreeIteratorTest.java       |    0
 .../jgit/treewalk/FileTreeIteratorTest.java        |    0
 .../jgit/treewalk/NameConflictTreeWalkTest.java    |    0
 .../jgit/treewalk/PostOrderTreeWalkTest.java       |    0
 .../jgit/treewalk/TreeWalkBasicDiffTest.java       |    0
 .../treewalk/filter/AlwaysCloneTreeFilter.java     |    0
 .../jgit/treewalk/filter/NotTreeFilterTest.java    |    0
 .../jgit/treewalk/filter/PathSuffixFilterTest.java |    2 +-
 .../jgit/treewalk/filter/TreeFilterTest.java       |    0
 .../java}/org/eclipse/jgit/util/IntListTest.java   |    0
 .../java}/org/eclipse/jgit/util/JGitTestUtil.java  |    0
 .../test/java}/org/eclipse/jgit/util/NBTest.java   |    0
 .../jgit/util/QuotedStringBourneStyleTest.java     |    0
 .../util/QuotedStringBourneUserPathStyleTest.java  |    0
 .../jgit/util/QuotedStringGitPathStyleTest.java    |    0
 .../jgit/util/RawParseUtils_HexParseTest.java      |    0
 .../jgit/util/RawParseUtils_LineMapTest.java       |    0
 .../eclipse/jgit/util/RawParseUtils_MatchTest.java |    0
 .../org/eclipse/jgit/util/StringUtilsTest.java     |    0
 .../org/eclipse/jgit/util/TemporaryBufferTest.java |    0
 .../test/java}/org/eclipse/jgit/util/TestRng.java  |    0
 .../jgit/util/io/TimeoutInputStreamTest.java       |    0
 .../jgit/util/io/TimeoutOutputStreamTest.java      |    0
 .../test/resources}/org/eclipse/jgit/diff/E.patch  |    0
 .../resources}/org/eclipse/jgit/diff/E_PostImage   |    0
 .../resources}/org/eclipse/jgit/diff/E_PreImage    |    0
 .../test/resources}/org/eclipse/jgit/diff/X.patch  |    0
 .../resources}/org/eclipse/jgit/diff/X_PostImage   |    0
 .../resources}/org/eclipse/jgit/diff/X_PreImage    |    0
 .../test/resources}/org/eclipse/jgit/diff/Y.patch  |    0
 .../resources}/org/eclipse/jgit/diff/Y_PostImage   |    0
 .../resources}/org/eclipse/jgit/diff/Y_PreImage    |    0
 .../test/resources}/org/eclipse/jgit/diff/Z.patch  |    0
 .../resources}/org/eclipse/jgit/diff/Z_PostImage   |    0
 .../resources}/org/eclipse/jgit/diff/Z_PreImage    |    0
 .../org/eclipse/jgit/diff/testContext0.out         |    0
 .../org/eclipse/jgit/diff/testContext1.out         |    0
 .../org/eclipse/jgit/diff/testContext10.out        |    0
 .../org/eclipse/jgit/diff/testContext100.out       |    0
 .../org/eclipse/jgit/diff/testContext3.out         |    0
 .../org/eclipse/jgit/diff/testContext5.out         |    0
 .../org/eclipse/jgit/patch/.gitattributes          |    0
 .../eclipse/jgit/patch/testEditList_Types.patch    |    0
 .../eclipse/jgit/patch/testError_BodyTooLong.patch |    0
 .../jgit/patch/testError_CcTruncatedOld.patch      |    0
 .../jgit/patch/testError_DisconnectedHunk.patch    |    0
 .../jgit/patch/testError_GarbageBetweenFiles.patch |    0
 .../patch/testError_GitBinaryNoForwardHunk.patch   |    0
 .../jgit/patch/testError_TruncatedNew.patch        |    0
 .../jgit/patch/testError_TruncatedOld.patch        |    0
 .../jgit/patch/testGetText_BothISO88591.patch      |    0
 .../eclipse/jgit/patch/testGetText_Convert.patch   |    0
 .../eclipse/jgit/patch/testGetText_DiffCc.patch    |    0
 .../eclipse/jgit/patch/testGetText_NoBinary.patch  |    0
 .../jgit/patch/testParse_AddNoNewline.patch        |    0
 .../jgit/patch/testParse_CcDeleteFile.patch        |    0
 .../eclipse/jgit/patch/testParse_CcNewFile.patch   |    0
 .../patch/testParse_ConfigCaseInsensitive.patch    |    0
 .../jgit/patch/testParse_FixNoNewline.patch        |    0
 .../jgit/patch/testParse_GitBinaryDelta.patch      |    0
 .../jgit/patch/testParse_GitBinaryLiteral.patch    |    0
 .../eclipse/jgit/patch/testParse_NoBinary.patch    |    0
 .../eclipse/jgit/patch/testParse_OneFileCc.patch   |    0
 .../jgit/test/resources/all_packed_objects.txt     |    0
 .../eclipse/jgit/test/resources/create-second-pack |    0
 .../org/eclipse/jgit/test/resources/gitgit.index   |  Bin 134799 -> 134799 bytes
 .../org/eclipse/jgit/test/resources/gitgit.lsfiles |    0
 .../org/eclipse/jgit/test/resources/gitgit.lstree  |    0
 ...ck-3280af9c07ee18a87705ef50b0cc4cd20266cf12.idx |  Bin 1296 -> 1296 bytes
 ...k-3280af9c07ee18a87705ef50b0cc4cd20266cf12.pack |  Bin 562 -> 562 bytes
 ...ck-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx |  Bin 1256 -> 1256 bytes
 ...-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2 |  Bin 1296 -> 1296 bytes
 ...k-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack |  Bin 7811 -> 7811 bytes
 ...ck-546ff360fe3488adb20860ce3436a2d6373d2796.idx |  Bin 1324 -> 1324 bytes
 ...k-546ff360fe3488adb20860ce3436a2d6373d2796.pack |  Bin 1265 -> 1265 bytes
 ...ck-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx |  Bin 1100 -> 1100 bytes
 ...k-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack |  Bin 164 -> 164 bytes
 ...ck-cbdeda40019ae0e6e789088ea0f51f164f489d14.idx |  Bin 1240 -> 1240 bytes
 ...k-cbdeda40019ae0e6e789088ea0f51f164f489d14.pack |  Bin 651 -> 651 bytes
 ...ck-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx |  Bin 2976 -> 2976 bytes
 ...-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2 |  Bin 2976 -> 2976 bytes
 ...k-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack |  Bin 5901 -> 5901 bytes
 ...ck-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx |  Bin 1112 -> 1112 bytes
 ...k-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack |  Bin 1643 -> 1643 bytes
 .../org/eclipse/jgit/test/resources/pack-huge.idx  |  Bin 2368 -> 2368 bytes
 .../org/eclipse/jgit/test/resources/packed-refs    |    0
 jgit-maven/.gitignore                              |    1 -
 jgit-maven/jgit/pom.xml                            |  216 -------------
 {org.eclipse.jgit.pgm => jgit-pgm}/.classpath      |    0
 jgit-pgm/.gitignore                                |    2 +
 {org.eclipse.jgit.pgm => jgit-pgm}/.project        |    0
 .../.settings/org.eclipse.core.resources.prefs     |    0
 .../.settings/org.eclipse.core.runtime.prefs       |    0
 .../.settings/org.eclipse.jdt.core.prefs           |    0
 .../.settings/org.eclipse.jdt.ui.prefs             |    0
 jgit.sh => jgit-pgm/jgit.sh                        |   11 +-
 jgit-pgm/pom.xml                                   |  126 ++++++++
 .../org/eclipse/jgit/pgm/AbstractFetchCommand.java |    0
 .../main/java}/org/eclipse/jgit/pgm/Branch.java    |    0
 .../src/main/java}/org/eclipse/jgit/pgm/Clone.java |    0
 .../main/java}/org/eclipse/jgit/pgm/Command.java   |    0
 .../java}/org/eclipse/jgit/pgm/CommandCatalog.java |    0
 .../java}/org/eclipse/jgit/pgm/CommandRef.java     |    0
 .../main/java}/org/eclipse/jgit/pgm/Daemon.java    |    0
 .../src/main/java}/org/eclipse/jgit/pgm/Die.java   |    0
 .../main/java}/org/eclipse/jgit/pgm/DiffTree.java  |    0
 .../src/main/java}/org/eclipse/jgit/pgm/Fetch.java |    0
 .../src/main/java}/org/eclipse/jgit/pgm/Glog.java  |    0
 .../main/java}/org/eclipse/jgit/pgm/IndexPack.java |    0
 .../src/main/java}/org/eclipse/jgit/pgm/Init.java  |    0
 .../src/main/java}/org/eclipse/jgit/pgm/Log.java   |    0
 .../main/java}/org/eclipse/jgit/pgm/LsRemote.java  |    0
 .../main/java}/org/eclipse/jgit/pgm/LsTree.java    |    0
 .../src/main/java}/org/eclipse/jgit/pgm/Main.java  |    0
 .../main/java}/org/eclipse/jgit/pgm/MergeBase.java |    0
 .../src/main/java}/org/eclipse/jgit/pgm/Push.java  |    0
 .../java}/org/eclipse/jgit/pgm/ReceivePack.java    |    0
 .../main/java}/org/eclipse/jgit/pgm/RevList.java   |    0
 .../main/java}/org/eclipse/jgit/pgm/RevParse.java  |    0
 .../org/eclipse/jgit/pgm/RevWalkTextBuiltin.java   |    0
 .../src/main/java}/org/eclipse/jgit/pgm/Rm.java    |    0
 .../main/java}/org/eclipse/jgit/pgm/ShowRef.java   |    0
 .../src/main/java}/org/eclipse/jgit/pgm/Tag.java   |    0
 .../java}/org/eclipse/jgit/pgm/TextBuiltin.java    |    0
 .../java}/org/eclipse/jgit/pgm/UploadPack.java     |    0
 .../main/java}/org/eclipse/jgit/pgm/Version.java   |    0
 .../org/eclipse/jgit/pgm/build/JarLinkUtil.java    |    0
 .../org/eclipse/jgit/pgm/debug/MakeCacheTree.java  |    0
 .../org/eclipse/jgit/pgm/debug/ReadDirCache.java   |    0
 .../eclipse/jgit/pgm/debug/RebuildCommitGraph.java |    0
 .../org/eclipse/jgit/pgm/debug/ShowCacheTree.java  |    0
 .../org/eclipse/jgit/pgm/debug/ShowCommands.java   |    0
 .../org/eclipse/jgit/pgm/debug/ShowDirCache.java   |    0
 .../org/eclipse/jgit/pgm/debug/WriteDirCache.java  |    0
 .../jgit/pgm/opt/AbstractTreeIteratorHandler.java  |    0
 .../org/eclipse/jgit/pgm/opt/CmdLineParser.java    |    0
 .../org/eclipse/jgit/pgm/opt/ObjectIdHandler.java  |    0
 .../jgit/pgm/opt/PathTreeFilterHandler.java        |    0
 .../org/eclipse/jgit/pgm/opt/RefSpecHandler.java   |    0
 .../org/eclipse/jgit/pgm/opt/RevCommitHandler.java |    0
 .../org/eclipse/jgit/pgm/opt/RevTreeHandler.java   |    0
 .../eclipse/jgit/pgm/opt/SubcommandHandler.java    |    0
 .../services/org.eclipse.jgit.pgm.TextBuiltin      |    0
 licenses/JSch.LICENSE.txt                          |   30 ++
 licenses/args4j.LICENSE.txt                        |   32 ++
 make_jgit.sh                                       |  132 --------
 org.eclipse.jgit.pgm/.gitignore                    |    1 -
 org.eclipse.jgit.test/.classpath                   |   11 -
 org.eclipse.jgit.test/.gitignore                   |    3 -
 org.eclipse.jgit.test/.project                     |   17 -
 .../.settings/org.eclipse.core.resources.prefs     |    6 -
 .../.settings/org.eclipse.core.runtime.prefs       |    3 -
 .../.settings/org.eclipse.jdt.core.prefs           |  320 -------------------
 .../.settings/org.eclipse.jdt.ui.prefs             |   10 -
 org.eclipse.jgit/.gitignore                        |    1 -
 pom.xml                                            |  331 ++++++++++++++++++++
 562 files changed, 676 insertions(+), 733 deletions(-)
 rename {org.eclipse.jgit => jgit-core}/.classpath (100%)
 rename {org.eclipse.jgit => jgit-core}/.fbprefs (100%)
 create mode 100644 jgit-core/.gitignore
 rename {org.eclipse.jgit => jgit-core}/.project (100%)
 rename {org.eclipse.jgit => jgit-core}/.settings/org.eclipse.core.resources.prefs (100%)
 rename {org.eclipse.jgit => jgit-core}/.settings/org.eclipse.core.runtime.prefs (100%)
 rename {org.eclipse.jgit => jgit-core}/.settings/org.eclipse.jdt.core.prefs (100%)
 rename {org.eclipse.jgit.pgm => jgit-core}/.settings/org.eclipse.jdt.ui.prefs (100%)
 rename {org.eclipse.jgit => jgit-core}/build.properties (100%)
 rename {org.eclipse.jgit => jgit-core}/findBugs/FindBugsExcludeFilter.xml (100%)
 rename {org.eclipse.jgit.test => jgit-core}/org.eclipse.jgit.core--All-External-Tests (Java 6).launch (100%)
 rename {org.eclipse.jgit.test => jgit-core}/org.eclipse.jgit.core--All-External-Tests.launch (100%)
 rename {org.eclipse.jgit.test => jgit-core}/org.eclipse.jgit.core--All-Tests (Java 6).launch (100%)
 rename {org.eclipse.jgit.test => jgit-core}/org.eclipse.jgit.core--All-Tests.launch (100%)
 rename {org.eclipse.jgit => jgit-core}/plugin.properties (100%)
 create mode 100644 jgit-core/pom.xml
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/awtui/AWTPlotRenderer.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/awtui/AwtAuthenticator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/awtui/CommitGraphPane.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/awtui/SwingCommitList.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/diff/DiffFormatter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/diff/Edit.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/diff/EditList.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/diff/RawText.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/diff/Sequence.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/dircache/BaseDirCacheEditor.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/dircache/DirCache.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/dircache/DirCacheBuildIterator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/dircache/DirCacheBuilder.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/dircache/DirCacheEditor.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/dircache/DirCacheEntry.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/dircache/DirCacheIterator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/dircache/DirCacheTree.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/CheckoutConflictException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/CompoundException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/ConfigInvalidException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/CorruptObjectException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/EntryExistsException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/GitlinksNotSupportedException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/IncorrectObjectTypeException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/InvalidObjectIdException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/InvalidPatternException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/MissingBundlePrerequisiteException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/MissingObjectException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/NoClosingBracketException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/NoRemoteRepositoryException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/NotSupportedException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/ObjectWritingException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/PackInvalidException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/PackMismatchException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/PackProtocolException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/RepositoryNotFoundException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/RevWalkException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/RevisionSyntaxException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/StopWalkException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/SymlinksNotSupportedException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/TransportException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/errors/UnmergedPathException.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/fnmatch/AbstractHead.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/fnmatch/CharacterHead.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/fnmatch/FileNameMatcher.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/fnmatch/GroupHead.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/fnmatch/Head.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/fnmatch/LastHead.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/fnmatch/RestrictedWildCardHead.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/fnmatch/WildCardHead.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/AbbreviatedObjectId.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/AbstractIndexTreeVisitor.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/AlternateRepositoryDatabase.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/AnyObjectId.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/BinaryDelta.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/BlobBasedConfig.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/ByteArrayWindow.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/ByteBufferWindow.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/ByteWindow.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/Commit.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/Config.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/Constants.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/CoreConfig.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/DeltaOfsPackedObjectLoader.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/DeltaPackedObjectLoader.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/DeltaRefPackedObjectLoader.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/FileBasedConfig.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/FileMode.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/FileTreeEntry.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/ForceModified.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/GitIndex.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/GitlinkTreeEntry.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/IndexChangedEvent.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/IndexDiff.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/IndexTreeVisitor.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/IndexTreeWalker.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/InflaterCache.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/LockFile.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/MutableObjectId.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/NullProgressMonitor.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/ObjectChecker.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/ObjectDatabase.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/ObjectDirectory.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/ObjectId.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/ObjectIdSubclassMap.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/ObjectLoader.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/ObjectWriter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/OffsetCache.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/PackFile.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/PackIndex.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/PackIndexV1.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/PackIndexV2.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/PackIndexWriter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/PackIndexWriterV1.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/PackIndexWriterV2.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/PackLock.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/PackOutputStream.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/PackReverseIndex.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/PackWriter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/PackedObjectLoader.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/PersonIdent.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/ProgressMonitor.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/Ref.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/RefComparator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/RefDatabase.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/RefLogWriter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/RefRename.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/RefUpdate.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/RefWriter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/ReflogReader.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/RefsChangedEvent.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/Repository.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/RepositoryAdapter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/RepositoryCache.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/RepositoryChangedEvent.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/RepositoryConfig.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/RepositoryListener.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/RepositoryState.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/SymlinkTreeEntry.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/Tag.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/TextProgressMonitor.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/TransferConfig.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/Tree.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/TreeEntry.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/TreeIterator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/TreeVisitor.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/TreeVisitorWithCurrentDirectory.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/Treeish.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/UnpackedObjectCache.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/UnpackedObjectLoader.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/UserConfig.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/WholePackedObjectLoader.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/WindowCache.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/WindowCacheConfig.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/WindowCursor.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/WorkDirCheckout.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/lib/WriteTree.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/merge/MergeStrategy.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/merge/Merger.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/merge/StrategyOneSided.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/merge/StrategySimpleTwoWayInCore.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/merge/ThreeWayMergeStrategy.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/merge/ThreeWayMerger.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/patch/BinaryHunk.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/patch/CombinedFileHeader.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/patch/CombinedHunkHeader.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/patch/FileHeader.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/patch/FormatError.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/patch/HunkHeader.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/patch/Patch.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revplot/AbstractPlotRenderer.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revplot/PlotCommit.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revplot/PlotCommitList.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revplot/PlotLane.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revplot/PlotWalk.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/AbstractRevQueue.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/BlockObjQueue.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/BlockRevQueue.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/BoundaryGenerator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/DateRevQueue.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/DelayRevQueue.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/EndGenerator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/FIFORevQueue.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/FixUninterestingGenerator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/FooterKey.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/FooterLine.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/Generator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/LIFORevQueue.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/MergeBaseGenerator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/ObjectWalk.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/PendingGenerator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/RevBlob.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/RevCommit.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/RevCommitList.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/RevFlag.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/RevFlagSet.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/RevObject.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/RevObjectList.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/RevSort.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/RevTag.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/RevTree.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/RevWalk.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/RewriteGenerator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/RewriteTreeFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/StartGenerator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/TopoSortGenerator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/filter/AndRevFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/filter/AuthorRevFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/filter/CommitTimeRevFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/filter/CommitterRevFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/filter/MessageRevFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/filter/NotRevFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/filter/OrRevFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/filter/PatternMatchRevFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/filter/RevFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/filter/RevFlagFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/revwalk/filter/SubStringRevFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/AmazonS3.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/BaseConnection.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/BaseFetchConnection.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/BasePackConnection.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/BasePackFetchConnection.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/BasePackPushConnection.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/BundleFetchConnection.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/BundleWriter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/Connection.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/Daemon.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/DaemonClient.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/DaemonService.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/DefaultSshSessionFactory.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/FetchConnection.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/FetchHeadRecord.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/FetchProcess.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/FetchResult.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/HttpTransport.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/IndexPack.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/LongMap.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/OpenSshConfig.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/OperationResult.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/PackTransport.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/PackedObjectInfo.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/PacketLineIn.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/PacketLineOut.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/PostReceiveHook.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/PreReceiveHook.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/PushConnection.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/PushProcess.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/PushResult.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/ReceiveCommand.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/ReceivePack.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/RefAdvertiser.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/RefSpec.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/RemoteConfig.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/RemoteRefUpdate.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/SideBandInputStream.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/SideBandOutputStream.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/SideBandProgressMonitor.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/SshConfigSessionFactory.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/SshSessionFactory.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/SshTransport.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/TagOpt.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/TcpTransport.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/TrackingRefUpdate.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/Transport.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/TransportAmazonS3.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/TransportBundle.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/TransportBundleFile.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/TransportBundleStream.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/TransportGitAnon.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/TransportGitSsh.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/TransportHttp.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/TransportLocal.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/TransportSftp.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/URIish.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/UploadPack.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/WalkEncryption.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/WalkFetchConnection.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/WalkPushConnection.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/WalkRemoteObjectDatabase.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/transport/WalkTransport.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/treewalk/AbstractTreeIterator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/treewalk/CanonicalTreeParser.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/treewalk/EmptyTreeIterator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/treewalk/FileTreeIterator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/treewalk/NameConflictTreeWalk.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/treewalk/TreeWalk.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/treewalk/WorkingTreeIterator.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/treewalk/filter/AndTreeFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/treewalk/filter/NotTreeFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/treewalk/filter/OrTreeFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/treewalk/filter/PathFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/treewalk/filter/PathFilterGroup.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/treewalk/filter/PathSuffixFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/treewalk/filter/TreeFilter.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/Base64.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/FS.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/FS_POSIX_Java5.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/FS_POSIX_Java6.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/FS_Win32.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/FS_Win32_Cygwin.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/HttpSupport.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/IntList.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/MutableInteger.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/NB.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/QuotedString.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/RawCharSequence.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/RawParseUtils.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/RawSubStringPattern.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/StringUtils.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/SystemReader.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/TemporaryBuffer.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/io/InterruptTimer.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/io/TimeoutInputStream.java (100%)
 rename {org.eclipse.jgit/src => jgit-core/src/main/java}/org/eclipse/jgit/util/io/TimeoutOutputStream.java (100%)
 rename {org.eclipse.jgit => jgit-core/src/main/resources}/META-INF/MANIFEST.MF (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/diff/DiffFormatterReflowTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/diff/EditListTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/diff/EditTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/diff/RawTextTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/dircache/DirCacheBasicTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/dircache/DirCacheBuilderIteratorTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/dircache/DirCacheBuilderTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/dircache/DirCacheCGitCompatabilityTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/dircache/DirCacheFindTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/dircache/DirCacheIteratorTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/dircache/DirCacheLargePathTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/dircache/DirCacheTreeTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/fnmatch/FileNameMatcherTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/AbbreviatedObjectIdTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/ConcurrentRepackTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/ConstantsEncodingTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/IndexDiffTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/IndexTreeWalkerTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/MockSystemReader.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/ObjectCheckerTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/PackIndexTestCase.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/PackIndexV1Test.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/PackIndexV2Test.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/PackReverseIndexTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/PackWriterTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/ReadTreeTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/RefTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/RefUpdateTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/ReflogReaderTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/RepositoryCacheTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/RepositoryConfigTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/RepositoryTestCase.java (100%)
 rename {org.eclipse.jgit.test/exttst => jgit-core/src/test/java}/org/eclipse/jgit/lib/SpeedTestBase.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/T0001_ObjectId.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/T0001_PersonIdent.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/T0002_Tree.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/T0003_Basic.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/T0004_PackReader.java (100%)
 rename org.eclipse.jgit.test/exttst/org/eclipse/jgit/lib/T0005_ShallowSpeedTest.java => jgit-core/src/test/java/org/eclipse/jgit/lib/T0005_ShallowSpeedTckTest.java (96%)
 rename org.eclipse.jgit.test/exttst/org/eclipse/jgit/lib/T0006_DeepSpeedTest.java => jgit-core/src/test/java/org/eclipse/jgit/lib/T0006_DeepSpeedTckTest.java (96%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/T0007_Index.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/T0008_testparserev.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/TreeIteratorLeafOnlyTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/TreeIteratorPostOrderTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/TreeIteratorPreOrderTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/ValidRefNameTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/WindowCacheGetTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/WindowCacheReconfigureTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/WorkDirCheckoutTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/XInputStream.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/empty.gitindex.dat (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/lib/sorttest.gitindex.dat (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/merge/CherryPickTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/merge/SimpleMergeTest.java (100%)
 rename org.eclipse.jgit.test/exttst/org/eclipse/jgit/patch/EGitPatchHistoryTest.java => jgit-core/src/test/java/org/eclipse/jgit/patch/EGitPatchHistoryTckTest.java (99%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/patch/EditListTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/patch/FileHeaderTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/patch/GetTextTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/patch/PatchCcErrorTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/patch/PatchCcTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/patch/PatchErrorTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/patch/PatchTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/AlwaysEmptyRevQueueTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/DateRevQueueTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/FIFORevQueueTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/FooterLineTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/LIFORevQueueTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/ObjectWalkTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/RevCommitParseTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/RevFlagSetTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/RevObjectTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/RevQueueTestCase.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/RevTagParseTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/RevWalkCullTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/RevWalkFilterTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/RevWalkMergeBaseTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/RevWalkPathFilter1Test.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/RevWalkPathFilter6012Test.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/RevWalkSortTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/revwalk/RevWalkTestCase.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/transport/BundleWriterTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/transport/IndexPackTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/transport/LongMapTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/transport/OpenSshConfigTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/transport/PacketLineInTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/transport/PacketLineOutTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/transport/PushProcessTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/transport/RefSpecTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/transport/RemoteConfigTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/transport/SideBandOutputStreamTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/transport/TransportTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/transport/URIishTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/treewalk/AbstractTreeIteratorTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/treewalk/CanonicalTreeParserTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/treewalk/EmptyTreeIteratorTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/treewalk/FileTreeIteratorTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/treewalk/NameConflictTreeWalkTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/treewalk/PostOrderTreeWalkTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/treewalk/TreeWalkBasicDiffTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/treewalk/filter/AlwaysCloneTreeFilter.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/treewalk/filter/NotTreeFilterTest.java (100%)
 rename org.eclipse.jgit.test/tst/org/eclipse/jgit/treewalk/filter/PathSuffixFilterTestCase.java => jgit-core/src/test/java/org/eclipse/jgit/treewalk/filter/PathSuffixFilterTest.java (98%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/treewalk/filter/TreeFilterTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/util/IntListTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/util/JGitTestUtil.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/util/NBTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/util/QuotedStringBourneStyleTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/util/QuotedStringBourneUserPathStyleTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/util/QuotedStringGitPathStyleTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/util/RawParseUtils_HexParseTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/util/RawParseUtils_LineMapTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/util/RawParseUtils_MatchTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/util/StringUtilsTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/util/TemporaryBufferTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/util/TestRng.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/util/io/TimeoutInputStreamTest.java (100%)
 rename {org.eclipse.jgit.test/tst => jgit-core/src/test/java}/org/eclipse/jgit/util/io/TimeoutOutputStreamTest.java (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/E.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/E_PostImage (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/E_PreImage (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/X.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/X_PostImage (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/X_PreImage (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/Y.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/Y_PostImage (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/Y_PreImage (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/Z.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/Z_PostImage (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/Z_PreImage (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/testContext0.out (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/testContext1.out (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/testContext10.out (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/testContext100.out (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/testContext3.out (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/diff/testContext5.out (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/.gitattributes (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testEditList_Types.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testError_BodyTooLong.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testError_CcTruncatedOld.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testError_DisconnectedHunk.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testError_GarbageBetweenFiles.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testError_GitBinaryNoForwardHunk.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testError_TruncatedNew.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testError_TruncatedOld.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testGetText_BothISO88591.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testGetText_Convert.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testGetText_DiffCc.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testGetText_NoBinary.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testParse_AddNoNewline.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testParse_CcDeleteFile.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testParse_CcNewFile.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testParse_ConfigCaseInsensitive.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testParse_FixNoNewline.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testParse_GitBinaryDelta.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testParse_GitBinaryLiteral.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testParse_NoBinary.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/patch/testParse_OneFileCc.patch (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/all_packed_objects.txt (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/create-second-pack (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/gitgit.index (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/gitgit.lsfiles (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/gitgit.lstree (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-3280af9c07ee18a87705ef50b0cc4cd20266cf12.idx (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-3280af9c07ee18a87705ef50b0cc4cd20266cf12.pack (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2 (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-546ff360fe3488adb20860ce3436a2d6373d2796.idx (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-546ff360fe3488adb20860ce3436a2d6373d2796.pack (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-cbdeda40019ae0e6e789088ea0f51f164f489d14.idx (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-cbdeda40019ae0e6e789088ea0f51f164f489d14.pack (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2 (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/pack-huge.idx (100%)
 rename {org.eclipse.jgit.test/tst-rsrc => jgit-core/src/test/resources}/org/eclipse/jgit/test/resources/packed-refs (100%)
 delete mode 100644 jgit-maven/.gitignore
 delete mode 100644 jgit-maven/jgit/pom.xml
 rename {org.eclipse.jgit.pgm => jgit-pgm}/.classpath (100%)
 create mode 100644 jgit-pgm/.gitignore
 rename {org.eclipse.jgit.pgm => jgit-pgm}/.project (100%)
 rename {org.eclipse.jgit.pgm => jgit-pgm}/.settings/org.eclipse.core.resources.prefs (100%)
 rename {org.eclipse.jgit.pgm => jgit-pgm}/.settings/org.eclipse.core.runtime.prefs (100%)
 rename {org.eclipse.jgit.pgm => jgit-pgm}/.settings/org.eclipse.jdt.core.prefs (100%)
 rename {org.eclipse.jgit => jgit-pgm}/.settings/org.eclipse.jdt.ui.prefs (100%)
 rename jgit.sh => jgit-pgm/jgit.sh (71%)
 create mode 100644 jgit-pgm/pom.xml
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/AbstractFetchCommand.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/Branch.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/Clone.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/Command.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/CommandCatalog.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/CommandRef.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/Daemon.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/Die.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/DiffTree.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/Fetch.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/Glog.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/IndexPack.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/Init.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/Log.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/LsRemote.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/LsTree.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/Main.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/MergeBase.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/Push.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/ReceivePack.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/RevList.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/RevParse.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/RevWalkTextBuiltin.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/Rm.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/ShowRef.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/Tag.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/TextBuiltin.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/UploadPack.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/Version.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/build/JarLinkUtil.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/debug/MakeCacheTree.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/debug/ReadDirCache.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/debug/RebuildCommitGraph.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/debug/ShowCacheTree.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/debug/ShowCommands.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/debug/ShowDirCache.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/debug/WriteDirCache.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/opt/AbstractTreeIteratorHandler.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/opt/CmdLineParser.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/opt/ObjectIdHandler.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/opt/PathTreeFilterHandler.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/opt/RefSpecHandler.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/opt/RevCommitHandler.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/opt/RevTreeHandler.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/java}/org/eclipse/jgit/pgm/opt/SubcommandHandler.java (100%)
 rename {org.eclipse.jgit.pgm/src => jgit-pgm/src/main/resources}/META-INF/services/org.eclipse.jgit.pgm.TextBuiltin (100%)
 create mode 100644 licenses/JSch.LICENSE.txt
 create mode 100644 licenses/args4j.LICENSE.txt
 delete mode 100755 make_jgit.sh
 delete mode 100644 org.eclipse.jgit.pgm/.gitignore
 delete mode 100644 org.eclipse.jgit.test/.classpath
 delete mode 100644 org.eclipse.jgit.test/.gitignore
 delete mode 100644 org.eclipse.jgit.test/.project
 delete mode 100644 org.eclipse.jgit.test/.settings/org.eclipse.core.resources.prefs
 delete mode 100644 org.eclipse.jgit.test/.settings/org.eclipse.core.runtime.prefs
 delete mode 100644 org.eclipse.jgit.test/.settings/org.eclipse.jdt.core.prefs
 delete mode 100644 org.eclipse.jgit.test/.settings/org.eclipse.jdt.ui.prefs
 delete mode 100644 org.eclipse.jgit/.gitignore
 create mode 100644 pom.xml
