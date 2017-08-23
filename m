Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E111120899
	for <e@80x24.org>; Wed, 23 Aug 2017 21:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbdHWVJr (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 17:09:47 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35793 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbdHWVJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 17:09:46 -0400
Received: by mail-qk0-f169.google.com with SMTP id 130so7415858qkg.2
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WljYQMaJ2tMxJnTBsGIbwccvHnwWw8KUYoQ7Lb9MK5w=;
        b=hGU4Nu7+5KDUYjyDkPLUOyNReyOqRe8nofQREoUfcVyDW2gqwjEIZeVJtjoZW2Aiq1
         V3IPPUmx0sd5ZKLGeNg+pXYcD7js0p4gEhsRPCVFDNCs02Xfi4YYrxBRliiFirHxw/lF
         okvcLhbxMvtgpAjgwKHLddo/MTeQI4QCdOulnHfFb9XYBP+LDq7p2OOWdIam+A26OtIU
         bhfhG8F71qZp7WGkRpsRUSi6GDl8RUXbRQzQ9EK9lYEAmUWQUvK3Fprn7jNHTb198u0e
         IzRilij1UxCVuELn5F6/jjgIUeZvMHdKl8qci59QSRchG1kdKm9S58+4rFtEsEesTjNS
         u5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WljYQMaJ2tMxJnTBsGIbwccvHnwWw8KUYoQ7Lb9MK5w=;
        b=TY/nh6n6AtEL+OZHkbODJc7HJDiLyqin3dCFbXHVQGguKbd8dErKje8wfJd8kfS/oi
         MNNU3Lobx7n+uCPHVkbjKpseS1LBHaFHesQV7HJ/q1X+6bRFkfGLo6toZljE8B5FVoBQ
         AlC8BhnMc0kQy2GO1EGYOtj5Hqr3E1uZONSa2qO6SD32JgJTQSlxHHdINmlne6NVrjKj
         DdWDLBuhxl3r+q0CVeG3uGoRrLjkJZcTfXIDD41lziXASD6vNAHiy9dxHDBkF8/H7n/9
         EAmYd9W0RvuSs5f1IfdcxNrqHi/lBYnDMMrrSctHZrX7gfQCYoS4deY/SJuKEEcBm67u
         EqsQ==
X-Gm-Message-State: AHYfb5hR3jZdQ4LTaRKNes0nubcto19MhKR4nvW4DAgRw/5ObhQYASYP
        9tYia1foIzBVox/FIvk=
X-Received: by 10.55.70.84 with SMTP id t81mr5199277qka.189.1503522585419;
        Wed, 23 Aug 2017 14:09:45 -0700 (PDT)
Received: from localhost (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id w63sm1450217qkb.67.2017.08.23.14.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Aug 2017 14:09:45 -0700 (PDT)
Date:   Wed, 23 Aug 2017 17:09:44 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: Cannot checkout after setting the eol attribute
Message-ID: <20170823210944.GA32462@megas.kitware.com>
Reply-To: mathstuf@gmail.com
References: <20170822174918.GA1005@megas.kitware.com>
 <20170822191318.GA22118@tor.lan>
 <20170822194441.GA25093@megas.kitware.com>
 <20170823194315.GA29237@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170823194315.GA29237@tor.lan>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 21:43:15 +0200, Torsten Bögershausen wrote:
> git reset does it's job - please see below.
> 
> The problem is that we need a "git commit" here.
> After applying .gitattributes, it may be neccessary to "normalize" the
> files. If there is something in the documentation, that can be
> improved, please let us know.

I'll have a patch up shortly.

> On Tue, Aug 22, 2017 at 03:44:41PM -0400, Ben Boeckel wrote:
> > The fact that plumbing is necessary to dig yourself out of a hole of the
> > `eol` attribute changes points to something needing to be changed, even
> > if it's only documentation. Could Git detect this and message about it
> > somehow when `git reset` cannot fix the working tree?
> 
> The thing is, that the working tree is "in a good state":
> We want "dos" with CRLF, and that is what we have.
> There is nothing that can be improved in the working tree.
> What needs to be fixed, is the index. And that needs to be done with
> "git add" "git commit."
> As Junio pointed out, the read-tree is not ideal
> (to fix a single file in a possible dirty working tree)
> 
> In your case it looks like this:
> 
>     echo "dos eol=crlf" > .gitattributes
>     git add .gitattributes &&
>     git rm --cached dos && git add dos &&
>     git commit

In this case, just adding the file should work: the file is on-disk as
intended and adding the file should normalize the line endings when
adding it into the index (basically, just `git add dos` should be
required to make the index look like it should).

> > Or maybe it could at least exit with failure instead of success?
> 
> I don't know.
> It -may- be possible to add a warning in "git reset".
> I can have a look at that...

Thanks.

--Ben
