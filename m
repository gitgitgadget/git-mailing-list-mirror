From: Junio C Hamano <gitster@pobox.com>
Subject: Re:
Date: Wed, 18 Mar 2015 13:45:21 -0700
Message-ID: <CAPc5daWNTm5qtd1HJdgQ+-yqUpeMaMmK_UuUiyhxCF6gD3K9dQ@mail.gmail.com>
References: <CANSxx61FaNp5SBXJ8Y+pWn0eDcunmibKR5g8rttnWGdGwEMHCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Alessandro Zanardi <pensierinmusica@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 21:45:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYKqf-0004Gq-B1
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 21:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933359AbbCRUpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 16:45:45 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36244 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbbCRUpm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 16:45:42 -0400
Received: by oigv203 with SMTP id v203so47846762oig.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 13:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qtWl0ubbY2ro02GRw8TDyQJM9/S/0ECRK/4ebJFfGrE=;
        b=IStiXaoJtyLIk4coBNz5Nl4xDdt7YUDtVvDNRx96/KWaoV75yxsRE7rIr3FxX6fT9L
         +jubeQmZeQbEgNvhniwc6k8BhMlZrWvfK9obOEWz5p3IsK0T36OYOuv12BYSNkFsPBgo
         6Nsqz8w17q+rSjoOB5ealmJmpCMJcRt0ZvirKWCSD4kOFfIP1Wsyg5q75yvjDNxjwReP
         SorCg+pjzm5fxm54TDGHOChaPhxnNiyRKCg78Lm/mvZb+wK8dR/NA7nCjDYZhOb4LfrU
         ElbHy5oqQQcXv4M2H+oAKTayLn8Tc9n67l+Z9lds7OKTY6X5AwJwVsFps7J2FnTGmEHc
         jWRg==
X-Received: by 10.60.69.7 with SMTP id a7mr34430415oeu.55.1426711541674; Wed,
 18 Mar 2015 13:45:41 -0700 (PDT)
Received: by 10.202.87.85 with HTTP; Wed, 18 Mar 2015 13:45:21 -0700 (PDT)
In-Reply-To: <CANSxx61FaNp5SBXJ8Y+pWn0eDcunmibKR5g8rttnWGdGwEMHCA@mail.gmail.com>
X-Google-Sender-Auth: Gp9kOJfGFMLLm9Sppo1gAQ5IPmE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265755>

On Wed, Mar 18, 2015 at 1:33 PM, Alessandro Zanardi
<pensierinmusica@gmail.com> wrote:
> Here are other sources describing the issue:
>
> http://stackoverflow.com/questions/21109672/git-ignoring-icon-files-because-of-icon-rule
>
> http://blog.bitfluent.com/post/173740409/ignoring-icon-in-gitignore
>
> Sorry to bother the Git development team with such a minor issue, I just
> wanted to know if it's already been fixed.

I do not ship your ~/.gitignore_global file as part of my software,
so the problem is not mine to fix in the first place ;-)

Where did you get that file from? We need to find whoever is
responsible and notify them so that these users who are having
the issue will be helped.

Thanks.
