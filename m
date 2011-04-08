From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 0/9] Some more sparse patches
Date: Fri, 08 Apr 2011 00:15:39 -0700
Message-ID: <4D9EB61B.6010302@gmail.com>
References: <4D9DFF61.8090302@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Apr 08 09:15:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q85vA-00058i-8s
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 09:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393Ab1DHHPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 03:15:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59719 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027Ab1DHHPt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 03:15:49 -0400
Received: by iwn34 with SMTP id 34so3207694iwn.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 00:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iVdUkKZhMqFMd91Ni8oZzV/0RJGXQfxKN2tRdhGK/7A=;
        b=aw9HgoDTZTKHbI65f5cmoBwnEniQMqE4Y/d5aDgMys/4cn/aQjot9tVv8NyBYGRPDQ
         V8jaZWydGfN+rSeIs5iPbNhdEcMDBVlPY1LqZr6Tt29f4jwVHxEnynt8AFMISTBvYabN
         nrqiOTPG/OrMIENEtyRjQ3CtYHiBGXrzoiXk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=b2kjnvsP3pknrP8Hbo9uRIWtEPnT+hk812TGY7NW58QWiaifjnLZhWiPus2RBiG9d/
         iIvRvIKfjfZtzJVbxUHau33heOOr+/8k2v7MM6tFwTcffZH6e3boU1oUUPERYoO93Ucr
         6yvIA/uFwl2Ni6agJ13K3F7Yykqh2FshJtuNA=
Received: by 10.42.161.70 with SMTP id s6mr2961501icx.374.1302246948758;
        Fri, 08 Apr 2011 00:15:48 -0700 (PDT)
Received: from [192.168.1.107] ([75.85.182.25])
        by mx.google.com with ESMTPS id wo11sm1535444icb.20.2011.04.08.00.15.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Apr 2011 00:15:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110313 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4D9DFF61.8090302@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171113>

On 04/07/2011 11:16 AM, Ramsay Jones wrote:
> Hi Junio,
> 
> My (git.git) sparse branch, which I've been feeding and updating for
> over two years now, has recently started to shrink quite rapidly.
> This (of course) is due to Stephen's recent commits (eg c2e86add
> and 52d269da and 1e4cd68c). These patches are (most) of what
> remains of my sparse branch (Some are just too ugly to send :-P ).

Yeah I was sitting on a few of these since I didn't have the time or
effort to sort them out. Plus I have to wade through all the warnings
that ULONG_MAX and LONG_MAX causes on my 64 bit system causing me to
miss some things. Thanks for picking it up.

I pulled these patches down and gave them a test. It looks good to me,
except I see this when I check http.c:

$ make http.sp
    SP http.c
builtin:1:9: warning: preprocessor token GIT_HTTP_USER_AGENT redefined
builtin:1:9: this was the original definition

Any ideas?
