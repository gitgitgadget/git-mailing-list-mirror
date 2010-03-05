From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: gitignore broken in git 1.7.0.1: slash checks leading dirs
Date: Fri, 05 Mar 2010 20:30:55 +0100
Message-ID: <4B915BEF.1030201@gmail.com>
References: <4B90C701.3070308@gmail.com> <4B90C974.2050405@viscovery.net> <4B90C9BE.1030407@gmail.com> <4B90CBE5.9090102@viscovery.net> <4B90CEDD.6020106@gmail.com> <20100305172549.GA28562@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 20:31:09 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NndEn-0001lW-Fi
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 20:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517Ab0CETbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 14:31:00 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:40337 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab0CETa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 14:30:59 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1571398fgg.1
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 11:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=DCsvOuD8Tf0mt6fQbkWSOmGtT7FvZU0pmhQnOCjbsZk=;
        b=FFB6VPjqkeRU/RQHJHza9JDEWzx8QhsVGUgEIyiUK0YymLT3UqnLiqdDQWCIrJfvF0
         xNsoYrYxo1cEJs94PTfL0bGyP1jSVRFUdm5iLQ2WQE02xRVB2sgjxirQbWDykQwDkfo7
         0h2eleSHyZ5h723hlCEyIqkc65dgcmTL9H/1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=WAM0mV5qyjVBO63rtBxPVVtP6A/3r6G+eh3eQe1PwmshsdbX2baMlWaLEt2aUKHDco
         vNLPsfkzaUB5sou4xqgMGcgdxxEzwAemqDeg7mB/fJEh90iG/JDutGtVzUYhBrlZKN/8
         sMCXeMd9qv0oJVl0WuhP5uAy7CCWPn8zWj430=
Received: by 10.87.58.19 with SMTP id l19mr2760494fgk.43.1267817457803;
        Fri, 05 Mar 2010 11:30:57 -0800 (PST)
Received: from [192.168.2.149] ([217.66.174.142])
        by mx.google.com with ESMTPS id e11sm3043548fga.6.2010.03.05.11.30.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 11:30:56 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; cs-CZ; rv:1.9.1.7) Gecko/20100111 SUSE/3.0.1-11.2 Thunderbird/3.0.1
In-Reply-To: <20100305172549.GA28562@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141595>

On 03/05/2010 06:25 PM, Jonathan Nieder wrote:
> Jiri Slaby wrote:
> 
>> Thinking about it, there is no way to specify a *filename* no matter
>> where it lies? I.e. patterns such as *.o matches also a/b/test.o/test.c?
>> Am I missing something?
> 
> Is
> 
>  *.o
>  !*.o/
> 
> what you are looking for?  The first line matches *.o anywhere, and
> the second matches *.o anywhere as long as it is a directory.

As I wrote above, *.o also matches against a/b/test.o/test.c, correct?
