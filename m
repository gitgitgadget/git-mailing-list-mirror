From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 15/16] refs: add LMDB refs backend
Date: Thu, 17 Dec 2015 12:49:53 -0800
Message-ID: <20151217204952.GE6594@google.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-16-git-send-email-dturner@twopensource.com>
 <20151217010013.GC6594@google.com>
 <1450319481.11927.0.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 21:50:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9fUv-0004Hg-7q
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 21:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933013AbbLQUt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 15:49:57 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36474 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139AbbLQUt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 15:49:56 -0500
Received: by mail-pf0-f180.google.com with SMTP id o64so36629152pfb.3
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 12:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LoWpNHUDL8K7/u6vWHF7FRxCh2rJdKd0O6sF6UYgXoI=;
        b=s0XtaEkNY3ZzlmJVuUVNAiR94j12qzUrX1L2Tac+CPhr+CPSokc1ofGNUvU5c8ehGI
         8VN6EDDZyfOsMXK3Te/rCLqYotsbGjB3eEVikmnKVIGPVdvNHOjGeCPW5L3XXGdcaA/1
         nBv5ubBeHrvwqcZR0k/7xUZBDdQL4unyrn6qI8cFzzgDRx79yTnUpWvXT37TQUGoZyYw
         8NTwTKGI2UGRX8k3SPJmbU4dwn/sbln6OIEgiDv00xhZ2LQSBQHf4lNFqFT4Wl9t3FW+
         3TvYtj8vgnbB/DchTpNbt+Tca1t0DSB2JvO1seH+5b18kP2s28fF5NZui9I00ET+ug98
         Og+w==
X-Received: by 10.98.64.92 with SMTP id n89mr17193700pfa.159.1450385396172;
        Thu, 17 Dec 2015 12:49:56 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:79ec:7b1:1fb7:559c])
        by smtp.gmail.com with ESMTPSA id 15sm13223300pfo.43.2015.12.17.12.49.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Dec 2015 12:49:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1450319481.11927.0.camel@twopensource.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282675>

David Turner wrote:
> On Wed, 2015-12-16 at 17:00 -0800, Jonathan Nieder wrote:
>> David Turner wrote:

>>> +core.refsBackendType::
>>> +	Type of refs backend. Default is to use the original files
>>> +	based backend. Set to 'lmdb' to activate the lmdb database
>>> +	backend.  If you use the lmdb backend,
>>> +	core.repositoryFormatVersion must be set to 1, and
>>> +	extensions.refBackend must be set to 'lmdb'.
>>
>> If core.refsBackendType names one backend and extensions.refBackend
>> names another, which wins?
>
> I've simplified this to just use extensions.refsBackendType for
> everything.  Will re-roll once I finish getting comments on the rest of
> this series.

Perfect.  Thanks for the quick reply.

Jonathan
