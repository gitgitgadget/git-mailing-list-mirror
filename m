From: "Elijah Newren" <newren@gmail.com>
Subject: EasyGit [Was: Re: my git problem]
Date: Fri, 2 May 2008 05:41:45 -0600
Message-ID: <51419b2c0805020441l7a52f9d2q6bfc8eb4e18e4e7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, git@vger.kernel.org,
	"Havoc Pennington" <hp@pobox.com>
To: "Carl Worth" <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri May 02 13:42:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrtev-0001Rz-Ro
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 13:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762420AbYEBLlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 07:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762501AbYEBLlt
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 07:41:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:41085 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760581AbYEBLls (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 07:41:48 -0400
Received: by wr-out-0506.google.com with SMTP id c48so907115wra.1
        for <git@vger.kernel.org>; Fri, 02 May 2008 04:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=gzI+K+U4Ovrqg0FTvuML98qUgDs9WRLpObZILEoGWN0=;
        b=tBc07RvON0fL0dL1/muu2nR0OisWDE8/hraC/VyiJNfac09iPYyoUvctdRrrpA+3Le6QHgN8VRvWPYC2q+D1Ima4tBE3FhKbms5+IKPVv4OGk9YfiaoMo69FPKNhw0Kr0U7k9xH6RLg34IQjxPh+CdqC7gJKrpyWw7zJw4m5zL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VUfDj9PaR+xmji26Zct+pSrANC+RttHiXxc4iFPZE9s3MSI+dXNMPrw6+faPpVJQYHI7sV8hVL7mIR9mWeXQajRIw1Xj4S97slZLHla1/wuEAPC6Fv/G3BgRgubv4NZs9peQXNb8erPO/qnMparKJeS1TP+Qg8VUKtURc053Wsg=
Received: by 10.114.200.2 with SMTP id x2mr2912287waf.143.1209728505356;
        Fri, 02 May 2008 04:41:45 -0700 (PDT)
Received: by 10.114.73.10 with HTTP; Fri, 2 May 2008 04:41:45 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80979>

On Thu, May 1, 2008 at 12:01 AM, Carl Worth <cworth@cworth.org> wrote:
>  Or maybe go Elijah's route and invent a new top-level command name in
>  which issues like this can get fixed. (I've been lukewarm on the idea
>  after watching the cogito attempt eventually be abandoned. I'd really
>  much rather see Elijah's ideas get pushed down into git itself for the
>  most part. But it's tough when backwards-compatibility prevents fixing
>  some things that are obviously confusing people.)

Except my route really doesn't fix things like this since I also
pushed for backwards compatibility.  You'll note that Havoc used
EasyGit and Git interchangably (both in his description and probably
on his projects), since all I've really done so far in EasyGit is
* provide built-in tutorial-oriented documentation
* check for common user mistakes and warn about them
* add subcommand options in a way that breaks up the near cylic
knowledge dependence of git subcommands so that they can be learned in
a layered/hierarchical fashion
* add some gratuitous svn-compatibility commands to ease the
transition for svn users

I agree that it would be nice to get this stuff (other than the last
point that likely doesn't make sense for git-core) into git
itself...if the community wants it.  Starting as a separate project
simply allowed me to make mistakes and figure out what works; I've
seen lots of proposals in the past for fixing up git and lots of them
end up breaking special use cases -- I've had a number of those myself
in EasyGit (and may still have some) and had to go back and fix them
up or find other solutions.

Also, as Havoc pointed out pretty clearly, what I've done in eg is
helpful for people getting started but there's a lot more
learnability/usability issues that need to be addressed.  I thought it
made more sense to address those first, so that's my next step.

Elijah
