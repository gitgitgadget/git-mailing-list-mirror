From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Thu, 17 Apr 2014 17:26:00 -0700
Message-ID: <03D68D70-7E30-428C-A13A-79BF477F0CBF@gmail.com>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c> <0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c> <xmqqob03le3v.fsf@gitster.dls.corp.google.com> <FAD02895-24B2-46C3-ABEF-E9CE17926FF9@gmail.com> <xmqqsipdi5lw.fsf@gitster.dls.corp.google.com> <xmqqtx9tgn5l.fsf@gitster.dls.corp.google.com> <F88F585D-B146-4CD2-A7E9-D3CB2C5B25A4@gmail.com> <xmqq4n1rg9nc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 02:26:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WawdN-00059J-IR
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 02:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbaDRA0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 20:26:07 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:47641 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbaDRA0E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 20:26:04 -0400
Received: by mail-pd0-f176.google.com with SMTP id r10so893274pdi.21
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=dOmYE2Ke9SmBGtebrKVSMDAJHJac58UZlCVp3P2bsKM=;
        b=rwvtqY6CCQGmXlLrNZqPRh2H42krYlLVhZ6u7zGtru2ULWRdMLlYmEMbtAvy4A8fU+
         +ZyjzPMZbu8YRLAbgvjpcKb0DrgqmpLp0l1FhQJf7xCnsMjmFT7uOIs/dQW8iQwGdZq0
         mzAoWzxzfHZcdnyfKwUpSm0kmbt1ll5po72CnKqHtmdmzj7vnaUMAYZTWsg8oW/876aj
         98IlyHhGI0ZWTAduTqfZhMUwGEUIR3VKeKdbfCxGxbFuqDBKKKhKwtD0EAeSLaoXpVJF
         yAVgGElwUT/X+m27fN4TFlNEqTQt0Hq+fqqq+ThrN/mfjxTtiT3f8lO6QqA+8Kj0VLOG
         gR9Q==
X-Received: by 10.66.180.200 with SMTP id dq8mr18919287pac.104.1397780762964;
        Thu, 17 Apr 2014 17:26:02 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id yv7sm133115701pac.33.2014.04.17.17.26.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 17 Apr 2014 17:26:02 -0700 (PDT)
In-Reply-To: <xmqq4n1rg9nc.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246460>

On Apr 17, 2014, at 10:15, Junio C Hamano wrote:

>> I think just the s/from/to/ would fix it so it does not give me the
>> wrong impression, but that doesn't mean that would not confuse
>> everyone else.  ;)
>
> Yeah, let's do that.  Thanks for carefully reading them.

> I'd think it makes it clearer to say that we take "return stopping
> the dot-sourced file" as a given and FreeBSD does not behave that
> way.
>
> -- > 8 --
> From: "Kyle J. McKay" <mackyle@gmail.com>
> Date: Fri, 11 Apr 2014 01:28:17 -0700
> Subject: [PATCH] rebase: avoid non-function use of "return" on FreeBSD
[...]

The new version of the patch looks great, let's use that.  Thanks for  
adjusting it.
