From: Elazar Leibovich <elazarl@gmail.com>
Subject: Re: Supporting "-v" option for git-log
Date: Wed, 25 May 2011 14:14:01 +0300
Message-ID: <BANLkTi=v8j=VdBNgThRTFXk+YbPFOFvzwQ@mail.gmail.com>
References: <BANLkTik70gu0NUzUEnGNWHQr8CfbdPVe5g@mail.gmail.com>
	<SNT124-W39164C74A457129811245DC4740@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 13:14:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPC2U-0005Qm-Lk
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 13:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256Ab1EYLOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 07:14:05 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61815 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab1EYLOD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 07:14:03 -0400
Received: by gxk21 with SMTP id 21so3037130gxk.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pTIrU8kZUoTO8og7uockte31bsAQPpJjmA/RN1g/bhs=;
        b=goWubiYxblB3nS2FqJi/8W8cz74OpKH2HPMfYdZvC+O1I0XFZ08zczBP83Z8SmM4tA
         HwQeGSNk+L8Ocjseq0o1Atz42KaUdERRJye3ZTJlu/2jvGurHS0QgtUobZFBNoZaXRVb
         RxIgtzQtPiVJTHFif7H7HRQzZ+k6NBfd7j0UM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pu/JsRrilErIAzlyXV7OQv7TAWjyCN6sMMRY7y0qbeTdrDCM9q/v9hyWlBN3PL6zl4
         ZsjYztDM3/suRgB1JMWgxvIljsf9yKdy4FhObO1WoCOqqDiVbP5jLg77LSmOTbyEczw+
         AN8KCK1ES7zYDZYdJj+dovCkE+r1T0fxeG5aY=
Received: by 10.236.78.34 with SMTP id f22mr5950670yhe.428.1306322041985; Wed,
 25 May 2011 04:14:01 -0700 (PDT)
Received: by 10.236.208.134 with HTTP; Wed, 25 May 2011 04:14:01 -0700 (PDT)
In-Reply-To: <SNT124-W39164C74A457129811245DC4740@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174382>

On Wed, May 25, 2011 at 2:05 PM, Tim Mazid <timmazid@hotmail.com> wrote:
>
>> Date: Wed, 25 May 2011 12:40:48 +0300
>> From: elazarl@gmail.com
>> git log -v --grep= # results all commits that do NOT match pattern
>>
>> Is there a way invert the sense of matching?
>>
> I'm confused; do you want to find all the commits that do not match a
> pattern? Because you seem to have achieved that. If, on the other hand,
> you want the commits that DO match a pattern, then just leave out the
> "-v" option.
>
> What exactly are you trying to achieve?

Oops, let me be 100% clear about that, "git log -v
--grep==<pattern_not_to_match" is NOT WORKING currently. I just
presented a possible syntax.

$ git --version
git version 1.7.4.msysgit.0
$ git log -v --grep=Normalized
commit 88c7a82aaf240ed130c64c455c294e7af04d30f8
Author: Elazar <elazarl@gmail.com>
Date:   Mon May 16 10:40:21 2011 +0300

    Normalized Makfile so that it'll work by default. Include Makefile

see, it ignores the "-v", and include only commits with "Normalized" -
the ones I don't want to see.
