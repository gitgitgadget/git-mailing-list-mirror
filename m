From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: git clone does not understand insteadOf URLs
Date: Sun, 26 May 2013 17:13:26 +0200
Message-ID: <CA+EOSB=ow9Vc2J8qb3GAp4xj2GgY8qes=5Q-k-rH6VsVLjzCsg@mail.gmail.com>
References: <51A11DD0.4040802@svario.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Gioele Barabucci <gioele@svario.it>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 17:13:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugcdd-0008P5-Hu
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 17:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab3EZPN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 11:13:28 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60009 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab3EZPN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 11:13:27 -0400
Received: by mail-vb0-f46.google.com with SMTP id 11so4071071vbe.19
        for <git@vger.kernel.org>; Sun, 26 May 2013 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=KbHVCbPeXpUN3WwJbAneQbDQcNH12Pk/WCcTCCK98Ik=;
        b=HPSW35d8K668xA7sVI0F2v15ESFivP9N6Lnlqs6Y8DpnJmlZyO9QW6UMoqId0nbZHe
         IBNt5tPwzsZtDLsUYibntdmDSFArQuX77k2KI2gO5UGlc8A5FQ+xx9Bba449jq7l+Vax
         W1ciJgo2l2jbJkpJU08ec3gfD0hdYgGgakfSnBhbMp8JbLYT3oLlV3Ekr8TVy4A67EwZ
         V2vj3orSNJdkYalZUnGdC0qFmz/qCq6ajBeDjG0040hP5y8975ID29JyT65CPrj8NSOb
         rulgXgyCXNkZv9dwjasi+gaoMEeQhvmmgrD/NsgFfqUZgVgT4kozxcOuuIr5139xmHtZ
         gsSg==
X-Received: by 10.220.168.71 with SMTP id t7mr13105601vcy.39.1369581206451;
 Sun, 26 May 2013 08:13:26 -0700 (PDT)
Received: by 10.52.34.138 with HTTP; Sun, 26 May 2013 08:13:26 -0700 (PDT)
In-Reply-To: <51A11DD0.4040802@svario.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225552>

Why someone should be do something like this ? What is the use case ?

Best regards

2013/5/25, Gioele Barabucci <gioele@svario.it>:
> Hello,
>
> it seems that `git clone` does not understand keywords used `insteadOf`
> longer URLs.
>
>      $ git clone remote-repo/ProjectA.git
>      fatal repository 'remote-repo/ProjectA.git' does not exist
>
> I suppose that git interprets the argument as a local directory. Git
> should see if the argument matches one of the known URLs before raising
> an error.
>
> Regards,
>
> --
> Gioele Barabucci <gioele@svario.it>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Inviato dal mio dispositivo mobile
