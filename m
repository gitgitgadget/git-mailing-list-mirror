From: Moriyoshi Koizumi <mozo@mozo.jp>
Subject: Re: [PATCH] Support various HTTP authentication methods
Date: Thu, 29 Jan 2009 23:02:14 +0900
Message-ID: <4981B6E6.6020502@mozo.jp>
References: <1233221532.21518.1.camel@lena.gsc.riken.jp> <4981826D.507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 29 14:56:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSXNC-0001aw-7r
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 14:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757311AbZA2Nyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 08:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757263AbZA2Nyi
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 08:54:38 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:45737 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940AbZA2Nyh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 08:54:37 -0500
Received: by wf-out-1314.google.com with SMTP id 27so8696275wfd.4
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 05:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=nCY0Jak2GF8FmvXCkzjPzjFEhIJk0CFDBtYwJt+DPOo=;
        b=Qg6KYJLYT+aN2/uFbd6MiW1+0OQW35mNLujL/uhS/hW1TkGh2K/ULh5Ds20LB18wko
         4WZlm+7EtfGay05OTJ6cTfI1FtyB7sG8hIICRymu29cqTSPwm3hTOwKAgFGNyy+XRTfM
         LhABj4TSHUuxP1LhqxclyShmxxqwxIZs9R5yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=iwyPR2YtW5yymRctGdlOzZ2Cb87kojFK/klSpwo/unQjue6XF/95EMVzQoB5WF1hae
         35Vj7rrcxyRdwlodvAH4LR6lmwsAy7nVN16Ihf/RV+0EQise8B+zNdLpZjN7sO+6Favp
         0Ppv3l9X5OHxg8+Bd6ZwpYNyvHIqkM+b1RT+M=
Received: by 10.142.222.21 with SMTP id u21mr28518wfg.243.1233237276440;
        Thu, 29 Jan 2009 05:54:36 -0800 (PST)
Received: from ?192.168.0.131? (i58-89-25-149.s04.a014.ap.plala.or.jp [58.89.25.149])
        by mx.google.com with ESMTPS id 27sm31289974wff.51.2009.01.29.05.54.35
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Jan 2009 05:54:35 -0800 (PST)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <4981826D.507@viscovery.net>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107676>

Johannes Sixt wrote:
> Moriyoshi Koizumi schrieb:
>> @@ -210,6 +272,20 @@ static CURL* get_curl_handle(void)
>>  	if (curl_http_proxy)
>>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> 
> CURLOPT_PROXY is set here...

As I wrote in the previous post, this part was from the original.

> 
>>  
>> +	if (curl_http_auth) {
>> +		long n = get_curl_auth_bitmask(curl_http_auth);
>> +		curl_easy_setopt(result, CURLOPT_HTTPAUTH, n);
>> +	}

> ... and here again. Is that necessary?

What part do you mean by that?

Regards,
Moriyoshi
