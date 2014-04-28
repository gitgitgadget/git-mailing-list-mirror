From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/12] Makefile: introduce CROSS_COMPILE variable
Date: Mon, 28 Apr 2014 13:45:04 -0700
Message-ID: <20140428204504.GP9218@google.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-5-git-send-email-marat@slonopotamus.org>
 <20140428162536.GB13002@google.com>
 <20140428204048.GA21365@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:45:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WesQO-0004Es-Vp
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbaD1UpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 16:45:09 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:54367 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871AbaD1UpH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 16:45:07 -0400
Received: by mail-pa0-f50.google.com with SMTP id rd3so6261965pab.9
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FTpcovwxl/NpYOep/M1NcaLRc0OiNpTfYH6KBJXoPWI=;
        b=If++i+x6+0txuTQ8R25CR/b382R7L9SXBZYS1Vut6oPvFpRdWd/xdyZARKaImjAf7F
         duE2CbJFfJ5z1L2H5+LPnyavjWgZgohhTENl2OcjpLizBBAq9fScw7u5ztqtsaxlOGIy
         TfhcQmcwFpDkBRQzafo7e3n+qMsCL9hRsVvIa+Z51dt3GZq9HkUiD7pP9ZBNkONnip+y
         47GoCuUlrz4bTWgXqPbbG+AaNolJooTZ8H7v25eQoTO24iYHvOTx9xsb35klv668J8DU
         ECE0Yqqst9EdA7Ynr3l1lRfCi7RKSh2KroyGGrschKYoLjlqrsH7upuh9Im77vCzbb9B
         YcWw==
X-Received: by 10.68.190.163 with SMTP id gr3mr27581268pbc.103.1398717906992;
        Mon, 28 Apr 2014 13:45:06 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id au16sm97034874pac.27.2014.04.28.13.45.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 13:45:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140428204048.GA21365@seldon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247442>

Hi,

Marat Radchenko wrote:
> On Mon, Apr 28, 2014 at 09:25:36AM -0700, Jonathan Nieder wrote:

>>> -STRIP ?= strip
>>> +STRIP = $(CROSS_COMPILE)strip
>>
>> Before, STRIP from the environment took precedence over STRIP from the
>> makefile.  Switching to the more usual 'environment can't be trusted'
>> convention is a good change, but please mention it in the commit
>> message.
>
> Taken from [1]:
>
>> Simply expanded variables are defined by

I'm not really sure what in particular you're pointing to in that
page.  If you have a more specific question about what '?=' means,
could you say it?

Hope that helps,
Jonathan
