From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Use compat/regex on Cygwin
Date: Tue, 16 Jul 2013 18:03:14 -0400
Message-ID: <51E5C322.80806@gmail.com>
References: <1373897453-18799-1-git-send-email-mlevedahl@gmail.com> <51E5BE08.9060304@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 17 00:03:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzDLA-00045c-3W
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 00:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933765Ab3GPWDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 18:03:18 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:38218 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933760Ab3GPWDR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 18:03:17 -0400
Received: by mail-qc0-f172.google.com with SMTP id j10so716217qcx.17
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 15:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hdE/YjW3n7q+uossagZObKwTYEqzUWucq4z+ikkLmhA=;
        b=hZCRtwV5apNvU4x3fIDnGi824HrjobcKNGAMm1Vza0s0BzZMb1ATTW/sfDQE7OkZg7
         sdY9JqOUf/m9QHemHxFD+EBqPx5Ybtod79kg/MRG+yoMXd0PIGKrW/+IEdhZ9i0xjNki
         fgXwFES+pJMpU6dKNb8aSpou9bzZTwqjJTe2X5WFStKiWea+TdD2MOa7vjbdQMj33TAr
         KcuCWNCG7nWU0ly/TcSDYiVcZdCk/p9QHPVbMnZja1UCNPmmSBB1J7N1iF0zwsCyBd7+
         fCCvbebtB3syk96hXRB0vL6ba9a/jLfib52hzGCnU4laVAI16F4w9ZA9nBgUEKccRK+5
         pp8Q==
X-Received: by 10.49.0.140 with SMTP id 12mr5028600qee.26.1374012196963;
        Tue, 16 Jul 2013 15:03:16 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id s9sm4612034qeo.3.2013.07.16.15.03.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 15:03:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <51E5BE08.9060304@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230590>

On 07/16/2013 05:41 PM, Ramsay Jones wrote:
> Mark Levedahl wrote:
>> Cygwin's regex library does not pass git's tests, so don't use it. This
>> fixes failures in t4018 and t4034.
> Hmm, these tests have always passed for me on cygwin. So, this is
> presumably a regression in the new-lib regex library versions used
> by cygwin 1.5 and cygwin 1.7.
>
> ATB,
> Ramsay Jones
>
>
>
Perhaps we should just completely separate cygwin 1.5 settings from 
those for current cygwin. Extra motivation is that cygwin 1.5 is no 
longer on the mirrors - the last real update was mid 2009, and the 
project finally removed the installation tree altogether.

Mark
