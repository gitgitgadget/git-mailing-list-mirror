From: Stefan Beller <sbeller@google.com>
Subject: Re:
Date: Wed, 18 Mar 2015 14:45:11 -0700
Message-ID: <CAGZ79kZwc-==jfoW3zUC94sUfnPUv0sqZwupi3R-UK=pGn-5iA@mail.gmail.com>
References: <CANSxx61FaNp5SBXJ8Y+pWn0eDcunmibKR5g8rttnWGdGwEMHCA@mail.gmail.com>
	<CAPc5daWNTm5qtd1HJdgQ+-yqUpeMaMmK_UuUiyhxCF6gD3K9dQ@mail.gmail.com>
	<CAGZ79kZwmvZyye-3pHCbDgXhuQTQ8OsgtomK7BtR86qqU1koxQ@mail.gmail.com>
	<20150318211716.GC3376@peff.net>
	<20150318212852.GA28860@peff.net>
	<CAPc5daXkiwyAF+rXH6ywN-An5F7rHCa0-QVY72LkeeTpAsRisQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Alessandro Zanardi <pensierinmusica@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:45:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYLmB-0000W5-3A
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 22:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbbCRVpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 17:45:14 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36593 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933593AbbCRVpM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 17:45:12 -0400
Received: by igbud6 with SMTP id ud6so6368455igb.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 14:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kW9QAoI0RnGb/YcekwEMrwbs5q23R7tMvTG7Gzyugu4=;
        b=eB8pNfbvExiOYjN/ixOd4J3Dd+6sdhAcC1Htf4vijkijeJ8+Vx3jGpfSxAoRoNmlCp
         4WIU1ROBG3g+gCAIYkIgfWdqDk+rPejV7aUWgQY3C3Rpd1ir7AnWqpWytjjXhOB0qrnH
         2IyvDZRppZqH5ULYqWyg70ZJr6J/9x5bAiRfbWiYxaUQSOeZzIk4cVapxw6O03bWcqWH
         tEv9AHyNJkPYEC1kZmyKnaI8cfGo3sQSWFSfgPUZU5YkxKavv1/EpBVSBxPbdewm/XRE
         7ntTIqeX1iN+uZwfHVM1Zhd8UXhyUSfei7f5fX/D9fsNbWqZ47CtpNj8cVn16QQSxVXl
         M3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kW9QAoI0RnGb/YcekwEMrwbs5q23R7tMvTG7Gzyugu4=;
        b=EUKU7Pdi6qiJiICUF1lsFjJ0rgBMA+O9L+cWPIqdq90UgpILB1vVu2h2ShylmSqsfN
         adZdz6qTUyyYEZS+KWGK0cGcXOMHynYUWbMED9R03gQq2mLDAqAGhTB/KH6r7u4FGcDu
         P5KvbBikPVQs03awHlpPCA3Wf8F4tSoa9Ezsi6LvjCLvNzw+59Fnk3n/KN/9HPIkUjYz
         n8nPHEE2M7FtgBOvuNnx+Kph5p2lGkZMaWdIdvIQF+WRnTqA6zIw3Pl2POu/Wqui7Dp4
         bZdFVMvKfCr+HmuitG0hewi9Ab8s6tRhLdrv/4wE92DHjweVyHvRSE+ZGDA9mJUVn/66
         uMOQ==
X-Gm-Message-State: ALoCoQn195hXRL9Tr4Yu1uo4WAylRKtVGReySGBKNq5lqnWhUf26I8u3Y4veXAmTjyzg4eoSf4HI
X-Received: by 10.107.15.155 with SMTP id 27mr115107391iop.49.1426715111329;
 Wed, 18 Mar 2015 14:45:11 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Wed, 18 Mar 2015 14:45:11 -0700 (PDT)
In-Reply-To: <CAPc5daXkiwyAF+rXH6ywN-An5F7rHCa0-QVY72LkeeTpAsRisQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265767>

On Wed, Mar 18, 2015 at 2:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> What does the Icon^M try to catch, exactly? Is it a file? Is it a directory?
> Is it "anything that begins with Icon^M"?

It seems to be a special hidden file on Macs for UI convenience.

> On Apr 25, 2005, at 6:21 AM, Peter N. Lundblad wrote:
>
> The Icon^M file in a directory gives that directory a custom icon in
> the Finder. They are a holdover from MacOS 9 but there are still a lot
> of them out there. The "new" OS X format for icons are .icns files but
> I'm not sure if you can do custom file directory icons with them (you
> probably can, I just haven't found the docs yet).
>
