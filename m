From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] cvsserver: Make always-binary mode a config file option
Date: Thu, 1 Mar 2007 12:44:12 +0100
Message-ID: <20070301114412.GA13535@diana.vm.bytemark.co.uk>
References: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net> <200703010840.54377.andyparkins@gmail.com> <46a038f90703010113o256f19a2qb1c16f4c85e5bd1c@mail.gmail.com> <200703010941.20161.andyparkins@gmail.com> <7vk5y1uwhg.fsf@assigned-by-dhcp.cox.net> <7vr6s9th4f.fsf@assigned-by-dhcp.cox.net> <7vhct5rztc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Martin Langhoff <martin.langhoff@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 12:44:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMjhw-0000eS-NX
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 12:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbXCALoY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 1 Mar 2007 06:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbXCALoX
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 06:44:23 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1439 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbXCALoX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 06:44:23 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HMjhk-0004Ez-00; Thu, 01 Mar 2007 11:44:12 +0000
Content-Disposition: inline
In-Reply-To: <7vhct5rztc.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41087>

On 2007-03-01 03:03:11 -0800, Junio C Hamano wrote:

>       ; takes temporary files old, mine, his and writes the
>         ; result in another
>       merge =3D "cmd external-merge-command %s %s %s %s"

Better make this "%1 %2 %3 %4", "%old %mine %his %result", or
something along those lines, so as to not force a particular argument
order on the external script.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
