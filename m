From: David Birchfield <dbirchfield@asu.edu>
Subject: RE: jgit merge question
Date: Wed, 14 Jan 2009 15:03:42 -0700
Message-ID: <AB447EEF7BAAB7489B29A4F3F788D02C01CDD792@EX07.asurite.ad.asu.edu>
References: <S1760244AbZANHqN/20090114074613Z+1959@vger.kernel.org> <4EDE3D74-CEA3-473C-ADD1-03B79AAB9EDF@asu.edu> <alpine.DEB.1.00.0901141124460.3586@pacific.mpi-cbg.de> <20090114153034.GZ10179@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 15 00:02:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNEkC-0006SK-5a
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 00:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756492AbZANXAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 18:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756295AbZANXAL
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 18:00:11 -0500
Received: from epo-int2.asu.edu ([129.219.187.21]:28449 "EHLO epo-int2.asu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754956AbZANXAI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 18:00:08 -0500
X-Greylist: delayed 2917 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jan 2009 18:00:08 EST
Received: from exhub2.asurite.ad.asu.edu (exhub2.asurite.ad.asu.edu [129.219.103.60])
	by epo-int2.asu.edu (Switch-3.1.8/Switch-3.1.7/asu-postoffice-prod) with ESMTP id n0EMA2Fv029021
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 14 Jan 2009 15:11:18 -0700
Received: from EX07.asurite.ad.asu.edu (129.219.12.235) by
 exhub2.asurite.ad.asu.edu (129.219.103.60) with Microsoft SMTP Server id
 8.1.336.2; Wed, 14 Jan 2009 15:03:42 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-Class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: jgit merge question
Thread-Index: Acl2XQ0h344fGeoqSP6QmTxuNQ7TbAANf/l7
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105725>

Great - thanks so much for this feedback and link.  My merge needs are straightforward, so hopefully this will suit the need!

I have pulled the latest jgit updates and downloaded the four .java files that are referenced in your link.  I have added these to the directory structure for jgit in the following new folder: org.spearce.jgit/src/org/spearce/jgit/merge/

However, when I try to now make_jgit.sh I am getting a series of errors (pasted below) that appear to stem from not having the same underlying files.  Is it possible that I am not getting the most recent jgit release files?  Or am I misunderstanding how you expect these Merge files to be used?

Thanks again,
David

<errors>
Entering org.spearce.jgit ...
./org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java:45: cannot find symbol
symbol  : class UnmergedPathException
location: package org.spearce.jgit.errors
import org.spearce.jgit.errors.UnmergedPathException;
                               ^
./org/spearce/jgit/merge/Merger.java:184: cannot find symbol
symbol  : constructor CanonicalTreeParser(<nulltype>,org.spearce.jgit.lib.Repository,org.spearce.jgit.revwalk.RevTree,org.spearce.jgit.lib.WindowCursor)
location: class org.spearce.jgit.treewalk.CanonicalTreeParser
			return new CanonicalTreeParser(null, db, base.getTree(), curs);
                               ^
./org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java:98: cannot find symbol
symbol  : method newInCore()
location: class org.spearce.jgit.dircache.DirCache
			cache = DirCache.newInCore();
                                        ^
./org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java:123: cannot find symbol
symbol  : variable STAGE_0
location: class org.spearce.jgit.dircache.DirCacheEntry
					add(T_THEIRS, DirCacheEntry.STAGE_0);
                                                                   ^
./org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java:125: cannot find symbol
symbol  : variable STAGE_0
location: class org.spearce.jgit.dircache.DirCacheEntry
					add(T_OURS, DirCacheEntry.STAGE_0);
                                                                 ^
./org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java:137: cannot find symbol
symbol  : method writeTree(org.spearce.jgit.lib.ObjectWriter)
location: class org.spearce.jgit.dircache.DirCache
				resultTree = cache.writeTree(getObjectWriter());
                                                  ^
./org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java:139: cannot find symbol
symbol  : class UnmergedPathException
location: class org.spearce.jgit.merge.StrategySimpleTwoWayInCore.InCoreMerger
			} catch (UnmergedPathException upe) {
                                 ^
./org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java:147: cannot find symbol
symbol  : method getRawPath()
location: class org.spearce.jgit.treewalk.NameConflictTreeWalk
				builder.addTree(tw.getRawPath(), db, tw.getObjectId(1));
                                                  ^
./org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java:149: cannot find symbol
symbol  : variable STAGE_0
location: class org.spearce.jgit.dircache.DirCacheEntry
				add(T_OURS, DirCacheEntry.STAGE_0);
                                                         ^
./org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java:153: cannot find symbol
symbol  : variable STAGE_1
location: class org.spearce.jgit.dircache.DirCacheEntry
			add(T_BASE, DirCacheEntry.STAGE_1);
                                                 ^
./org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java:154: cannot find symbol
symbol  : variable STAGE_2
location: class org.spearce.jgit.dircache.DirCacheEntry
			add(T_OURS, DirCacheEntry.STAGE_2);
                                                 ^
./org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java:155: cannot find symbol
symbol  : variable STAGE_3
location: class org.spearce.jgit.dircache.DirCacheEntry
			add(T_THEIRS, DirCacheEntry.STAGE_3);
                                                   ^
./org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java:163: cannot find symbol
symbol  : method getRawPath()
location: class org.spearce.jgit.treewalk.NameConflictTreeWalk
				e = new DirCacheEntry(tw.getRawPath(), stage);
                                                        ^
./org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java:163: internal error; cannot instantiate org.spearce.jgit.dircache.DirCacheEntry.<init> at org.spearce.jgit.dircache.DirCacheEntry to ()
				e = new DirCacheEntry(tw.getRawPath(), stage);
                                    ^

</errors




-----Original Message-----

David is probably talking about the 8 patch series I proposed to add a
crude merge API to JGit.  The patches are available here, based on the
current JGit master:

  http://android.git.kernel.org/?p=tools/egit.git;a=shortlog;h=refs/heads/for-gerrit2
  git://android.git.kernel.org/tools/egit.git for-gerrit2
