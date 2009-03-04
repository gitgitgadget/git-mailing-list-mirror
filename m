From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Strange push/clone errors
Date: Wed, 4 Mar 2009 12:37:40 -0500
Message-ID: <c115fd3c0903040937l3139ef2ey854cb8c93131384b@mail.gmail.com>
References: <c115fd3c0903040601xbfce200q78c53aeee0b44f2c@mail.gmail.com>
	 <20090304143938.GB12901@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 18:39:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lev3r-0004K6-7q
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 18:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbZCDRho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 12:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbZCDRhn
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 12:37:43 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:27440 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190AbZCDRhm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 12:37:42 -0500
Received: by yw-out-2324.google.com with SMTP id 5so2228915ywh.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 09:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a4FBF3NbDB6GbVxDI6joXLTajz1CmHugDz7JibT6DEg=;
        b=NYC0BcEidnkwlQrRGcTm3PGbLYYJMiNERs7zv6gAzT10Ap+I5ud787VeNU5im9R6vc
         UVqj6Qcmc7GZrhidyWb2eE5bbRn2v8GlJQbRwd37LiFQEfPcf5WWOO6578jNOZPf2Ya+
         cDAJbtMCk79FyfTmSrgTi1mxP5yJLZHG2TvHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T173zkcNE5hBOyz0+JE66zK3LMAAsgzA0roP5ITAwipJGmwl/FgBozFLPrQpOfk5Gt
         lxZfgnNqly4S+j7dT5iRI0uox6z1vYswoQI3gvkxVxh33bsp+PrkMsnSOY0mL5OxHl9x
         o+FaEmUMXhYqNfhR2qUjt4VPxW8EZ/WUl6M/I=
Received: by 10.100.6.16 with SMTP id 16mr111795anf.113.1236188260140; Wed, 04 
	Mar 2009 09:37:40 -0800 (PST)
In-Reply-To: <20090304143938.GB12901@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112227>

On Wed, Mar 4, 2009 at 9:39 AM, Nicolas Sebrecht
<nicolas.s-dev@laposte.net> wrote:
>
> On Wed, Mar 04, 2009 at 09:01:51AM -0500, Tim Visher wrote:
>
>> As you can see, v1.6.2 and v1.6.2-rc2 are missing from the repo that
>> I'm pushing to on my thumb drive, despite it claiming it's up to date.
>>
>> What am I doing wrong?
>
> You need to push the tags using the --tags option of git-push (when
> pushing to your sandbox repository).

Thank you, Nicolas!  I actually discovered the `--mirror` option.
Since that's basically what I'm trying to do, that's what I ended up
going with.  It appears to be working.


-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
