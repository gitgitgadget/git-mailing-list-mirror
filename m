From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: GSoC 2016 Microproject
Date: Sat, 27 Feb 2016 20:50:40 +0530
Message-ID: <56D1BEC8.9010302@gmail.com>
References: <56D19EF9.3070702@gmail.com> <vpq8u26qo3y.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 16:20:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZgfp-000108-Ay
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 16:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756598AbcB0PUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 10:20:45 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35502 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331AbcB0PUo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 10:20:44 -0500
Received: by mail-pa0-f53.google.com with SMTP id ho8so68710959pac.2
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 07:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=u/gr652VcKfCNEmhI8DxE9NeghQCckf26XJRUSm1EQc=;
        b=whxDbi2UzcTgMfXYkavGtcJa6vkA/qJqFIACGWFCuRrY0U2I+BP/aL0bcCDoy0ImLO
         +IegfZM1N2N1wLpclnKaINZqfz2eIN+INeHVjwupQSiXo3SEuNjERMUDRj7dL9TkD9hS
         86FOdXd80/fa3P3slVGmC7hb54gRt2PLahNUFMfNNqtPwDIE+loX5jAZEQOrnND7iRX2
         0/wsc6rGecxXaMArVyCcRAwGN55pARn7BiIqLi8XJpkH/UFDodHZqA6bh2fkWiwixcvE
         7LG6REHAxuEOSvs5x5UIWu7/28QYok94YorNdIHl9n76Xit4xuh2URqIg22+f6zm6pos
         bTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=u/gr652VcKfCNEmhI8DxE9NeghQCckf26XJRUSm1EQc=;
        b=ZZPKk/+3sKBt4vv91S8lf1swsEcs1PRPDLKUv95yFz15Jg6uIJF+zU0LO6U6fglwWX
         zb/Qe5o8nKgyLOOr9KQaGhamVpcKgy7YjEJTpF35LBkCLGW/lI/Vif5LQT14Gi84k9UG
         WpAwG++XyRkI9xqa4EFkwcNvdmi9bJlEz9sD5vojAJbN2JBo31mt20Pzo/kLWVtFR0f3
         rJqTgJoXMLfxIO7UQ9YmAOcE4CaIeoDZhankqsCKFyt4dgj14XpkdLiY+Bfv8PPhmy8z
         TS7AuXd3uXfvLd2TiyeUxIuxlqn/M3wO9IPF3Tmrxc9HJz8jGKc0EtcImKIPgH6egAI1
         H66g==
X-Gm-Message-State: AD7BkJKo/MJbtAbuneF9uIGNRLWwvu/xYT6UhEHB1h7PxWfxO4o9tGJErIyQBqXm+Ap6bA==
X-Received: by 10.66.193.131 with SMTP id ho3mr9993106pac.154.1456586444176;
        Sat, 27 Feb 2016 07:20:44 -0800 (PST)
Received: from [192.168.1.10] ([182.68.63.13])
        by smtp.gmail.com with ESMTPSA id q85sm26804407pfq.81.2016.02.27.07.20.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Feb 2016 07:20:43 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <vpq8u26qo3y.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287702>


> There's already work in progress on this project, see the mailing list
> the last few days.
>

Okay, in that case, I'd like to try is the one titled "Make upload-pack
and receive-pack use the parse-options api". In that, I can take up
the `builtin/receive-pack.c` file. Would that be okay?


Thanks again.

Regards,
Sidhant Sharma [:tk]
