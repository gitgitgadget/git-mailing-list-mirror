From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Thu, 17 Jan 2008 10:00:09 +0800
Message-ID: <46dff0320801161800y9f5bf0cvb1804a57c41c3f4c@mail.gmail.com>
References: <478D79BD.7060006@talkingspider.com>
	 <86hcheig3n.fsf@blue.stonehenge.com>
	 <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org>
	 <478E3D8E.1090300@talkingspider.com>
	 <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mike <fromlists@talkingspider.com>,
	"Neil Macneale" <mac4-git@theory.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 03:00:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFK3c-0002lM-LZ
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 03:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbYAQCAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 21:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYAQCAL
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 21:00:11 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:31132 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbYAQCAK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 21:00:10 -0500
Received: by py-out-1112.google.com with SMTP id u52so687411pyb.10
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 18:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wQgwLpdcuf80pbMHg2hYak4WWoCiHw4K4V/y7SoqpM0=;
        b=o4Eza8i/qXoF5PupFYPHjnY4tZSsEsqh5YZyd81UqLBf2ttY4d6gBm5LPd/1DfMDKXFjCLCMwlQ6NkO3YGpvSWxEgFcsOPWp1FaLaY3PQmHlUX+HfHrZSJWmR4PMNvYds4d2hiQ1wyBC9137hSaEv5VTqktAqxK+Bgfck66ba4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BJZzMr4y58oN3T3FMxDF7OFiC1EOmcdFBZ8LlG5brklVQa900V5rdvLI0weaPh9TOktTmprxwsIk6TxbhTfBP3YCG8SjJBuFjqYc9AJOgWeQ83yvvOTfUFsq8+AP7ugEYrKfEEdcEvDxnBXDBzKkIRseSMuJi98Xrpj/x5woE28=
Received: by 10.35.84.9 with SMTP id m9mr1694068pyl.6.1200535209149;
        Wed, 16 Jan 2008 18:00:09 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Wed, 16 Jan 2008 18:00:09 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70811>

On Jan 17, 2008 2:15 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
>

>
>  - Most sane people want to deploy and test separately. In particular, you
>   want to test *before* you deploy. People make mistakes, they don't want
>   to show them. Or there are consistency requirements, and/or you simply
>   want to deploy to multiple sites simultaneously. All of which really
>   re-inforces the "develop separately" mentality, where the actual
>   deployment is then a separate "now I'm ready, let's push out the
>   result".
>
Using git to manage deployment environment and even as deployment
tools is not always a bad idea.

1. In case where development and deployment environment are almost the
same, such as html files, js files, binding the two environments as
one is convenient.

2. Event In the case where the two environement are different very
much, managing deployment environment in git sometimes still seems
good, since we can easily back to any earlier version or fix some
urgent bug ASAP (surely for the non-generated files).

3. Use 'git pull' as deploy command seems simple enough.

>
>                Linus
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Ping Yin
