From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 11:34:39 -0400
Message-ID: <4538EC8F.7020502@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<200610172351.17377.jnareb@gmail.com>	<4535590C.4000004@utoronto.ca>	<200610180057.25411.jnareb@gmail.com>	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>	<20061018053647.GA3507@coredump.intra.peff.net>	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>	<20061018185225.GU20017@pasky.or.cz>	<eh76np$trg$1@sea.gmane.org>	<BAYC1-PASMTP061F10D0B5AF9F6608134CAE0C0@CEZ.ICE>	<4538D724.5040508@utoronto.ca> <ehao3e$2qv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090304020806030504050506"
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 17:35:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GawP6-0003rn-9G
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 17:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946415AbWJTPep (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 11:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946420AbWJTPep
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 11:34:45 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:53910 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1946415AbWJTPen (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 11:34:43 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GawOO-0001MT-00; Fri, 20 Oct 2006 11:34:41 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ehao3e$2qv$1@sea.gmane.org>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29491>

This is a multi-part message in MIME format.
--------------090304020806030504050506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jakub Narebski wrote:
> Aaron Bentley wrote:
>>In Bazaar bundles, the text of the diff is an integral part of the data.
>> It is used to generate the text of all the files in the revision.
> 
> 
> I thought that the diff was combined diff of changes.

It is.  It's a description of how to produce revision X given revision
Y, where Y is the last-merged mainline revision.

>>Bazaar bundles were designed to be used on mailing lists.  So you can
>>review the changes from the diff, comment on them, and if it seems
>>suitable, merge them.
> 
> 
> If you have only mega-diff, you can comment only on this mega-diff.

That is what we prefer to review.

>>>Although that might just make the email bigger for not a lot of
>>>gain.
>>
>>It's my understanding that most changes discussed on lkml are provided
>>as a series of patches.  Bazaar bundles are intended as a direct
>>replacement for patches in that use case.
> 
> 
> As _series_ of patches. You have git-format-patch + git-send-email
> to format and send them, git-am to apply them (as patches, not as branch).

If you want to do it exactly the same way, you send a series of bundles.

The bundle format can also support sending a single bundles that
displays the series of patches, though there's currently no UI to select
this.

> I was under an impression that user sees only mega-patch of all the
> revisions in bundle together, and rest is for machine consumption only.

All of it is for machine consumption.  The MIME-encoded sections are a
series of patches.  They're usually MIME-encoded to avoid confusion with
the overview patch, but this is optional.

I've attached an example of what a combined patch-by-patch bundle looks
like.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFOOyB0F+nu1YWqI0RAtU6AKCJndTNlTTPNnzxZX53lkBUUHTYkwCfePlG
7x3cjpYwh8LXEb5ZWXXmu6s=
=6Lgv
-----END PGP SIGNATURE-----

--------------090304020806030504050506
Content-Type: text/x-patch;
 name="hello-world.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hello-world.patch"

# Bazaar revision bundle v0.8
#
# message:
#   Added 'world'
# committer: Aaron Bentley <abentley@panoramicfeedback.com>
# date: Fri 2006-10-20 11:30:21.903000116 -0400

=== modified file world
--- world
+++ world
@@ -1,1 +1,1 @@
-Hello
+Hello, world

=== modified directory  // last-changed:abentley@panoramicfeedback.com-20061020
... 153021-b5fcea14e9cd2b34
# revision id: abentley@panoramicfeedback.com-20061020153021-b5fcea14e9cd2b34
# sha1: 6d553e72158aaa76c258d98c15cd24922d171cd9
# inventory sha1: 64af82c4d81d9d6ad4f33fc734d32c2a1eaa0df5
# parent ids:
#   abentley@panoramicfeedback.com-20061020152951-10cff5ff5a51e9a2
# properties:
#   branch-nick: bar

# message:
#   Capitalized
# committer: Aaron Bentley <abentley@panoramicfeedback.com>
# date: Fri 2006-10-20 11:29:51.953999996 -0400

=== modified file world
--- world
+++ world
@@ -1,1 +1,1 @@
-hello
+Hello

=== modified directory  // last-changed:abentley@panoramicfeedback.com-20061020
... 152951-10cff5ff5a51e9a2
# revision id: abentley@panoramicfeedback.com-20061020152951-10cff5ff5a51e9a2
# sha1: f7b79934bc3b0a944e35168b5df6b106c5b29ebf
# inventory sha1: 1400d56451752300cc31c9c94ff7ee2188e8ef8c
# parent ids:
#   abentley@panoramicfeedback.com-20061020152935-64bde004f622131f
# properties:
#   branch-nick: bar

# message:
#   initial commit
# committer: Aaron Bentley <abentley@panoramicfeedback.com>
# date: Fri 2006-10-20 11:29:35.536999941 -0400

=== added directory  // file-id:TREE_ROOT
=== added file world // file-id:world-20061020152929-12bknd8mm9mx48as-1
--- /dev/null
+++ world
@@ -0,0 +1,1 @@
+hello

# revision id: abentley@panoramicfeedback.com-20061020152935-64bde004f622131f
# sha1: 0728f761b891b257f0a71e2e360799eec080cd21
# inventory sha1: e52e030ea40f6bf5da78f4e8eb8efcd072b0930a
# properties:
#   branch-nick: bar


--------------090304020806030504050506--
