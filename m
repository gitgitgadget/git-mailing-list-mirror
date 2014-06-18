From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 5/5] name-hash.c: rename to name_compare()
Date: Wed, 18 Jun 2014 12:10:21 -0700
Message-ID: <20140618191021.GV8557@google.com>
References: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
 <1403117117-10384-6-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 21:10:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLFi-0001iM-TP
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbaFRTK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:10:28 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:42597 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbaFRTKY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:10:24 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so982140pdb.39
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7Kk9n6Gb5O6/a/pkK5y8C1JaqVDpHGjrAnfkBln6GAM=;
        b=br2mYNqDqV15tq/1+iMaqVKsLvPq56wXnkfF98ZO35BMYozd0fepwWUAILr/EfVM3u
         Z8ki5pEU9WQjMv67fIyAj7QjzfAC6+/F4yr4zfVZ0+Lp/rxvZg+dh45ZCghz445iHyxa
         I6XXMpeIjS1fwkH/tZPQCW1t3cC6VThErCFU3nT6DJvrAbBfd3SdSVEtkXf42T3hps24
         fId8DXlZB35Zrppk2jWgabSUMfFDx5FimzxeHtQIr4B7PAWklf1f5uNHn7yNnI3NDQII
         BtYBnkGbi4fi4RnBs8iqStW35hw/a4xe9YntdVD/hDsVhrXzUzxcdBm6nkMOD63r7xCR
         A0tw==
X-Received: by 10.66.228.37 with SMTP id sf5mr22723pac.19.1403118624134;
        Wed, 18 Jun 2014 12:10:24 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bc4sm4732713pbb.2.2014.06.18.12.10.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 12:10:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403117117-10384-6-git-send-email-jmmahler@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252029>

Jeremiah Mahler wrote:

>  name-hash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Same thoughts as patch 4/5.
