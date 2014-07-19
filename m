From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: git_inetd_server: run git-http-backend using inetd
Date: Fri, 18 Jul 2014 18:54:08 -0700
Message-ID: <1A68D760-F69C-4DBE-AEAC-6672626A9515@gmail.com>
References: <43923BC7-08AF-4900-AC5E-B2F0FE7CD5AC@gmail.com> <20140717221056.GO12427@google.com> <8E3CD89B-2E47-4CA8-8F3D-598A9BE2AD9F@gmail.com> <20140718022208.GQ12427@google.com> <50047EE8-4EF8-49E3-9067-1C88B2FB9D58@gmail.com> <20140718171635.GR12427@google.com> <DC1EBA8C-1443-42DA-BA96-CB38D13502ED@gmail.com> <20140719001908.GX12427@google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 03:59:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Jvf-0006Fo-C7
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 03:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbaGSByN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 21:54:13 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:53772 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922AbaGSByM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 21:54:12 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so6389713pad.22
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 18:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=KTddRyQ7TPkp9uU6cXm+kzHLHzqc878T/DVAxXdHpWw=;
        b=BceD1rHqAEiitQXl/GBMdcy48g9TTm/UPJqpGuKM0ipxwEbHwWq3+eQHGCCUM3eTOH
         RenFArQ1YuO3KwIBdc645LeK9YglS0hEH99NHCfLI0SU3RV80/A5N4TixpuBtEaWeJSF
         AdBesFQYDyigZho3qEBgG8Efm1rDigrh7yOX5M+VpLEV/rviv9Q4gvpdJgKbC8rJ25Yo
         8e+MwY6W1wmbPEOx8U+3EzJv4d/Op1bS9u9T4GesFHO6zi+WsgNWpA1Gmov0FQan+lTG
         m2krtnzpjOIB4le/zMyXJ27HDOsJCg8l55H/2rdTOaFqMb1UD0PTRKuH5Dh3g1uNrifT
         De+w==
X-Received: by 10.70.43.7 with SMTP id s7mr7548205pdl.34.1405734851643;
        Fri, 18 Jul 2014 18:54:11 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id et1sm6892905pbc.39.2014.07.18.18.54.10
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 18:54:10 -0700 (PDT)
In-Reply-To: <20140719001908.GX12427@google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253861>

On Jul 18, 2014, at 17:19, Jonathan Nieder wrote:

> Kyle J. McKay wrote:
>> On Jul 18, 2014, at 10:16, Jonathan Nieder wrote:
>>>
>>> "Git URLs" as described e.g. in git-clone(1) weren't intended to be
>>> actual URIs.
>>
>> According to RFC 3968 section 1.1.3:
>> "A URI can be further classified as a locator, a name, or both. The
>> term "Uniform Resource Locator" (URL) refers to the subset of URIs"
>> [...]
>>
>> So actually they are URIs.
>
> You mean abusing the word URL when we meant URL-shaped thing makes it
> into a URL?

That is your contention.

> Do you
> mean that I should read that RFC and be convinced that what you are
> saying about ports is the right thing to do?

It's the right thing to do because it's the standard for how URLs are  
expected to behave.

> "It's in a standard that you never
> intended to follow" is not particularly convincing or relevant.

That is your contention.  If it is truly the case that where the Git  
documentation uses the "URL" acronym that Git does not actually intend  
for "URL" to be interpreted as a "URL" as defined by the various  
standards covering such URLs then explicit text needs to be added to  
the documentation saying so to avoid confusion.  In the absence of  
such text, expecting a reader of Git documentation to interpret the  
term "URL" any other way is irrational.
