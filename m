From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: fix hg sharedpath when git clone is moved
Date: Sat, 23 Nov 2013 10:32:12 -0600
Message-ID: <CAMP44s2=b+7cFbRK-NFPU-myT8JtaSsrKut4AbvjOAQe0OCxDg@mail.gmail.com>
References: <1385210302-25518-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 23 17:32:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkG83-0005Wk-Jc
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 17:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185Ab3KWQcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 11:32:17 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:54359 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517Ab3KWQcP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 11:32:15 -0500
Received: by mail-la0-f52.google.com with SMTP id ev20so1755372lab.39
        for <git@vger.kernel.org>; Sat, 23 Nov 2013 08:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NkYeoJBnLkBSwsPm1c57PoDXG/hr7HAJdBcdcYW3pt8=;
        b=rd5lGbxQAKrPdDHrK3fI5ZHNz3FKPsDYRuFIAmlChgooiC1/uHxAjNa9szCH2njU3j
         kyHiV2QyAh3o8mQdE88d4wtDpGHnAfuExXvmjbGu44Clb9JQfA9GyXoeDcJuh9sniWdE
         AXK1IYUZ8xKUJMSihHXbnbhJf0BlLffyl3zjvueQqiTgOv26ZWXnA3MIWbrPT0LQcbbz
         DvWpAd3FC+zhaOshWYjpEnhdU1/yrse2dp7Dz+5MqwoeNhOv21QtQv8f6C48C5zhl+Ol
         EIJzLLqYdMCFwVJ22pP8zo/2lYgwmMXwEuJPtvd5Uzn6pAIQW/neka/3fWs2Ja/24QqV
         /7Lg==
X-Received: by 10.152.45.8 with SMTP id i8mr15005514lam.12.1385224332493; Sat,
 23 Nov 2013 08:32:12 -0800 (PST)
Received: by 10.114.201.69 with HTTP; Sat, 23 Nov 2013 08:32:12 -0800 (PST)
In-Reply-To: <1385210302-25518-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238239>

On Sat, Nov 23, 2013 at 6:38 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
> remote-hg is using a mercurial shared clone to store all remotes objects
> in one place. Unfortunately, the sharedpath is stored as an absolute
> path by mercurial, creating a dependency on the location of the git
> repository. Whenever the git repository is moved, the sharedpath must
> be updated to reflect the new absolute path.
>
> Check mercurial sharedpath file when getting the local hg repository,
> and update it manually with the new path if necessary.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>

https://github.com/felipec/git/commit/270e7ff91a4a34e8bc27edb6bd7d7473b886f568

-- 
Felipe Contreras
