From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Warnings before rebasing -i published history
Date: Fri, 08 Jun 2012 11:23:42 +0200
Message-ID: <vpqbokuyx5t.fsf@bauges.imag.fr>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<7vwr3ieo0i.fsf@alter.siamese.dyndns.org>
	<20120608093257.Horde.eeddeHwdC4BP0aqpIrqTaVA@webmail.minatec.grenoble-inp.fr>
	<vpqfwa618zv.fsf@bauges.imag.fr> <1339147124-ner-3533@calvin>
Mime-Version: 1.0
Content-Type: text/plain
Cc: konglu@minatec.inpg.fr, Junio C Hamano <gitster@pobox.com>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 11:23:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScvQA-00062V-J4
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 11:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762002Ab2FHJXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 05:23:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44240 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760567Ab2FHJXt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 05:23:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q589Exv9000792
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 11:14:59 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ScvPz-0008Fc-5o; Fri, 08 Jun 2012 11:23:43 +0200
In-Reply-To: <1339147124-ner-3533@calvin> (Tomas Carnecky's message of "Fri,
	08 Jun 2012 09:18:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 08 Jun 2012 11:14:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q589Exv9000792
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339751701.91892@Vzl5Ecwuq9lqFH8Bwz/Frw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199477>

Tomas Carnecky <tomas.carnecky@gmail.com> writes:

> On Fri, 08 Jun 2012 10:52:04 +0200, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Isn't a more conventional way to do that
>> 
>> sed -e '...' "$1" >"$1".new
>> mv "$1".new "$1"
>> 
>> ?
>
> Is sed -i not portable ...

It's a GNU extension, yes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
