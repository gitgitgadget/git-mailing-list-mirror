From: Andrew Romanenco <andrew@romanenco.com>
Subject: Re: problem with file mode
Date: Mon, 8 Jun 2009 16:49:44 +0300
Message-ID: <18e14dc30906080649y2efa7facv1109fcd797614d27@mail.gmail.com>
References: <18e14dc30906080209m9eceb6ft81c77ea0345b30e3@mail.gmail.com>
	 <20090608123006.GF13775@coredump.intra.peff.net>
Reply-To: andrew@romanenco.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 15:49:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDfEZ-00043G-0t
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 15:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbZFHNtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 09:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753217AbZFHNtp
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 09:49:45 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:60804 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbZFHNtp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 09:49:45 -0400
Received: by ewy6 with SMTP id 6so4186888ewy.37
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:reply-to:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=6XrCmAe5enSktA+eWypeBHPnNtFVF60IKTCWbOyVaY0=;
        b=W3VYomelOIEf3BhvhFJ+3/TIi+XwfASZbfMiPE0p5JcttrWUC5r8E5yNu14T1Os/aw
         gKoDl9Zz+2TBnNZi1dz4Uo8v14Yx69T34rSsutcuFYkplGMqjZNIuRuj7bGy5tMtzsWZ
         AMOyzQctIVkX2d9A2e3wCG35z6nm46YfLTqBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:reply-to:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=bfYwsTK7psE2RemfW8Gk4PI65XwXsUxf0WQCOjRI1I8mU9vScJFypYJTI3jGMQxxEF
         bo4QkqqIdweaaTNL5thVrnbVNJDF24T7IubQm/bkhBLS7eo3bDrRpNtC6VfkvWeJOP6E
         9bj5Kraz8qfPyt3Xhjtpq5aRh9En9/nScXDZI=
Received: by 10.216.54.207 with SMTP id i57mr2314512wec.114.1244468984356; 
	Mon, 08 Jun 2009 06:49:44 -0700 (PDT)
In-Reply-To: <20090608123006.GF13775@coredump.intra.peff.net>
X-Google-Sender-Auth: 3c2632e205caee0e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121073>

true - B is Fat

On Mon, Jun 8, 2009 at 3:30 PM, Jeff King<peff@peff.net> wrote:
> On Mon, Jun 08, 2009 at 12:09:23PM +0300, Andrew Romanenco wrote:
>
>> Both stations are ubuntu 8.10
>> And I have repo with text files on station A
>> When I do git clone to station B all files become executable 755
>> And git status show that all files are modified, diff shows mode change
>
> What filesystem is station B running? Is it something that actually has
> a proper executable bit (i.e., not FAT or similar)?
>
> -Peff
>



-- 
Best regards,
Andrew Romanenco

        Software developer
        Microsoft Certified Professional (win2k)
        Microsoft Certified Database Administrator
        Sun Certified Java Programmer
        Sun Certified Web Component Developer
        Oracle Database 10g Administrator Certified Associate

        mailto:andrew@romanenco.com
        http://www.romanenco.com
