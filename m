From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] Make locked paths absolute when current directory
 is changed
Date: Thu, 31 Jul 2014 16:58:43 +0700
Message-ID: <CACsJy8B9yJrQRSiCa2eQeeVZu_JPwjpykM1DXjVi3+JrKRF8Fg@mail.gmail.com>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com>
 <1405858399-23082-1-git-send-email-pclouds@gmail.com> <1405858399-23082-2-git-send-email-pclouds@gmail.com>
 <53CD1529.9080102@ramsay1.demon.co.uk> <CACsJy8AXc4jvLPNpGyGdY9uzrnN-SbEeiksLDpS_=29gJ1KMnQ@mail.gmail.com>
 <xmqqr41ek5hl.fsf@gitster.dls.corp.google.com> <CACsJy8B6JpqOnbGZuKQPGrY1y8SyKzg+4aSP2iiM-Gb=3Jv5sw@mail.gmail.com>
 <1406775673399-7616119.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Yue Lin Ho <yuelinho777@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 11:59:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCn8o-0000fo-Go
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 11:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbaGaJ7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 05:59:14 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:45512 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbaGaJ7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 05:59:14 -0400
Received: by mail-ig0-f182.google.com with SMTP id c1so4678996igq.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 02:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5GEnxx0Bq8zwwaNPARtt2wuubHdw0C0VIKE9zuDp2QE=;
        b=Zf3JunAQS5Z8QJ6S2CvQDDJhJbdYG+sR+EnKabmbIhaGVBahKma1eJegd19Ie8VvVN
         9m9x0tpy+rE7H1G8+mV9JLietLu0WmhIpOwiijxjU3UzzUiVVnnOoxEkaVw3hqSQs3EB
         j8dncgBOUPTmu6ucb8pLh9jjRmHfTGqQlilIOstZV64YY0aQ/a5OWHaZSQ2ZUuPB0Jgp
         rUP1V7et7Cp42/3N+r9AuYSastqEKrdh1mJ1YYKIrtm+NLwxcUOZI2BzOxQrj75hCry4
         MqrhYNuxPqxOztLg/PzyhA45whgb1E285pO3hALFZyjXdXusMsk14LDy8DWAzQqdXeyt
         M1yA==
X-Received: by 10.42.65.3 with SMTP id j3mr13844380ici.65.1406800753308; Thu,
 31 Jul 2014 02:59:13 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Thu, 31 Jul 2014 02:58:43 -0700 (PDT)
In-Reply-To: <1406775673399-7616119.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254549>

On Thu, Jul 31, 2014 at 10:01 AM, Yue Lin Ho <yuelinho777@gmail.com> wrote:
> Hi:
> How do I trace these patches applied?

They are not applied yet. I'll needto redo them on top of rs/strbuf-getcwd.
-- 
Duy
