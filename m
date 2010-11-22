From: Harry Putnam <reader@newsguy.com>
Subject: vcs for hefty video and graphics files
Date: Mon, 22 Nov 2010 12:09:14 -0600
Organization: Still searching...
Message-ID: <877hg55iyd.fsf@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bazaar@lists.canonical.com, users@subversion.apache.org,
	git@vger.kernel.org, info-cvs@gnu.org
To: mercurial@selenic.com
X-From: mercurial-bounces@selenic.com Mon Nov 22 19:46:08 2010
Return-path: <mercurial-bounces@selenic.com>
Envelope-to: gcvmd-mercurial@gmane.org
Received: from waste.org ([173.11.57.241])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <mercurial-bounces@selenic.com>)
	id 1PKbOw-0002eH-FK
	for gcvmd-mercurial@gmane.org; Mon, 22 Nov 2010 19:46:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by waste.org (Postfix) with ESMTP id D28247436F;
	Mon, 22 Nov 2010 12:46:05 -0600 (CST)
X-Virus-Scanned: Debian amavisd-new at waste.org
Received: from waste.org ([127.0.0.1])
	by localhost (waste.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6p+-Y4d0hmXh; Mon, 22 Nov 2010 12:46:00 -0600 (CST)
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (Postfix) with ESMTP id 880C774217;
	Mon, 22 Nov 2010 12:45:40 -0600 (CST)
X-Original-To: mercurial@waste.org
Delivered-To: mercurial@waste.org
Received: from localhost (localhost [127.0.0.1])
	by waste.org (Postfix) with ESMTP id 6A94C7416F
	for <mercurial@waste.org>; Mon, 22 Nov 2010 12:09:37 -0600 (CST)
X-Virus-Scanned: Debian amavisd-new at waste.org
Received: from waste.org ([127.0.0.1])
	by localhost (waste.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Y+RnNSV-HZ7X for <mercurial@waste.org>;
	Mon, 22 Nov 2010 12:09:35 -0600 (CST)
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by waste.org (Postfix) with ESMTP id 4B00F74155
	for <mercurial@selenic.com>; Mon, 22 Nov 2010 12:09:35 -0600 (CST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvmd-mercurial@m.gmane.org>) id 1PKapZ-0000dS-J9
	for mercurial@selenic.com; Mon, 22 Nov 2010 19:09:33 +0100
Received: from c-98-215-178-110.hsd1.in.comcast.net ([98.215.178.110])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <mercurial@selenic.com>; Mon, 22 Nov 2010 19:09:33 +0100
Received: from reader by c-98-215-178-110.hsd1.in.comcast.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <mercurial@selenic.com>; Mon, 22 Nov 2010 19:09:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-98-215-178-110.hsd1.in.comcast.net
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:s9FCSJODTDZxwnaeu3+u8XEXzAs=
X-Mailman-Approved-At: Mon, 22 Nov 2010 12:45:38 -0600
X-BeenThere: mercurial@selenic.com
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <mercurial.selenic.com>
List-Unsubscribe: <http://selenic.com/mailman/options/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=unsubscribe>
List-Archive: <http://selenic.com/pipermail/mercurial>
List-Post: <mailto:mercurial@selenic.com>
List-Help: <mailto:mercurial-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=subscribe>
Sender: mercurial-bounces@selenic.com
Errors-To: mercurial-bounces@selenic.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161908>

I hope not to appear to be sneaking in a war of systems, and may rate
a bit a high in windbag factor since I've asked a very similar
question here but quite a while ago

I'd like to briefly describe my projected usage of a versioning system
and see what people here think in terms what system best suits to that
usage.

I'm a light weight semi-professional videographer but I have enough
going on to feel a need to keep track of and be able to rollback
versions of a project as it is being worked on

It would involve on any one projects something like 15 to 60 GB of
stuff to keep up with.  Large numbers of images and a dozen or 2 dozen
video files.  All in some stake of compression depending on the codex.

I'd like to keep a few version of say an Adobe Premier project with
all the attendant files that play a role in it.

Ditto for sets of Adobe After effects and attendant files.  And many
many images and compilation in various states of cutting or whatever
editing.

And then the whole project including the various Premier and After
effects sets and piles of captured video tape.  All in DV-avi format.

So versions inside versions and then repeated for different projects.

Each of which may have more than 1 version.

But cutting to the chase... assorted video and graphics files
amounting to between 15 - 60 GB in any one project

Each project would only run a month or 2 months at the most and then
all but the final delivered version would be deleted.  That version
might be keep for a yr or so.

I have some experience with cvs over quite a few yrs but still only a
homeboy user and not very skilled or knowledgeable about cvs and even
less with mercurial or git, where I do have some tiny bit of
experience too.

Which of the main contenders:  cvs subversion mercurial git bizarre 
Maybe  a few more I don't know about, would be the best candidate for
the usage and user described
