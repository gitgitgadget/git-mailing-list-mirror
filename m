From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/6] Improve remote helper documentation
Date: Wed, 12 Dec 2012 16:22:41 -0600
Message-ID: <CAMP44s3CgLip2fBi=k6iAdv+zXVFuf6fonxcyiYzMB4NMHf_gw@mail.gmail.com>
References: <1354038279-76475-1-git-send-email-max@quendi.de>
	<7v1uf1he6m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 23:23:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiuhf-0005At-40
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 23:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576Ab2LLWWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 17:22:42 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58240 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452Ab2LLWWm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 17:22:42 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1374132oag.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 14:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=89e9j3hYKcbCFhGCNK9rpQtlY3CTPH5mahOzLuEYWd0=;
        b=K6cbxGnA+km8rLw2/gjBPje6cjCUlXS+hiRG+dKwaBAf7qorD7QNmZURyaxd6x0MIQ
         T5YLseGks+53wlFw9Rrzi8EFpqONwvR4FiZ+OciTPYqluHkpz475BIHglGGezGUH2kyU
         /EWU0Ik1mJ9IVSqUJjV3FS7xlu7zv4DLIJMpYTzhmsnr6FrDStxFWZEnrC9WYfd9Z3tW
         +A3Ed9/n6jyEedBo1sBF4CEh5rHoIM6t69PlcUoqfBuo8K4SMQlq/xmhJ5u9iYF9foc+
         sajk4TQTLZ9uxK/a5S5H+Xb6F+nOiZQROMLXwhzNnVpUuCaOseNPeHVcfq9cHendWI/i
         HXAQ==
Received: by 10.60.172.229 with SMTP id bf5mr1332627oec.81.1355350961528; Wed,
 12 Dec 2012 14:22:41 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Wed, 12 Dec 2012 14:22:41 -0800 (PST)
In-Reply-To: <7v1uf1he6m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211399>

On Fri, Dec 7, 2012 at 1:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Max Horn <max@quendi.de> writes:
>
>> Various remote helper capabilities and commands were not
>> documented, in particular 'export', or documented in a misleading
>> way (e.g. 'for-push' was listed as a ref attribute understood by
>> git, which is not the case). This patch series changes that, and
>> also address some other things in the remote helper documentation
>> that I found jarring when reading through it.
>>
>> Note that the description of export and (im|ex)port-marks probably can be
>> improved, and I hope that somebody who knows more about them
>> than me and/or is better at writing documentation will do just that.
>> But I felt it was better to provide something than to do nothing
>> and only complain, as I did previously on this subject ;-).
>
> A second ping to people who have touched transport-helper.c,
> remote-testsvn.c, git-remote-testgit, and contrib/remote-helpers/ in
> the past 18 months for comments.  I've re-read the documentation
> updates myself and didn't find anything majorly objectionable.
>
> Except for a minor nit in 6/6; I think "defined options" should be
> "defined attributes".

I think the wording in 1/6 can be improved. Other than that I don't
have any comments, what I'm familiar with looks good to me.

-- 
Felipe Contreras
