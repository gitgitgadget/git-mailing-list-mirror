From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Handle branch names with slashes
Date: Thu, 18 May 2006 18:00:40 +0200
Message-ID: <20060518160040.GA28270@diana.vm.bytemark.co.uk>
References: <20060518064214.GA10390@backpacker.hemma.treskal.com> <20060518065040.GA10497@backpacker.hemma.treskal.com> <b0943d9e0605180511v5cf9256dx84825866b1691f51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 18:01:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgkvp-0004F9-LG
	for gcvg-git@gmane.org; Thu, 18 May 2006 18:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWERQAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 18 May 2006 12:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWERQAw
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 12:00:52 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:14096 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751355AbWERQAv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 12:00:51 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FgkvY-0007NR-00; Thu, 18 May 2006 17:00:40 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0605180511v5cf9256dx84825866b1691f51@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20289>

On 2006-05-18 13:11:52 +0100, Catalin Marinas wrote:

> On 18/05/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > +    if len(dirs) !=3D 0:
> > +        # We have branch names with / in them.
> > +        branch_chars =3D r'[^@]'
> > +        patch_id_mark =3D r'//'
> > +    else:
> > +        # No / in branch names.
> > +        branch_chars =3D r'[^@%/]'
>
> I removed % from the above regexp.

Ah, I missed one. Perhaps I should act surprised . . . :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
