From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] docs: add filter-branch note about The BFG
Date: Tue, 17 Dec 2013 10:40:03 -0800
Message-ID: <20131217184003.GJ2311@google.com>
References: <1387277599-69719-1-git-send-email-roberto.tyley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, tr@thomasrast.ch
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 19:40:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VszZ7-00088v-QV
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 19:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944Ab3LQSkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 13:40:14 -0500
Received: from mail-qe0-f54.google.com ([209.85.128.54]:46937 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557Ab3LQSkK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 13:40:10 -0500
Received: by mail-qe0-f54.google.com with SMTP id cy11so5571962qeb.13
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 10:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pqOslb5/n7fOX5ycqFxnGXihdk9RXN7SL89B5HbUUuY=;
        b=XKqiK7wFaUjPuoAfKmj1k2QWQ4U5vUZzyk7dQLZZwp34Lq541BK24+rmViMM4jEr/p
         KoRYaNutcHi0JrgIzpgipxsfYQRIq04JG4cKzAkYrw04dgd2B8JurOudxikuS0aTk6+P
         H6VuYr5Q3KqDaJe8Le/KLduUG0hBRPFIB46JPPLnxdR3/3auRriLG1J2EdAF34sK94sg
         TLv69dVGI6TYIWWCzBdCPbIElxRGptqzRXnErwppjXAwr4nTa5pnJMLuWooTBxwHoQbq
         FGrO1WJJSmO8/bEhzI7B63PoCQsFa7ez332DmeaeIhReALSuClzpHU3+xLbwwHabtKsh
         ix+Q==
X-Received: by 10.49.116.78 with SMTP id ju14mr45824600qeb.57.1387305609080;
        Tue, 17 Dec 2013 10:40:09 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 4sm58925293qak.11.2013.12.17.10.40.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 17 Dec 2013 10:40:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387277599-69719-1-git-send-email-roberto.tyley@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239395>

Hi,

Roberto Tyley wrote:

> The BFG is a tool specifically designed for the task of removing
> unwanted data from Git repository history - a common use-case for which
> git-filter-branch has been the traditional workhorse.
>
> It's beneficial to let users know that filter-branch has an alternative
> here:

That sounds like a good suggestion for the SEE ALSO section, or an
explanation of when each tool should be used would be a good thing to
put in NOTES, but...

[...]
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -18,6 +18,12 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> +
> +NOTE: For simply removing unwanted data from repository history, you may
> +want to use link:http://rtyley.github.io/bfg-repo-cleaner/[The BFG Repo-Cleaner]
> +instead - it's generally faster and simpler for eliminating large files
> +or private data.

... this shouting NOTE at the top of the description is way over the
top.

So as is, this patch looks like a net negative.

Thanks and hope that helps,
Jonathan
