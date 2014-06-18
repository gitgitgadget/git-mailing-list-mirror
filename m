From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/5] tree-walk.c: remove name_compare() function
Date: Wed, 18 Jun 2014 12:03:59 -0700
Message-ID: <20140618190359.GS8557@google.com>
References: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
 <1403117117-10384-3-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 21:04:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxL9U-0002mg-Ck
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbaFRTEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:04:04 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58699 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbaFRTED (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:04:03 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so1036212pac.33
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ENch9NIENjKaaxxaOWkzMhkHQX8b6wRiw/2VHhOVIZI=;
        b=I6WiBiRfK9PdXJoENBF45owH3hkPxBWGIm+VXTAGJpHkUYdTo0aHsOiiWA9/+KpRtr
         T+vnXnpX0pGfGpASrUiJvUnQMoR95HJkoeGQbXTa+OqnS4Mju4eACtqT1ig7MamRYHKb
         MTKIRYJKj/eAFmMwT+krgzKr+MYvwUcrTrg3qpO/XqP9uckxczbhd7dZgwVjc9S2bLS/
         Yd3IHzJ3RS2Sy6l5dE7fguYgZCuyuj/ug7XLPhNiFYt0OCT9Df+F5NjMoy5dI7QJ7MlV
         mhGG1o2FxpmMVzKCAm3jtGuOrZXXnLRfg9D8jm9xjQO1rRQwQmmmmf+DKvSWqv4DuETn
         OvMw==
X-Received: by 10.66.162.137 with SMTP id ya9mr4890733pab.31.1403118241922;
        Wed, 18 Jun 2014 12:04:01 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id hk5sm4688684pbb.86.2014.06.18.12.04.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 12:04:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403117117-10384-3-git-send-email-jmmahler@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252026>

Jeremiah Mahler wrote:

> Remove the duplicate name_compare() function and use the one provided by
> read-cache.c.

I'd squash this into patch 1/5.

> ---
> Notes:
>     There is one small difference between the old function and the new one.
>     The old one returned -N and +N whereas the new one returns -1 and +1.
>     However, there is no place where the magnitude was needed, so this
>     change will not alter its behavior.

This is useful information for anyone looking back at the patch in the
future, so it belongs above the three-dash divider.

Thanks,
Jonathan
