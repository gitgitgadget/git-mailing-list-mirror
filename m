From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Moving a file back to an earlier revision.
Date: Mon, 3 Apr 2006 10:29:08 +0200
Message-ID: <20060403082908.GA4541@diana.vm.bytemark.co.uk>
References: <4dd15d180603311313t7781f2ebk616276e9134f6472@mail.gmail.com> <4dd15d180603311332p60fa1867nc303bd92d515b4e0@mail.gmail.com> <7vacb6thc7.fsf@assigned-by-dhcp.cox.net> <4dd15d180603311421w7b48cfa4y80d3f9d565d4276f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 10:29:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQKRC-0000wQ-A1
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 10:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWDCI3W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Apr 2006 04:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWDCI3V
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 04:29:21 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:56594 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751515AbWDCI3T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 04:29:19 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FQKQu-0001KM-00; Mon, 03 Apr 2006 09:29:08 +0100
To: David Ho <davidkwho@gmail.com>
Content-Disposition: inline
In-Reply-To: <4dd15d180603311421w7b48cfa4y80d3f9d565d4276f@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18321>

On 2006-03-31 17:21:48 -0500, David Ho wrote:
[quoting junkio]

> > Remember, a branch in git is very cheap, and is a powerful way to
> > keep track of things while you decide which alternate universe to
> > take. And even after you decide, you could always look at and even
> > build on the other universe.
>
> I feel embarrassed to say this but in my branch there are commits to
> the driver and other commits for the board so it looks more like
>
> ---0---D1---B1---B2---D2---B3---B4---
>
> D* - driver changes
> B* - board changes
>
> So to go back to the 0 state I lose my board changes. But I hope
> what I did (in my reply to Linus) is very close to your idea of
> having separate branches.

You could use either stgit or the cherry-picking stuff in git to
create a new branch with these commits, but reordered any way you
like. (Or, given what you want to use it for, maybe two separate topic
branches -- one for board changes and one for driver changes -- that
can be merged to produce the end result.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
