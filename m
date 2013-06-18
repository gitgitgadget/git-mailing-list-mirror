From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Documentation/git-push.txt: explain better cases where --force is dangerous
Date: Tue, 18 Jun 2013 09:42:17 +0200
Message-ID: <vpq38sfx3ty.fsf@anie.imag.fr>
References: <1371491561-19117-1-git-send-email-Matthieu.Moy@imag.fr>
	<51BF7B1C.2040703@xiplink.com>
	<7v7ghsbeoo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	philipoakley@iee.org, artagnon@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 09:42:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoqYm-0002iR-2e
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 09:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab3FRHm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 03:42:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55973 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566Ab3FRHmY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 03:42:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5I7gGI0028428
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 09:42:16 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UoqYT-0003Uw-KC; Tue, 18 Jun 2013 09:42:17 +0200
In-Reply-To: <7v7ghsbeoo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 17 Jun 2013 14:38:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Jun 2013 09:42:17 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228169>

Junio C Hamano <gitster@pobox.com> writes:


> After I re-read the one, I found that "override" somewhat a strange
> expression.  There is nothing that overrides or to be overriden.

Right, I actually meant "overwrite".

> How about putting it like this?

I'm not sure "push out refs other than the current branch" is strong
enough. Once you are used to "push = fast-forward = can't loose data",
"push out a ref" is not very scary.

I'd do s/push out/overwrite/, but I'm fine with your version too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
