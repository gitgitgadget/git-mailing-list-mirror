From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] branch: add show-tracking option
Date: Thu, 16 May 2013 02:51:46 -0500
Message-ID: <CAMP44s3_3JRz0vYpm5uvnAOgt=hH=DTTiB1xn9dQiK9swaANVQ@mail.gmail.com>
References: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 09:51:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucsyf-0005lR-5F
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 09:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816Ab3EPHvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 03:51:48 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:49606 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659Ab3EPHvs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 03:51:48 -0400
Received: by mail-lb0-f176.google.com with SMTP id x10so2774724lbi.21
        for <git@vger.kernel.org>; Thu, 16 May 2013 00:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=TyTgGfBgN80HPCACoGKOMqeV2t+rHk6M0/FzGxlvhhU=;
        b=I9MBLvBr0hHq8xYN6F8MQtYGI+CY/K1J8syJon+RKiHwyw8VwQAMKOKpHutD5nztyz
         Ca0SKFGeSEq42jfPHdL8XEEVDGJZzqYEZpz9MYQbCZtlNPs/0pvBEwtYAq2uBC6ndhaR
         QQRjqUn0hbLTV0KOAiIvRIdExhsb5EdYSmXiWa2Z2UKE1s7OnCtyEH0etOR8VXkjzkWA
         rBmZ4rHJ9PIh/FrWDxybsyuvnZAUbN82D9foDgQ0oWQOS6iGSS9KT+gMDyg4Z9hE8a3p
         9cuQ+48ogn4Lx7DNSEJt4jRPt0OqsV7Y0LGJBQniXJVjTB4UEkF5gxIzayecFM7X5l8w
         DFGA==
X-Received: by 10.152.120.4 with SMTP id ky4mr19853269lab.5.1368690706866;
 Thu, 16 May 2013 00:51:46 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 00:51:46 -0700 (PDT)
In-Reply-To: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224490>

On Thu, May 16, 2013 at 2:48 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Showing the tracking information for all the branches takes significant
> amount of time. The user might not want that. The --no-show-tracking
> option allows that.

BTW. I ideally I would switch around so -v has upstream, and --vv has
the tracking information. But that is changing the behavior.

-- 
Felipe Contreras
