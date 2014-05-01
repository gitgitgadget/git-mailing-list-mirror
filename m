From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Define constants for lengths of object names
Date: Thu, 1 May 2014 16:05:53 -0700
Message-ID: <20140501230553.GE9218@google.com>
References: <1398942410-112069-1-git-send-email-sandals@crustytoothpaste.net>
 <20140501172007.GZ9218@google.com>
 <20140501230041.GC75770@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri May 02 01:06:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg03G-0000pa-7P
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 01:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbaEAXF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 19:05:58 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:64973 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbaEAXF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 19:05:57 -0400
Received: by mail-pd0-f176.google.com with SMTP id y13so1547997pdi.35
        for <git@vger.kernel.org>; Thu, 01 May 2014 16:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=n+TRHcEFsdh2Wuqx/HLxfEI646Kr88hoih735JWLMAs=;
        b=nmfCcY/yMZUVXnTFmiomC0jZsh8zsoBAEvX4cUNQcdRNm9fs0HgMluGNgZsI542TqF
         QRAhw7MPPNWvrslve+ebgMfJ6MVD6lXY50dCsTY+DurJf6UymvkOO2k7yCzPB8qo02cq
         WQvgkIjaK4lrjqTrO7nue9j73e31mkP/H89caYjwwB4vnCVEO4FwU20vksmjnD0OpHRs
         idKG7V2dauN2RvfGqomanYrsqEe/I4RLXcIFqOyOx4HFuERx7MtZ7AzhWgZ9sbS/5gG9
         XP4DoZcw7w9WygbbABzqsKDu1awD+aAzB6IWIrGZIAZ6Lp031jv/lzutrDAWoCL5FqSH
         OWzQ==
X-Received: by 10.66.119.136 with SMTP id ku8mr26821336pab.121.1398985556731;
        Thu, 01 May 2014 16:05:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yq4sm167753062pab.34.2014.05.01.16.05.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 01 May 2014 16:05:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140501230041.GC75770@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247892>

brian m. carlson wrote:
> On Thu, May 01, 2014 at 10:20:07AM -0700, Jonathan Nieder wrote:

>> What happened to the
>>
>> 	struct object_id {
>> 		unsigned char id[20];
>> 	};
>>
>> 	...
>>
>> 	struct object {
>> 		...
>> 		struct object_id id;
>> 	};
>>
>> idea?
>
> There didn't seem to be a huge amount of support for it.

I can make up for it in enthuasiasm.  Please?  It's something I've
wanted for a long time but never found the time to do.

>                                                           Also, there
> were concerns that some architectures might impose alignment constraints
> on it that made sizeof(struct object_id) != 20.

Sounds awful.  What architecture?

Thanks,
Jonathan
