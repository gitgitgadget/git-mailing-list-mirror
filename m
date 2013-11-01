From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Fri, 1 Nov 2013 14:07:56 +0530
Message-ID: <CALkWK0nEMpVUkzafjDkVV-uaLTYzHYUTsZkmwRPkLFa=8NEkPA@mail.gmail.com>
References: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
 <1383212774-5232-2-git-send-email-artagnon@gmail.com> <xmqq38nh411p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 09:38:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcAFg-0005WK-Tv
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 09:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab3KAIii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 04:38:38 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:49753 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab3KAIig (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 04:38:36 -0400
Received: by mail-ie0-f178.google.com with SMTP id x13so7095784ief.9
        for <git@vger.kernel.org>; Fri, 01 Nov 2013 01:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=D1Jxpg9vkYW4d2dY1oV8EDOUpuOvBq/M2HS5MI56ahY=;
        b=cpkUlADv1yY5kJ/PRcd7aO82BxIS7MKECfVEr+1BOM78hxB1KjDiOubHOx5ZfJ75FQ
         0Y+pu9ztO0Ig0x7WWghBC0v8iA8qSevHN2K0s1tutVg8GtNRy4XQOB1s/HpOc6xGVGDJ
         1HnLsHkJUYwQUGagJUd7t8Vs1f+6pJLhLo+zoGL80ftYhWthw2CFjfbEmMqcRTBvdOJa
         sFh8xKtSPrlEVZT1amBIFTZRgTX7hcWxYL3kmaXSMRxuYZYkMDRT7LWRA265k6gvG4wd
         wr/cWC8l2HJVAgow4m5WsLaU0Bwg/AlnW8GuC53uz5JPHd1cQYl+CNiBXi1lr6mc1Gdf
         8OCw==
X-Received: by 10.43.180.200 with SMTP id pf8mr255010icc.50.1383295116334;
 Fri, 01 Nov 2013 01:38:36 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Fri, 1 Nov 2013 01:37:56 -0700 (PDT)
In-Reply-To: <xmqq38nh411p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237203>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Enhance 'git for-each-ref' with color formatting options.  You can now
>> use the following format in for-each-ref:
>>
>>   %C(green)%(refname:short)%C(reset)
>
> So far, every magic for-each-ref takes were of form %(...); was
> there a reason why this had to be %C(...), not %(color=blah), or
> something more in-line with the existing other magic?

It is in-line with the color specification in pretty-formats. Would
you strongly prefer something else?
