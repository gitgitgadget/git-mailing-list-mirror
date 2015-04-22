From: =?UTF-8?B?RGF2aWQgUm9kcsOtZ3Vleg==?= <deivid.rodriguez@gmail.com>
Subject: Re: git's directory is _prepended_ to PATH when called with an absolute
 path
Date: Wed, 22 Apr 2015 14:47:51 -0300
Message-ID: <5537DEC7.2020303@gmail.com>
References: <5536C319.4000402@gmail.com> <20150422054737.GA11889@inner.h.apk.li> <553787A0.40707@gmail.com> <20150422153109.GO23476@inner.h.apk.li> <20150422170205.GA827497@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 19:48:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykykk-0008R0-Uc
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 19:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbbDVRr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 13:47:58 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35149 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbDVRr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 13:47:57 -0400
Received: by qgej70 with SMTP id j70so87317156qge.2
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=h8oJFdL9G+EvPySUyAWhCwd/WWqLf/iZnIvsRCBqHDo=;
        b=ZJPOc/J3zlR69GASEXimwWwdB19fiYggVZQijNi4x1/UbnhgRucoms8bETzlvd44D7
         xCC+iD/uJfnpfstdRGvDT1LDln58z51OJNr8CvGEs0unE99UYIah4jvDvoL9+F7y9T7d
         1jnBcyF01x5NdaKjU1rqkYGBwaDLD2EqIgrSpLEMIU2Sm2n49YbGJCgmDZLGTOn5XlGS
         NNnRE2MpJcELI63iqKJ7kN2CAtyHRWe3SmW3KvOQxKIeenAEhLLsdF5NNVKvPGNfj5dk
         tLODjC2nHucJq9XcbXzl6CvtWgheN1WZH8F7Nnf3kX3FrZc9wjzIDiCdBgjCYh8ekYVO
         0JeA==
X-Received: by 10.140.145.202 with SMTP id 193mr32208353qhr.43.1429724877173;
        Wed, 22 Apr 2015 10:47:57 -0700 (PDT)
Received: from [192.168.1.103] ([186.237.38.30])
        by mx.google.com with ESMTPSA id j93sm4118562qkh.29.2015.04.22.10.47.54
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2015 10:47:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150422170205.GA827497@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267602>

On 22/04/15 14:02, brian m. carlson wrote:
> "I want whatever ruby the
> user chooses."
This is exactly what I want. The problem is that git overrides the 
user's choice by prepending /usr/bin to the path and thus making 
/usr/bin/env choose system's ruby version. Which is almost always not 
the Ruby the user chose.
