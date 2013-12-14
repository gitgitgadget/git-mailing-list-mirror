From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 2/2] diff: don't read index when --no-index is given
Date: Fri, 13 Dec 2013 16:44:56 -0800
Message-ID: <20131214004456.GA2311@google.com>
References: <20131210181655.GB2311@google.com>
 <1386755923-22132-1-git-send-email-t.gummerer@gmail.com>
 <1386755923-22132-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 01:45:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrdLt-0001uc-F2
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 01:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134Ab3LNApA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Dec 2013 19:45:00 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:64430 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab3LNAo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 19:44:59 -0500
Received: by mail-yh0-f43.google.com with SMTP id a41so2091259yho.2
        for <git@vger.kernel.org>; Fri, 13 Dec 2013 16:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AV6VwOZYHOsq6+Pn2C3j6HQGTe2w+sX0D9UxRw1h4Xc=;
        b=dYvL6R4FShXlWRvLkc88eCR53G9+oQz1ZD8PBzG0X23QxtE+bhseLxiLhZeM+76fbr
         0X6q6buaqQvXSyMl+JZ+t9kTG2dlcQsgizVOm/bqZVrNZ8UuyvYS1dXooPpITI/FvL9c
         HK2/tc+IlGCgkTJoJ5eTAL4gFjqifsz5bVwlxxfP7XgvGq/0RVrByGqA5YTKTk64mbEF
         J2PlqwkJglCjZs1NZ0MWzty0xmpB63UuR5BwEJCz2+0KN0+GIGz/MQmvuatw+5yYORLR
         mSsEU6U+b7tdskLGAGh07KdmC8Lu3nPVHrzp+DULvrPXETWY7ItPXZhpj9vpu4gIwH9n
         aH/A==
X-Received: by 10.236.15.102 with SMTP id e66mr4690752yhe.69.1386981899219;
        Fri, 13 Dec 2013 16:44:59 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id h66sm5963081yhb.7.2013.12.13.16.44.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Dec 2013 16:44:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386755923-22132-2-git-send-email-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239270>

Thomas Gummerer wrote:

> Also add a test to guard against future breakages, and a performance
> test to show the improvements.

Very nice.

> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
