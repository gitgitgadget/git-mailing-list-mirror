From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: eval_gettextln does not work correctly?
Date: Wed, 22 Aug 2012 07:17:26 -0700
Message-ID: <20120822141726.GA674@mannheim-rule.local>
References: <CACsJy8C4pcAj48sBOATZY21AgE5TdWysY6x-S6Xw8mWfQ9F4CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 16:17:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Bjw-0006pC-60
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 16:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851Ab2HVOQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 10:16:55 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54639 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab2HVOQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 10:16:53 -0400
Received: by dady13 with SMTP id y13so820533dad.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jAS/8a7uHxRdCk5Yoti28xNZNWwgiKH48NJVr8+XOhg=;
        b=anTSYvkcmZTvT7Sk4NwMfcLS7t/Fg+PwdVsrez81MxxZDO5TVFy/ZXhH7jzeioQ9Ov
         mnIEW0nY3cyV3U2cyCuGQIjAUnunmcAEn7tNTdFopGIH8VayE60S8WolOJbsl54I89Ja
         hbi7sM/2HMNLGqpxzt7YHuesqv/IFJDfP3TeClwl4jNaOYWVBS4+orM+yB9womDn5XX1
         Ewoiqu27heOcxnd5hbDZ7P7q7SICrgCYdw91xxV92pkRSi2TEPEJVJUIkYhMRM599x1+
         FW/DYc7SERF/rY1R5FN6w7DosSDfdKuhZsNkHKYSSv+zqu5Astmhi5pmsWn2TKbAzvZJ
         L5Yg==
Received: by 10.68.235.41 with SMTP id uj9mr53884065pbc.41.1345645012993;
        Wed, 22 Aug 2012 07:16:52 -0700 (PDT)
Received: from mannheim-rule.local (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id rz10sm3804377pbc.32.2012.08.22.07.16.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 07:16:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8C4pcAj48sBOATZY21AgE5TdWysY6x-S6Xw8mWfQ9F4CA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204018>

Nguyen Thai Ngoc Duy wrote:

> which means git performed a lookup on that string. It is from git-am.sh:
>
> eval_gettextln "The copy of the patch that failed is found in:
>    $dotest/patch"

Good catch.  It should use single-quotes.
