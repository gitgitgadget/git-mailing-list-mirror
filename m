From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/14] config: use message from lockfile API when locking
 config file fails
Date: Wed, 3 Dec 2014 12:16:36 -0800
Message-ID: <20141203201636.GZ6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203052124.GS6527@google.com>
 <xmqqvblsh5ca.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:16:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwGLv-0001Uv-6B
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 21:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbaLCUQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 15:16:42 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:49594 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbaLCUQk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 15:16:40 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so14536862ier.32
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 12:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3wMbth1naP6wx8kXglrN9sWp3OJiIaoxLnUmr4jtTmo=;
        b=roGNBs4ZLic5i5k+P3qpwCgpfvLSHE4lbBCkign6ldrZb9c8zJwkrJ0PMotnvbH5jU
         j4hjs+h+OQ531axacWeFfUXv3bxiPzM/VFBXsUcXKuTZpQltzub3huCt/bC3YJI1TLG5
         5punuGa0SeW2jJbI2LDufPumKQTtnkk6w2+hX6Rr4FicU/e9HRK8aiS33kD8vGgwIF3D
         UsM8B05f1A3doWoeapY9L54u8Qt3FveXzd3qRIncg4+gpKF8lqk+nbbhzFBTQn1xFpDf
         H+XzEtpOmJbE+fY4SGrsnkhM86yFrHDF5HPE9BMukvAAmcbW+AqEVvHlOUHFlt6fPJAm
         7FgQ==
X-Received: by 10.107.132.210 with SMTP id o79mr6547392ioi.50.1417637800005;
        Wed, 03 Dec 2014 12:16:40 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id h126sm7186855ioh.9.2014.12.03.12.16.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 12:16:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqvblsh5ca.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260686>

Junio C Hamano wrote:

> Up to this point the patches looked sensible (I am not saying that
> the remainder is junk---I haven't looked at them yet is all I am
> saying).

Nice to hear.  Thanks for looking it over.

Jonathan
