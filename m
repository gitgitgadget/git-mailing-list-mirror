From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 00/20] refs backend rebase on pu
Date: Thu, 04 Feb 2016 16:23:18 -0500
Organization: Twitter
Message-ID: <1454620998.5545.11.camel@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
	 <1454443734.5545.1.camel@twopensource.com>
	 <CACsJy8Cau0mpz8zVjvz7RPt-s=xmaCCmz0p8OCup9-Q1MnwWCQ@mail.gmail.com>
	 <1454617535.5545.10.camel@twopensource.com>
	 <56B3B71C.1000907@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 22:23:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRRN7-00077u-K2
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 22:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254AbcBDVXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 16:23:21 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32832 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbcBDVXU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 16:23:20 -0500
Received: by mail-qk0-f180.google.com with SMTP id s5so26730239qkd.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 13:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=IChPIZFhTgM5HRyLBiJm9jxzEKKu1mxVfODjfn+BDB0=;
        b=QphVuneXBDyVGROG+6eNZ+dvzzDNuLKPZlTN6GD5Al8hdY6ZflbbwNKtMD2dD4NA8r
         UqKnYSmeZI9C9KQVA6s5aYPB4lrXZ3Dbnh/t6SwIMJO1Vj9IIc7klwX0YVUHvvHfXy0+
         ooWTHaesZDqG4fd6TmaFwHt6Zr+kfWwvRBi07oqGESN4P8Q/wGxLPeVywvXdKWJZONb4
         m2nRhMy0ZIotqM2sg8KWTbho+BQiJc78Mxw5qPAVgQE18vmDzWzM8kY4/GLAVEXq3THq
         ZdC0YO8+UgICL22sLhp1MjiE5WLQ9cEurxiknG7ugMGbetFDEGk8doN0FyOiJRHuVuG1
         9dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=IChPIZFhTgM5HRyLBiJm9jxzEKKu1mxVfODjfn+BDB0=;
        b=KI2+RwDHVTgKxATj85+RYzkCfqF7vcPHD3wdVswNv1dHOq3/piGjR7ApPfecPEEDlf
         3RdbFnccv8BBXIGXFZ7xIZyXBJEGIIpAVNbZLfj3x5H7HJ5e/HIPyrz3PMnJHQ6FLQZR
         92t+bW9RRV4QIeJ26KkWXOB2i1VtnsVJtP6tiUJCoQsLFoHCw/NxykZCI6CLB8orL5iE
         1GRKjVzBKL2JQFSju5FYIZruwlPFHUiYfQzQX1IxFln9Uaw8L7eg+0JI/mYYN0webn6j
         LkF8m6JTEudjKAGawDSlAOE+zAaaYF3rzjAHkmU4SkprecKdL18Wj/5Ig0LwH8hIMQF1
         mzsQ==
X-Gm-Message-State: AG10YOSlGggn/EsUZ51CWnNN3nDBPowCpnpED/Ltd+AntN4f8pXiWPvIZMkiNL4GNFmC9w==
X-Received: by 10.55.79.69 with SMTP id d66mr11978749qkb.76.1454620999989;
        Thu, 04 Feb 2016 13:23:19 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id j7sm6175690qgd.2.2016.02.04.13.23.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Feb 2016 13:23:19 -0800 (PST)
In-Reply-To: <56B3B71C.1000907@ramsayjones.plus.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285494>

On Thu, 2016-02-04 at 20:39 +0000, Ramsay Jones wrote:
> 
> On 04/02/16 20:25, David Turner wrote:
> > On Thu, 2016-02-04 at 18:42 +0700, Duy Nguyen wrote:
> > > On Wed, Feb 3, 2016 at 3:08 AM, David Turner <
> > > dturner@twopensource.com> wrote:
> > > > Are there any more reviews on this?  I do have some changes
> > > > from
> > > > this
> > > > set, but they're pretty minor so I don't want to post a new one
> > > > (unless
> > > > folks would rather see those changes before reviewing).  Let me
> > > > know.
> > > 
> > > Last note. Since this is new code, maybe you can wrap
> > > translatable
> > > strings with _(), basically any visible string that machines do
> > > not
> > > need to recognize.
> > 
> > Fixed, thanks. 
> 
> Another minor point, could you please squash this in:
> 
> diff --git a/refs.c b/refs.c
> index 3d4c0a6..4858d94 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -17,7 +17,6 @@ static const char split_transaction_fail_warning[]
> =
>  /*
>   * We always have a files backend and it is the default.
>   */
> -struct ref_storage_be refs_be_files;
>  static struct ref_storage_be *the_refs_backend = &refs_be_files;
>  /*
>   * List of all available backends
> 
> The above (on Linux, anyway) is a 'tentative definition' of the
> refs_be_files variable and so a common symbol definition is issued
> in refs.o. This then gets 'combined' with the *actual* symbol
> definition in  refs/files-backend.c. So everything 'works', except
> that I have used some unix (let alone non-unix) systems which would
> not output a common symbol for the above and would fail to link
> with a 'multiple symbol definition' error.
> 
> [Also note that an external declaration is already in effect from
> the refs/refs-internal.h header file! ;-) ]
> 
> ATB,
> Ramsay Jones

Fixed, thanks.
