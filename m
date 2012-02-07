From: Jonathan Paugh <jpaugh@gmx.us>
Subject: Re: Specifying revisions in the future
Date: Tue, 07 Feb 2012 16:25:32 -0500
Message-ID: <4F3196CC.9020406@gmx.us>
References: <jgjkk0$qrg$1@dough.gmane.org> <m3ehu9kknw.fsf@localhost.localdomain> <m2wr81vsdv.fsf@igel.home> <201202052324.59941.jnareb@gmail.com> <178AA8FDB02246D9AA9416C0D54E51A8@PhilipOakley> <m2obtcx4i2.fsf@igel.home> <buosjiozity.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Philip Oakley <philipoakley@iee.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 07 22:26:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RusY8-0005kr-8Q
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 22:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902Ab2BGVZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 16:25:46 -0500
Received: from mailout-us.gmx.com ([74.208.5.67]:55996 "HELO
	mailout-us.mail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1756533Ab2BGVZp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 16:25:45 -0500
Received: (qmail invoked by alias); 07 Feb 2012 21:25:42 -0000
Received: from 74-46-161-231.dr02.blfd.wv.frontiernet.net (EHLO [192.168.1.33]) [74.46.161.231]
  by mail.gmx.com (mp-us007) with SMTP; 07 Feb 2012 16:25:42 -0500
X-Authenticated: #49663077
X-Provags-ID: V01U2FsdGVkX19Wbm05LfVWthXDpNdo044vW7juqIuxVpTFocALjo
	PY1QjtbMNb30pJ
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111229 Thunderbird/9.0
In-Reply-To: <buosjiozity.fsf@dhlpc061.dev.necel.com>
X-Enigmail-Version: 1.3.5
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190212>

On 02/05/2012 11:28 PM, Miles Bader wrote:
> Andreas Schwab <schwab@linux-m68k.org> writes:
>> The rule should be to follow the leftmost parent as far as possible.
>> That means that X+2->D is B.
> 
> It might also be reasonable (and safer -- the user may not actually
> realize when there's an ambiguating branch-point) to simply have it
> abort with an error ("ambiguous future-ref specification") when
> there's any doubt...  I suspect most uses would be very simple "+1"
> etc., and not crossing branch points.
> 
> -miles
> 

Perhaps default to --linear or --no-cross or such. Whenever there's
ambiguity, it will likely be harder for the user to think about than for
git to resolve it in some defined-as-sane way, at least for many users.

At any rate, I got the answer I needed for my use case (sorry for not
cc-ing the list, and thanks Jakub for that:
http://article.gmane.org/gmane.comp.version-control.git/189926/match=specify+revisions+future).

Still, forward-refs would still be really cool.

Jonathan
