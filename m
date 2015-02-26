From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: compiling master fails
Date: Thu, 26 Feb 2015 13:00:48 -0800
Message-ID: <20150226210048.GB13958@google.com>
References: <CAGZ79kaRJg1QzFSyj0iAtUn2nUFxzZRy7BsrYC2++kaN0RD1Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 22:00:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR5YH-00074T-EN
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 22:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbbBZVAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 16:00:52 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:37898 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbbBZVAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 16:00:52 -0500
Received: by iecrd18 with SMTP id rd18so21115926iec.5
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 13:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WnpC7s8AW6vaPXQ7SAFmzUNl1oqIvtK8OsUd+abHdiw=;
        b=0nRz9ehhPQ+MvRF6yclOHKCVxHIPd/yZo2CSqE8dyl3hZnbOQOQ3t/LdocJ5dguMy8
         KS+qMo2+xeHlIC2pbAzdl7LSNTP8Q8UyrR9h/u78BdWyRJ3gkLHMfNf9yM/GxBHepdZl
         gGsdNZIUbWGlLEihMcyA/nOis5xrKSCO0Ym8vs+l9buUBNa0QMxmCT33UOFwouLhrpC6
         dGMriHjar+YUbyMQ4VYtHVf7Bn28ypcjCHHOuhI0nwi/adazA1oVJ8klLePjeL3QkTfc
         lsPhGLLyO0t1O3wiBJx7nsVCNfiqLZ8xqhrHH86kxlRe3iUBHCqRc4erQNGg+JHv3+c0
         9kEw==
X-Received: by 10.50.111.168 with SMTP id ij8mr14337766igb.43.1424984451275;
        Thu, 26 Feb 2015 13:00:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c94b:4724:7b4a:e8c9])
        by mx.google.com with ESMTPSA id ie15sm1671767igb.12.2015.02.26.13.00.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Feb 2015 13:00:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kaRJg1QzFSyj0iAtUn2nUFxzZRy7BsrYC2++kaN0RD1Aw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264463>

Hi,

Stefan Beller wrote:

> On Post 2.3 cyle (batch #5) (v2.3.1-167-g7f4ba4b)
>
>     CC http.o
> http.c: In function 'get_preferred_languages':
> http.c:1021:2: warning: implicit declaration of function 'setlocale'
> [-Wimplicit-function-declaration]
>   retval = setlocale(LC_MESSAGES, NULL);
>   ^

See http://thread.gmane.org/gmane.comp.version-control.git/253901/focus=264421

Thanks for reporting,
Jonathan
