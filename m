From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cmd_struct
Date: Wed, 13 May 2015 16:23:49 -0700
Message-ID: <20150513232348.GD5586@google.com>
References: <CACnwZYe5i3p0f7cvprya=VdhFnnMW_H=K18BFqjq_Qn86cjXeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 01:23:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysg0L-0004YB-2O
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 01:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965456AbbEMXXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 19:23:52 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35629 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965006AbbEMXXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 19:23:52 -0400
Received: by iebpz10 with SMTP id pz10so46610636ieb.2
        for <git@vger.kernel.org>; Wed, 13 May 2015 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BvpH8yoKS8ppgvnkDO7w2xeeUtQaDPyx1Xi+uEwe0zA=;
        b=emDQoAIYZJAj8vgvxzU2iqOI1mf7dEFDpqJ0dq+XzLR0FdlNto4LPxPKmznJU20/Cw
         aUWyJzZLQqiuorf7FjI6nsSHN0e2ZSoufCb9jD+r2FiiYtSiN4s38/hwP4ps5RNvcOIB
         9utQxWq523n/FFvOgPqpRYU5mSChdUPtAIaiJzJsqtRhzcS8qu6RzJvY4CYN8o9zBgJ7
         OYrkufeBDyNbHg/AF6T9bVUdShYS2Yx8YVAsegX6sEhmM+jhAl8iC0oagAtrIbphHkNc
         NVyjNyOlmmJ79o3AaYY2TcP1BIn7jJc5ISCAe9o3xUxCxDShbN6IxugGEhr6TpZd5KJH
         kYQA==
X-Received: by 10.43.178.195 with SMTP id ox3mr11871474icc.10.1431559431650;
        Wed, 13 May 2015 16:23:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b941:a00f:6e0d:bb19])
        by mx.google.com with ESMTPSA id o15sm4652319igw.11.2015.05.13.16.23.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 16:23:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACnwZYe5i3p0f7cvprya=VdhFnnMW_H=K18BFqjq_Qn86cjXeA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269017>

Hi,

Thiago Farina wrote:

> Would be too churn/noise (at this point) to rename cmd_struct to builtin_cmd?
>
> I know "Why" question could come, but I prefer to not answer it if I can.

The answer depends on the "why".  (Not "why do you ask?", but "why
rename --- what benefit would it bring?")

Thanks and hope that helps,
Jonathan
