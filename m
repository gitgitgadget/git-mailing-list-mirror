From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: A question about the error: svn_fspath__is_canonical
Date: Fri, 10 Jan 2014 11:28:25 -0800
Message-ID: <20140110192825.GG4776@google.com>
References: <CABRpx=1CvB55zeL1L8QOvyfbJCaG9FK+HEz-iK9cFGrnxmOJtg@mail.gmail.com>
 <20140110191650.GF4776@google.com>
 <CABRpx=3vf-bwtA8_2ndPYo+fWCNiHQdSbLRGFWts4Wp3uN6yDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan Kaplan <dank@mirthcorp.com>
X-From: git-owner@vger.kernel.org Fri Jan 10 20:28:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1hkw-0004GW-Te
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 20:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbaAJT2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 14:28:31 -0500
Received: from mail-gg0-f178.google.com ([209.85.161.178]:50863 "EHLO
	mail-gg0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbaAJT23 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 14:28:29 -0500
Received: by mail-gg0-f178.google.com with SMTP id q2so100374ggc.37
        for <git@vger.kernel.org>; Fri, 10 Jan 2014 11:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GSAcdDKMFeDHSQZQ8YeRcmbnEQpW2ycZcsUYAmjU+Tg=;
        b=Q9+ovwyJzn8pdfvCXqjzSzh4Y/5cOkAKDWazGu1piCR4niiB7tfzYAlKtVCAVI3VZH
         WVoJol/sL6UXNf9fk7N39tOZjOGXNqGQNRZSb4Zn2JmKptPeYR0qUo2BYugsbS9Z0iFQ
         F//daDG1kcrxcHwS2Jwf5RLaMNNX9C86o0lpHQeu9YKh+TDhygUH0guJMpCKudvLhk0y
         SwNM3zoxcMQ5dHctHz56cSS3tkCo9O/9R2Sxl7fYVGuzeLg8Pl7NIZIurTadufnO+aDk
         uLZROJ7LLDPFZqf31NyGTwoH9a0gIzo0LDy+Iru/TIiC2RCzVdwxEWTsRshmLhMZACqB
         jj5w==
X-Received: by 10.236.149.77 with SMTP id w53mr2497523yhj.139.1389382108109;
        Fri, 10 Jan 2014 11:28:28 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id h80sm2124027yha.23.2014.01.10.11.28.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 Jan 2014 11:28:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CABRpx=3vf-bwtA8_2ndPYo+fWCNiHQdSbLRGFWts4Wp3uN6yDA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240312>

Dan Kaplan wrote:

>                              Do you think it'll still work?

Yes, that's why I suggested it. ;-)

You might need to install the gcc-core, libcurl-devel, openssl-devel,
and subversion-perl packages first.

Regards,
Jonathan
