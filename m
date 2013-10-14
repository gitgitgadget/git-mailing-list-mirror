From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 05/10] fast-export: add new --refspec option
Date: Mon, 14 Oct 2013 15:42:41 -0400
Message-ID: <CAPig+cRQR=YXGY6kMhy6PfkAKkxwua5jQY7JaKth0_-8s2r-8g@mail.gmail.com>
References: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
	<1381561533-20381-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 21:42:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVo2R-0003Sy-LB
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 21:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757165Ab3JNTmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 15:42:44 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:63066 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756685Ab3JNTmn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 15:42:43 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so5944657lab.26
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 12:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=LrEjb0vICT0xFitDmhW4wope/L0WdQMPbp2WZC+Du0g=;
        b=K9H8/Bju6gsLxlQUQvTd9f7GNRzh4j87RZOzSV696IPNpGJuH4XMhr5j8r+dZ5UJO7
         86vnUN9u6vEkxvsZpZlg/XG1H046rKn459uy9vKvE2uuF/QL2LMDXU2M7YquiKH3QHnI
         r5KduRcstNRG6yBDE3HGAClT2RObv7BOy8W1ftHQnNSddSFzl0UxHeBnlm0qZi8dTY2U
         +IYirJcoxcaJ6ihqc4I2JmXGzzbi0xZXPIJdSv7DqFuBYS3T441pNjGneEw+kTl7IvMj
         IdOcfZl9T7EhRL0tTuoKAhwuJHMwHH2zuIToyZfB1MmUtzYn9qf6GR91aQQL4AgRjVkL
         3zjg==
X-Received: by 10.152.23.5 with SMTP id i5mr31501091laf.8.1381779762033; Mon,
 14 Oct 2013 12:42:42 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 14 Oct 2013 12:42:41 -0700 (PDT)
In-Reply-To: <1381561533-20381-3-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: WM-XZcf17ohpyk3Bq6B8Qr203Ug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236116>

On Sat, Oct 12, 2013 at 3:05 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> So that we can covert the exported ref names.

s/covert/convert/ [1]

[1]: http://thread.gmane.org/gmane.comp.version-control.git/225475/focus=225489

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
