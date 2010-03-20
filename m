From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Sat, 20 Mar 2010 17:58:20 -0400
Message-ID: <4BA544FC.7050007@gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com> <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bo Yang <struggleyb.nku@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 22:58:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt6gj-0005Oj-Qe
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 22:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab0CTV63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 17:58:29 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44509 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0CTV62 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 17:58:28 -0400
Received: by gwaa18 with SMTP id a18so361825gwa.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=P6qCtZttS9f35Hzw6BZJ20lmlUyWiFbKwSqFwg+h0OY=;
        b=lQu3YZsy9dwkOzp/XFmfiiw40SQFSNRIR44gEZGPVeA/2bY4ix38BJusq6f7Ragh3Y
         PH/TL3Zb020hKWyzFlXrLRITGB7hStv19hruw8cT/mHF3oDf64OkTKVjCrRhxL3Pv28e
         RndaBHY5R0Ok4aYID2tkZTtOBkPR2KuSN3lsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=U71XG26/GVlGytyhDNGvSq6w8ian817eCbwmmFrzvSvKGQMgdaFsKHTpy0zF3fNuU0
         LtSkfjncNYinCocMSNy7jYsPdzcy8cawR4sNI36WkccB17OllzWnI6rCggHpr8+V43nf
         ok4yFMUDz83zpZC86hsizgc336Cu514dJm4ww=
Received: by 10.101.191.4 with SMTP id t4mr11722246anp.232.1269122307618;
        Sat, 20 Mar 2010 14:58:27 -0700 (PDT)
Received: from [10.0.0.6] (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 5sm1086370ywd.59.2010.03.20.14.58.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 14:58:26 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142759>

Alex Riesen wrote:
> On Sat, Mar 20, 2010 at 10:18, Bo Yang <struggleyb.nku@gmail.com> wrote:
>> <line range>
>> Its format should be <start pos>..<end pos> or just a <line number>.
> 
> You might want to reconsider the line range syntax. Exactly the same syntax
> is already used to specify a commit range, so reusing it may lead to confusion.

I, actually, think the proposed line range syntax works because it uses 
the same _range_ notation. The issue is how to differentiate the _line_ 
range(s) from the _commit_ range(s); and, yes, I would like multiple 
ranges of each type as well as multiple files.
