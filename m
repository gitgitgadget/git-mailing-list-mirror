From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 25/48] remote-hg: add test for diverged push
Date: Sat, 25 May 2013 02:28:22 -0400
Message-ID: <CAPig+cTjxX032icuoh0Do-zEJqSYO0ftbHKERms9eSAUbH63sw@mail.gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
	<1369449004-17981-26-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 08:28:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug7xs-0003bf-96
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 08:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407Ab3EYG2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 02:28:24 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33920 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab3EYG2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 02:28:24 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so5402238lbi.18
        for <git@vger.kernel.org>; Fri, 24 May 2013 23:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ZLfH9MxUa8fjQu0KcfLxxkG16k01WEIFsYdLj157hiY=;
        b=KH3euTou75Y4x9TNMhWuRYx6wiq40ejnKWqn6RKYTZjFpGOVVIwOlqn7OFw5zOMKyj
         QoSFQoT4Qgv1PKV4QuqrAbCxXCOxpkvujzbdutp1RSvdCEJmAl21QPRtO8Hqy1X0i2Vv
         d6K7JBAVbqSunwY0F5brIvhMBVfUwBHRAs/Bx7rzUkq51DvlpGYoPx9JB2cTR6gi8f7h
         qa+l1EA8wRQW3Gdvoe02vD5d6e4QDKhO4cf0L5dcyY3mpDo2mQBobA+ITDij3NoyKocp
         tlNJ/81i2v0h6DAxvvIRUfORfs8eQxMeChUpqpMl/TuA5n7q0LYm3Ij/ovq/qynG3Xoz
         KU2w==
X-Received: by 10.152.8.37 with SMTP id o5mr10399530laa.1.1369463302472; Fri,
 24 May 2013 23:28:22 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Fri, 24 May 2013 23:28:22 -0700 (PDT)
In-Reply-To: <1369449004-17981-26-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: 4pqHfJC8POjYBpU2T7bcBIyVpho
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225491>

On Fri, May 24, 2013 at 10:29 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Neither mercurial nor git allows pushing to a remote when it's a
> non-fast-forward push. We should be able to detect theses errors and

s/theses/these/

> report them properly.
>
> As opposed to throwing an exception stack-trace.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
