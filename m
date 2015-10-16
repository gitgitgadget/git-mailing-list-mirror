From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] stripspace: Implement --count-lines option
Date: Fri, 16 Oct 2015 10:59:52 +0200
Message-ID: <vpqwpun89yv.fsf@grenoble-inp.fr>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
	<1444911524-14504-3-git-send-email-tklauser@distanz.ch>
	<vpqzizkysyh.fsf@grenoble-inp.fr> <20151016084018.GO11304@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 16 11:00:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn0s7-0003QG-6S
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 11:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbbJPJAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 05:00:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39655 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbbJPJAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 05:00:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9G8xpp3031404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 16 Oct 2015 10:59:51 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9G8xq0i002423;
	Fri, 16 Oct 2015 10:59:52 +0200
In-Reply-To: <20151016084018.GO11304@distanz.ch> (Tobias Klauser's message of
	"Fri, 16 Oct 2015 10:40:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 16 Oct 2015 10:59:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9G8xpp3031404
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445590794.99429@UqjmeyzrJz3jkq4Ze3MQpQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279740>

Tobias Klauser <tklauser@distanz.ch> writes:

> On 2015-10-15 at 18:52:54 +0200, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Tobias Klauser <tklauser@distanz.ch> writes:
>> > +static const char * const usage_msg[] = {
>> 
>> Stick the * to usage_msg please.
>
> Just noticed while looking at how other sub-commands define this, the vast
> majority use "const char * const" and not "const char const *".

Oops, I read your code too quickly. We stick the * to variable names
when it follows the star, but I didn't see the "const", sorry.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
