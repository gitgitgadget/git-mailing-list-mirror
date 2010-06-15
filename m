From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [GSoC update] Splitting gitweb & developing write functionalities
Date: Wed, 16 Jun 2010 02:43:57 +0530
Message-ID: <AANLkTimJqFzuWI7EMnUuH9ap69KgL_op_yndWSfyg8hX@mail.gmail.com>
References: <AANLkTikapZa0N7xroxhdlmm7LUvlNp-7GZy7XeG-zprC@mail.gmail.com>
	<20100615201720.GI3109@machine.or.cz>
	<AANLkTinfJOOT8NJ942bB_Sil4sGNthpk9hxvA60Y_iGB@mail.gmail.com>
	<20100615205755.GJ3109@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jun 15 23:14:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOdST-0006lc-AE
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 23:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490Ab0FOVOB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 17:14:01 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59108 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932467Ab0FOVOA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 17:14:00 -0400
Received: by gye5 with SMTP id 5so3583587gye.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=p7aL2AFr8XPAXXbPyJGBszniKm7JCvNVwkTvWIDaQ/4=;
        b=KSYSyRRg+Csux3ZaVXuvtDWR80yjrInJ0OskZCgw4+o9Yn/x7wOvwAIG5wgT41/LTI
         j5c4VateLQ7h3sOGsbQhvv/k/XWGk95JUJK9lFaDRr8D1JDktl6ahV2LhJQBQ6PLJmRd
         cT07BaDzQOgcua/EcKrSGtVbgc6cZyj6/O7nU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kFI+bekAhG2IwokrmWmnwaEnFGtBFfyQl7JYBLFzQq//PSSNG68S4+wFdERk2rmXrO
         v7iR0uq3HBF5cdY6h8xqIhBrCGSjiJ6tDd7Ykxc1n33ieaNFE74LSqNI7z6hyhfy7YaN
         tqKNstqEn3cdUyM/vmwg0IF1SBEJjQHCPy/sY=
Received: by 10.101.4.11 with SMTP id g11mr6612017ani.150.1276636438163; Tue, 
	15 Jun 2010 14:13:58 -0700 (PDT)
Received: by 10.100.126.20 with HTTP; Tue, 15 Jun 2010 14:13:57 -0700 (PDT)
In-Reply-To: <20100615205755.GJ3109@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149226>

On Wed, Jun 16, 2010 at 2:27 AM, Petr Baudis <pasky@suse.cz> wrote:
> =A0Hi!
>
> On Wed, Jun 16, 2010 at 02:03:50AM +0530, Pavan Kumar Sunkara wrote:
>> >> gitweb: Create Gitweb::View module [Work in Progress]
>> >
>> > (Is this the Gitweb::HTML module? Why have you renamed it?)
>> Yeah I thought it would be better if I have this named as View rathe=
r
>> than HTML :)
>
> =A0I'm just a bit surprised since I have thought we have agreed that
> Gitweb::View is much more misleading name for what Gitweb::HTML actua=
lly
> is, hinting at a MVC structure that simply is not there at any level.
> You are welcome to differ in opinion but then I would expect you to
> continue that discussion. :-)
>

Yes but after a long thought, I decided that the name to be changed to
View because this module contains all the subroutines regarding the
gitweb viewing functions.

Thanks,
Pavan.
