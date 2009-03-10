From: Carlos Rica <jasampler@gmail.com>
Subject: Re: [PATCH] builtin-tag.c: remove global variable to use the callback 
	data of git-config.
Date: Tue, 10 Mar 2009 15:00:55 +0100
Message-ID: <1b46aba20903100700ob46a797lcf600e0ae868a35f@mail.gmail.com>
References: <1236690219.20402.28.camel@luis-desktop>
	 <alpine.DEB.1.00.0903101432010.14295@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 10 15:03:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh2XN-0002L8-Im
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 15:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbZCJOBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 10:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753863AbZCJOA7
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 10:00:59 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:62039 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248AbZCJOA7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 10:00:59 -0400
Received: by fxm24 with SMTP id 24so1628618fxm.37
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 07:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HxRXPhJ3q2RRuB3KGUHww1gR+fq/PZXUQ+bHq/B7qZc=;
        b=sdDPFln4Q6gWprEZ+kFG8KooiQ+foaE6wPBsocpaUjPQwznKj7/FDFuPfocK866Zm/
         2hxjoF5aplvie0SCcvLX/szd7YNJiMhGiFPBlwULCP9ksJsqzspascjWlGVleKnfP1RT
         +k5O2sH07FBUTjXMVjMMMl5hFOQWa/glWNqHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sae0uEVYZcj3vta92pDHomzQiYvRqezQWEK5kNsVC3m5nLabTJ8HQblDvmgvFJvCvB
         amgA58z7Ou4hnoSmla9gtqsusbhQ9VEDpbHNni9jpdj0byGuU7pzNTPpqvdL+HkGl/dR
         /T0T+fnhgvAeNsUsWP2pHyr6y+uGzZwAGwUQo=
Received: by 10.223.117.1 with SMTP id o1mr5411266faq.53.1236693656026; Tue, 
	10 Mar 2009 07:00:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903101432010.14295@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112815>

Please, don't even try to apply this patch, since long lines are wrappe=
d.

I will send it fixed, sorry by the inconvenience.

On Tue, Mar 10, 2009 at 2:34 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 10 Mar 2009, Carlos Rica wrote:
>
>>
>> Signed-off-by: Carlos Rica <jasampler@yahoo.es>
>
> Good to see you again!

Thanks!
>
> BTW do you want to be recorded with a different email address in the
> author line than in the S-O-B?

Thank you for notify it, Johannes! That's was another mistake here,
I wanted to use the gmail account for this, I will change it when I
send this fixed.

>> -static int do_sign(struct strbuf *buffer)
>> +struct char_array {
>> + =A0 =A0 char *buf;
>> + =A0 =A0 size_t size;
>> +};
>
> That looks very much like you want a struct strbuf, no?

I was asking exactly that, in the hidden lines of the patch,
so if everybody prefers the strbuf solution I will use it, and then,
we should choose if there must be a limit for the signing key id max le=
ngth
(now 1000) since by using dynamic memory it would not be required.

> Ciao,
> Dscho
>
>
