From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Reintroduce svn pools to solve the memory leak.
Date: Tue, 28 Mar 2006 14:20:31 +0200
Message-ID: <20060328122031.GA14124@diana.vm.bytemark.co.uk>
References: <8aa486160603270326i3a8ddcfau61ca84cdac036ff9@mail.gmail.com> <7vhd5joiqt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 14:21:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FODBz-00073U-TU
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 14:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWC1MUq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 28 Mar 2006 07:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWC1MUq
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 07:20:46 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:48911 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932201AbWC1MUq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 07:20:46 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FODBX-0003iL-00; Tue, 28 Mar 2006 13:20:31 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd5joiqt.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18119>

On 2006-03-27 10:16:58 -0800, Junio C Hamano wrote:

> Karl, were there other reasons you needed to disable the pool here
> (maybe to work around a problem with incompatible version of SVN
> module)? I see some other uses of SVN::Pool still there in the code,
> so I am assuming this was a simple typo, but just in case...

No, it's just a simple mistake (the mistake being me not realizing why
an explicit pool was needed, and simply dropping it when things worked
fine without it).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
