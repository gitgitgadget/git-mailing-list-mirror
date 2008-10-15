From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: builtin conversion between tabs and spaces
Date: Wed, 15 Oct 2008 19:34:33 -0400
Message-ID: <48F67E09.90202@gmail.com>
References: <d4bc1a2a0810141839r547a770j3a8e56312afa6a53@mail.gmail.com>	 <d4bc1a2a0810141842q1e50c85au7d813f2e5e37a84c@mail.gmail.com>	 <d4bc1a2a0810141844x76223e76xf04e07ece834fc61@mail.gmail.com>	 <20081015062539.GB3775@blimp.localdomain>	 <d4bc1a2a0810151352s6c963e32jc4f492a7c84841dc@mail.gmail.com>	 <57518fd10810151402p4ea3283anf4b3d175c4e82425@mail.gmail.com>	 <d4bc1a2a0810151418r3bf21ddaj498017e8e178f579@mail.gmail.com> <d4bc1a2a0810151602j56550c3di2f59f92039fa8243@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Stefan Karpinski <stefan.karpinski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 01:35:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqFuC-0002gO-Mv
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 01:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbYJOXei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 19:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbYJOXei
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 19:34:38 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:60310 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbYJOXeh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 19:34:37 -0400
Received: by gxk9 with SMTP id 9so7624285gxk.13
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 16:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=NvDyKeSzVShkamilRXIC7T+xiwSjfj2BhOzVq5T3A+Y=;
        b=f5iFFgbS2gbkHdH2ykhBJ51iU2EpPi/Ba6uefVS2H46ka+1MG23mPW/KRkzh0icZWF
         xWyEI04Soq+sDVykDTwMbuTl29FEfTo0iLaTw7+PRjJmzNTfJ26TXgv+M5AiCw4ymyeW
         LsdmF7GbcirX23hw2ADOFs61JOmIDR7f9jII0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=RqpQU5dITZFaFQc84FZMm2l/bRCAdhDmrWofX80rfEJsLZorTqzmzijsnWuCG6/LVE
         DnCRFWJu3xMZ2aT3nmn2bN3owuqc/KdVrfXfteYSbENVlGwd750zkQiCiEHxey1wtdnG
         EySSmC3Kcty/vrwdXW2HPSjpB0/kj2WloLgDY=
Received: by 10.90.99.3 with SMTP id w3mr1953389agb.89.1224113676371;
        Wed, 15 Oct 2008 16:34:36 -0700 (PDT)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id c44sm577936hsc.12.2008.10.15.16.34.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Oct 2008 16:34:35 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <d4bc1a2a0810151602j56550c3di2f59f92039fa8243@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98340>

Stefan Karpinski wrote:
> Any further comments? I'm more than willing to implement this, but I
> won't bother if there's no chance of getting it accepted as a patch.
> Does no one else feel like at least having the option to enforce
> whitespace consistency in git is a good thing? If not, I guess I'll
> just muddle along without this feature instead of implementing it.

I'm against including this in except as a sample smudge/clean script. 
Git is a content tracker; not the enforcement mechanism for individual 
project policies.
