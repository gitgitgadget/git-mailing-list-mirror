From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Do not decode url protocol.
Date: Tue, 22 Jun 2010 13:22:32 +0200
Message-ID: <vpqmxunb9c7.fsf@bauges.imag.fr>
References: <AANLkTinK99krA-16qUO8nWYbZ7w6o632jLTTW5WyaKOk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Tue Jun 22 13:22:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR1Yu-00026h-JJ
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 13:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab0FVLWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 07:22:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55151 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800Ab0FVLWf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 07:22:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5MBEBkL024165
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 22 Jun 2010 13:14:11 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OR1Ym-0004Bf-Ie; Tue, 22 Jun 2010 13:22:32 +0200
In-Reply-To: <AANLkTinK99krA-16qUO8nWYbZ7w6o632jLTTW5WyaKOk@mail.gmail.com> (Pascal Obry's message of "Tue\, 22 Jun 2010 11\:25\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 22 Jun 2010 13:14:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5MBEBkL024165
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277810051.54264@frstmlxf7OXr8PP8tHhIpw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149476>

Pascal Obry <pascal@obry.net> writes:

> Same patch with fixed formatting. Sorry.

This part is for the commit message, and will appear in "git log" if
Junio applies it as-is ...

> This fixes a regression introduced in 9d2e942.
> ---

... while this place (after ---, before diffstat) is meant for
comments addressed to the list, and ignored while applying the patch.

(also, [PATCH v2] in the subject would have made it clear that this is
the second version)

Otherwise, the patch sounds good.

>  url.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
