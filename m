From: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC] send-email: allow multiple emails using --cc --to and --bcc
Date: Fri, 29 May 2015 18:07:26 +0200
Message-ID: <87h9qv2wqp.fsf@ensimag.grenoble-inp.fr>
References: <1432809733-4321-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1432809733-4321-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<CAPig+cRb0GstQThkprzBA=VwHSFxUeX6KDdSA7Xjdb_B2mH6Uw@mail.gmail.com>
	<CAPig+cR_N10=k6QX=udpfWG-qNYkBNXQQNZ-LOrGC=1UqoZcVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 29 18:07:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyMou-0002iJ-Af
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 18:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbbE2QHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 12:07:33 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:50138 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756200AbbE2QHa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2015 12:07:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 5FB4248864;
	Fri, 29 May 2015 18:07:28 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RWRryIBIYIfv; Fri, 29 May 2015 18:07:28 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 46B324885B;
	Fri, 29 May 2015 18:07:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 38B3020DD;
	Fri, 29 May 2015 18:07:28 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gCzweUCDAKu5; Fri, 29 May 2015 18:07:28 +0200 (CEST)
Received: from Groseille (cor91-7-83-156-199-91.fbx.proxad.net [83.156.199.91])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 8075420D7;
	Fri, 29 May 2015 18:07:27 +0200 (CEST)
In-Reply-To: <CAPig+cR_N10=k6QX=udpfWG-qNYkBNXQQNZ-LOrGC=1UqoZcVw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 28 May 2015 14:02:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270252>

Eric Sunshine <sunshine@sunshineco.com> writes:

> <remi.lespinet@ensimag.grenoble-inp.fr> wrote:
> 
>     validate_address_list(sanitize_address_list(
>         split_address_list(@xx))
> 
> That's pretty verbose, so introducing a new function to encapsulates
> that behavior might be reasonable.

Agreed, If you have any suggestion for the name of this function, I'll
be happy to use it, I named it extract_address_list, but I'm not sure
that it's a good name.

Thanks again for the review!
