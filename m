From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 1/8] for-each-ref: extract helper functions out
 of grab_single_ref()
Date: Sun, 31 May 2015 13:41:26 +0530
Message-ID: <556AC22E.90405@gmail.com>
References: <5569EF77.4010300@gmail.com>	<1433008411-8550-1-git-send-email-karthik.188@gmail.com> <CAPig+cSBaKwRqEEBB62LX0OyYGNddLHNU-zMEx2478kV8=+pDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 31 10:11:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyyLN-00053Y-4V
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 10:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035AbbEaILg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 04:11:36 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34946 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbbEaILb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 04:11:31 -0400
Received: by pdbnf5 with SMTP id nf5so24107834pdb.2
        for <git@vger.kernel.org>; Sun, 31 May 2015 01:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=QX7kYl2J+UEeoP4NI0QQQKUEsCaPI1ZCPz2rhyDvThw=;
        b=Zj55WZwJazPCklWHogx66aeqxBfKiIgZpSYFYPv/gvgOHvQIF5q+IDgx+bTRoXEMIM
         371qq3whOkOkvzecGoCMenWG/E3Bf8ndz9M80B4U9UTs/MHTeToHPx2hnJk7aCN6iFas
         Rh8sEs1c+SXOyv5KVOpXLbzegvz9a05IiOptWkXnCZD1K15ILpoXLK+53IeZrcxv50R8
         EkaM+6bMO7rXXqifUw9xjw2+BUpXXjVxRgdLsStoQ9mjyDVge+qYKPngka/piwnkuMsO
         dmx3eQUt++7dUV+kEFhiCsiuk8pqzKbQrUVsj22piK2OADOc+/O97IYLuB9isXPYGKXx
         B0og==
X-Received: by 10.70.54.7 with SMTP id f7mr29589597pdp.75.1433059891137;
        Sun, 31 May 2015 01:11:31 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id l1sm10654592pdp.71.2015.05.31.01.11.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 01:11:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAPig+cSBaKwRqEEBB62LX0OyYGNddLHNU-zMEx2478kV8=+pDQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270317>

>
> Why did this comment get removed? Isn't it still meaningful to the
> overall logic of this function?
>

Wasn't intentional, will put that back.

>
> Sneaking in whitespace change?
>

Noted. thanks


-- 
Regards,
Karthik
