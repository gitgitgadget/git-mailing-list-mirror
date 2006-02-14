From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Tue, 14 Feb 2006 11:08:44 +0100
Message-ID: <20060214100844.GA1234@diana.vm.bytemark.co.uk>
References: <20060210195914.GA1350@spearce.org> <20060210211740.GO31278@pasky.or.cz> <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 11:08:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8x78-0002dl-KM
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 11:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWBNKIv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Feb 2006 05:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWBNKIv
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 05:08:51 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:57355 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1030233AbWBNKIu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 05:08:50 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1F8x6z-0000ir-00; Tue, 14 Feb 2006 10:08:45 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <tnxoe1aqoj2.fsf@arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16133>

On 2006-02-14 09:26:41 +0000, Catalin Marinas wrote:

> Another thing that's missing in StGIT is the import of a series of
> patches. At the moment I run a small shell script to import
> individual patches.

One thing I would like to see in stgit is the opposite of "stg
commit"; instead of converting patches to regular commits, take the
topmost regular commits and convert them to patches.

=46or example, "stg uncommit foo bar baz" would -- regardless of any
existing patches, applied or not -- convert the top three regular
commits, with comments and all, to stgit patches called foo, bar, and
baz. These would be already applied, at the bottom of the stack. I
imagine all one would have to do is to modify some stgit metadata, so
the operation could be really cheap.

Of course, "stg uncommit" is allowed to reject any commit with more
than one parent, since those can't be represented as stgit patches.

This would perhaps not add much power to an all-stgit workflow, but it
would be a really convenient way to edit recent git history. Sort of
like a more convenient rebase. And a great way to lure new users. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
