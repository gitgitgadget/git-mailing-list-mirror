From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat() functions
Date: Tue, 16 Jul 2013 19:42:06 +0400
Message-ID: <CAHkcotjV6BgFP9Z9eeFSU_X2vPiKV=2_D_fnk-jA48d_OCO33Q@mail.gmail.com>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk>
	<51E2CE97.2040900@gmail.com>
	<7vppuja9ip.fsf@alter.siamese.dyndns.org>
	<51E4AABD.9010701@web.de>
	<51E4C400.6000009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 17:42:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz7OJ-0005Nh-A7
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 17:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739Ab3GPPmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 11:42:10 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:49919 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932716Ab3GPPmI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 11:42:08 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so715390lbh.24
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Mnh9SkkOoDpZ1Ui07YbamKZF+87CRnj4v5hD0nfoqJo=;
        b=YpMW+RzLSD1zGcNL/5K861odjTlXveVcwNrSHzkAoOUhYNQv1HkRd2GouDWqHkrS9b
         ceKPOY7cja9NAyvmfaIJ7boonerWiyB+4ToDo9rM+6Ih60IbEQBnstj3b+PqtLFg+AEK
         ayi0MDMdeHjPB1JxpiMyEme+IxfZkJ4cPIgEBx6PPHLbacwbuC9oB9PfhlU7ct4gsm6j
         RVL5RtZT3qb7AhKvcc6jq2ES/ZvmogFKyReiCsYOSHzrEWvZPvlw/GBmsXHeKhO9a4ws
         xk06AFq9gRKfU3vCLOCe24fjcaYfeZx2KoRmsprefQx2pCFKGkxqdsyr3doCpvSjF/pU
         CoFQ==
X-Received: by 10.152.3.74 with SMTP id a10mr970664laa.74.1373989326556; Tue,
 16 Jul 2013 08:42:06 -0700 (PDT)
Received: by 10.114.176.196 with HTTP; Tue, 16 Jul 2013 08:42:06 -0700 (PDT)
In-Reply-To: <51E4C400.6000009@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230564>

On Tue, Jul 16, 2013 at 7:54 AM, Mark Levedahl <mlevedahl@gmail.com> wrote:
>
> I see no difference in the above. (Yes, I checked multiple times that I was
> using different executables).

Are you sure that you set core.filemode to false before testing?

If you have core.filemode set to true then you _always_ use Cygwin stat,
so it does not make any difference for you.


Dmitry
