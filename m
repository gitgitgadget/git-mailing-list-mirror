From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] fast-import: add special mode; copy from parent.
Date: Mon, 22 Dec 2008 04:25:11 +0200
Message-ID: <94a0d4530812211825v452d0cccp710054ee082e1690@mail.gmail.com>
References: <1229825502-963-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 03:26:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEaV6-0000Tb-4N
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 03:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbYLVCZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 21:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbYLVCZO
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 21:25:14 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:15085 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbYLVCZN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 21:25:13 -0500
Received: by fg-out-1718.google.com with SMTP id 19so711046fgg.17
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 18:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pZRrhxlDhxnc08dV7IzlApE3tDY79JXfh9sazzIjno4=;
        b=Na7AgCZAFjb4wQ9DVsCBOPev3u3UBy2tqffqmWaJqbp5MMlHgFA6ZPOr1trRLh0T+9
         Ys0Ao5wMKppFcZkoHLh1gVhwEY7Hj5wx0EB3Au84dNTN29sdN7S8cW5zoSssscTyb8a+
         IK2kJHxikBEe6tWU23zBII89v4//z974mAtx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=m+nc30mE1cr/p6waVc5Sl7C2LQ1UHH1VQ5oHwJULeXJBA4KPD/Oc0oe0Whoduu3RVM
         TCU5L8ohLVWlLd7wuBlxfQu0w3EBfxIClyy4nXG3x1s2zM+sRXTyTr96XzaRqzz8ub48
         cJHTV7SE8P5jyG1TpqQoeXKEC3v3zKyWUZgW4=
Received: by 10.86.53.8 with SMTP id b8mr3346445fga.13.1229912711555;
        Sun, 21 Dec 2008 18:25:11 -0800 (PST)
Received: by 10.86.77.17 with HTTP; Sun, 21 Dec 2008 18:25:11 -0800 (PST)
In-Reply-To: <1229825502-963-1-git-send-email-felipe.contreras@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103740>

On Sun, Dec 21, 2008 at 4:11 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-fast-import.txt |    1 +
>  fast-import.c                     |   41 +++++++++++++++++++++---------------
>  2 files changed, 25 insertions(+), 17 deletions(-)

Please disregard this patch, it doesn't work as I expected. I'll send
an updated one soon.

-- 
Felipe Contreras
