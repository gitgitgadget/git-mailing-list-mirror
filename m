From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/3] Move CodingGuidelines and SubmittingPatches to ./Documentation/technical
Date: Sun, 30 Dec 2012 17:22:45 +0530
Message-ID: <CALkWK0=FFt2qfrUop9kwDVQ1FfPm+4WY8kBBY+rtyp16QFOR_A@mail.gmail.com>
References: <1023165134.213650.1356863340563.JavaMail.ngmail@webmail06.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Dec 30 12:53:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpHSR-0002Al-Ka
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 12:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab2L3LxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 06:53:07 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50]:61289 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab2L3LxG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 06:53:06 -0500
Received: by mail-oa0-f50.google.com with SMTP id n16so11013774oag.37
        for <git@vger.kernel.org>; Sun, 30 Dec 2012 03:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Glfh3+r8p9wtm3XbdvcARrn/ahvrKh3yRn6/GdgP42M=;
        b=AbvLlk8tEoh/WyJ0ouw8GPm3bxADkeSc6yRdVO8iJluLPIdzdI3auM8DXwhgHhiRIK
         zZLooVyn9sv0TJnMIgfcwikL9G60Eqp/t2xr6wXi/xU01HgjBKxpEAv7LyPemq3si9ld
         ViiucsFLB36IwcW5+NBqKVZ3gYyT6m8HgaMdmMi9+V3qVS7a1sAbbkl80ET3tyQpCcst
         9GwbjllktmWuXorjfqACsRpOJTCuvh9cQAFo5+N4uj8N0Geeo0hRmTm2xtmP153YbnX2
         XssxRwD5ACeriI6lpnvIcw5SxcFDVyiZlD2M5rRJbx6TmKjg1DBeMDs+XpfyW5ybXJJp
         Ypxw==
Received: by 10.60.28.129 with SMTP id b1mr20458462oeh.106.1356868385260; Sun,
 30 Dec 2012 03:53:05 -0800 (PST)
Received: by 10.76.75.198 with HTTP; Sun, 30 Dec 2012 03:52:45 -0800 (PST)
In-Reply-To: <1023165134.213650.1356863340563.JavaMail.ngmail@webmail06.arcor-online.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212327>

Thomas Ackermann wrote:
> CodingGuidelines and SubmittingPatches are IMHO a little bit hidden in ./Documentation
> and with respect to their content should be better placed in ./Documentation/technical.

I don't think SubmittingPatches and CodingGuidelines belong to
Documentation/technical; that location is mostly reserved for API
documentation.  Also, being prominent documents, they're probably
linked to by many places on the internet.  I wouldn't want to
unnecessarily break those links.

Ram
