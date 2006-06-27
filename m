From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Rework a patch serie
Date: Tue, 27 Jun 2006 12:16:44 +0200
Message-ID: <20060627101644.GA397@diana.vm.bytemark.co.uk>
References: <20060627084130.28886.qmail@web25814.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 12:17:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvAcv-0004j7-30
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 12:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbWF0KQ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Jun 2006 06:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932775AbWF0KQ6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 06:16:58 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:60425 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932739AbWF0KQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 06:16:57 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FvAce-00008t-00; Tue, 27 Jun 2006 11:16:44 +0100
To: moreau francis <francis_moreau2000@yahoo.fr>
Content-Disposition: inline
In-Reply-To: <20060627084130.28886.qmail@web25814.mail.ukl.yahoo.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22722>

On 2006-06-27 08:41:30 +0000, moreau francis wrote:

> Then I submit these patches for reviewing. Unfortunately, they're
> not perfect, so after some feedbacks from the communauty it appears
> that I need to make small modifications in the second commit in the
> topic branch for example...
>
> What is the best and fastest way to do that ? Should I create a new
> topic branch and cherry pick from the old one ?

stgit is a good fit for this situation. You just pop patches off the
stack untill you reach the one you want to modify, then do your
changes, refresh the patch, and push the other patches back. (If you
want to keep the original series for future reference, you can simply
tag HEAD before you embark on this procedure.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
