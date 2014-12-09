From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 9 Dec 2014 15:15:57 -0800
Message-ID: <20141209231557.GC16345@google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209224949.GB16345@google.com>
 <20141209230748.GA3442@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 00:16:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyU0l-0003iR-1J
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 00:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbaLIXQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 18:16:01 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:61816 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbaLIXQA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 18:16:00 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so5831297iga.9
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 15:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bC4Y3YzmKXvQlAYZeWiuIYvQEG3Keg3xLxmBsjgQ01k=;
        b=Teo9trCM99f74rBE/FL+dm4eAd4poSpxLie+B6GtjNJJU2vWlU4VLjikvks0m0c/9Z
         VgrMQXTZ/D9pnuyPEOTqEzpi1DXFE2F9mEjbEJJTgwY1H7hZN4kINHFuJTDTuz3WHDf3
         oc4tjoJSVMR7EoU/zG5SbH+iR6MEizA/zVJRrnJLxPa50j6vJOONKFN5Gbe8a7BGfN0D
         94/sukAb4ZOkT+fiG5xLMS9nHWHHwSiT/uzAxuPh/bwEn7yFPcjDATYoRb0xEMyQq94f
         B3AKbifh6n+rsKG83wnIAYH63zThHiEqcsatubR/A4xss7P8eudCRgtSoItuw9lYoUB+
         qdMw==
X-Received: by 10.107.159.19 with SMTP id i19mr937611ioe.79.1418166960009;
        Tue, 09 Dec 2014 15:16:00 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a4ec:4fac:afb2:e506])
        by mx.google.com with ESMTPSA id j139sm1301674ioe.16.2014.12.09.15.15.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Dec 2014 15:15:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141209230748.GA3442@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261175>

Stefan Beller wrote:
> On Tue, Dec 09, 2014 at 02:49:50PM -0800, Jonathan Nieder wrote:

>> And another:
>
> this goes on top or replaces the previous one? (This applies cleanly on origin/master) 

They're independent. :)

[...]
>> Reported-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>
> Thanks a lot for this patch. It's improving the situation a lot.
> No information is lost albeit many deleted lines, have a
>
> Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks for looking it over.
