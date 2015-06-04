From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] send-email aliases when editing patches or using --xx-cmd
Date: Thu, 4 Jun 2015 14:11:36 -0700
Message-ID: <CAGZ79ka89omT3wKqV-J4eyAz+xDXDS+OBcXDDFsO=4kk1HBBpQ@mail.gmail.com>
References: <87pp5b1b4g.fsf@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>,
	allenbh@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 04 23:11:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0cQQ-00054I-GF
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 23:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbbFDVLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 17:11:38 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:34644 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbbFDVLh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 17:11:37 -0400
Received: by qcej9 with SMTP id j9so22919809qce.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 14:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0fRqYPHvZkGTA0tiaOWSXtrPDqqQFGO3Nexzfb1J0Dg=;
        b=I18Sd5RRC7nDZrfo1IzApGpRmUZcxPGxLgbJ+RlEO63ox1keD4Ib7zV9eVhNUAgfmm
         ZcimLUzSfmpUCQrmUu7LsW79YarhqZQX2ZDToYFoRMP9EzHb+cpdaOcjEi0ZusZKdpIq
         lMryOy0zswOLY3//Isqd11IzZWtXAo304z9T4UVV+BAFk2cgAtMADFvH2TsyKnbTZIL4
         v1FdNZtFX6+hVXWhXvt/ePWQwrHOE6MY/EPWu8EACWf3fvOhXI6R6KRiEaAMTx0ZKo2d
         yn2YnP6lYClTF/S/jLA9a87cqIX9FiiFTiFxIA1pU830h1dGJRrekFeaQU9EM1jVVyTx
         v2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0fRqYPHvZkGTA0tiaOWSXtrPDqqQFGO3Nexzfb1J0Dg=;
        b=MeZPam0hQyPKByFn5KKRKTHJzM9ajYESmxpCV9P/BaafOSlV9wefB0TikyNkrcRTun
         Pfzy+RXvvG+nU1AApc3pCPcfQNhj6pImDDWu07Xt2qz3qBDZu5Mr6KiHS0radg7U8EG6
         W+cls/oIDHnNlXCfs+LkNFgbuehNewntLQteW9pj3bMiBelER7CJkXP7K95u9XJn8ILa
         3O2XSqd2FUkkLuarFadsJOeccKQjmalhXdBBs8H4wSnLnA0uIwGk/A+i7gZbiVSXLbGs
         iCXwD2GqPIUQ+X7n6mR3UI5Wdf69rcT1cgg7hAZOf0d0TH5M8V8aI01qlavNiJ6SASFq
         kwxg==
X-Gm-Message-State: ALoCoQkaxM+dZixyQ3WKGXd1s4FGtmNJql7lGKdhKYZZPdZivvVTr9lgPbyRE5vZeJBZ3X6qlSMo
X-Received: by 10.140.196.140 with SMTP id r134mr10793qha.60.1433452296717;
 Thu, 04 Jun 2015 14:11:36 -0700 (PDT)
Received: by 10.140.101.115 with HTTP; Thu, 4 Jun 2015 14:11:36 -0700 (PDT)
In-Reply-To: <87pp5b1b4g.fsf@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270798>

On Thu, Jun 4, 2015 at 1:17 PM, Remi LESPINET
<remi.lespinet@ensimag.grenoble-inp.fr> wrote:
>
> Hi,
>
> Working on git-send-email, I've seen that there's no aliases support
> when manually adding a recipient in a 'To' or 'Cc' field in a patch
> and for the --to-cmd and --cc-cmd.
>
> I would like to add this support, and I wonder if there are reasons
> not to do it.
>
> Thanks.

Just recently Allen Hubbe did work on alias support,
I did not follow that topic though.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
