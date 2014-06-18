From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 3/5] unpack-trees.c: remove name_compare() function
Date: Wed, 18 Jun 2014 12:04:39 -0700
Message-ID: <20140618190439.GT8557@google.com>
References: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
 <1403117117-10384-4-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 21:04:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLA5-0003Tn-Ou
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbaFRTEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:04:42 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:64427 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbaFRTEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:04:41 -0400
Received: by mail-pd0-f182.google.com with SMTP id y13so978146pdi.13
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 12:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0Vb4pNJKOWQfDf1auHPEFkLwPUTJH1kz1BLl/0ir2D0=;
        b=KWhp+0zWtAzSz7XNsHWNReJws4aNSb10uUL2rjhcw2neKvCCJFk1WTfcWTD88Dbgv5
         Vgk3nNK6KdbN6GjJvYIsA2yIfTaEnicj0lJdCopEYPkgsTC99lhRC0sjfrfBKay+eNiY
         xcame8LlBVBdKZXznFt38vu1CcOz6S+gh0aJ1kTGEFiccfV42KvpvFeAGlbng7h98jX0
         VKLHgLYczf3d4q7PNQuIWjgAx6esTIz3tucRhQYeUQ1T6l1nuunZrY77sGSvSqx4j2Yg
         feVnjrahk92Gg593qc1gFHbZO2i5fGsIPFkiwPh/aHR5v9yLED8ZDaLxbDKy+64EcsGm
         dihw==
X-Received: by 10.68.171.229 with SMTP id ax5mr4459434pbc.125.1403118281588;
        Wed, 18 Jun 2014 12:04:41 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pu5sm4717712pbb.4.2014.06.18.12.04.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 12:04:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403117117-10384-4-git-send-email-jmmahler@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252027>

Jeremiah Mahler wrote:

>  unpack-trees.c | 11 -----------
>  1 file changed, 11 deletions(-)

Same thoughts as patch 2/5. :)

Thanks,
Jonathan
