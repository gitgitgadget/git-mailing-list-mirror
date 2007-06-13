From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Wed, 13 Jun 2007 18:59:18 +0200
Message-ID: <8c5c35580706130959i7a2ac14dq723137d05ff14de1@mail.gmail.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	 <11814251322779-git-send-email-hjemli@gmail.com>
	 <20070613153611.GA11852@moooo.ath.cx>
	 <8c5c35580706130913j2d3095d1n649145ff540d1bec@mail.gmail.com>
	 <20070613163136.GA28101@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matthias Lederhofer" <matled@gmx.net>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 18:59:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyWBl-0002um-Qy
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 18:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758119AbXFMQ7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 12:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758076AbXFMQ7T
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 12:59:19 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:2409 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758115AbXFMQ7T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 12:59:19 -0400
Received: by wa-out-1112.google.com with SMTP id v27so321161wah
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 09:59:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jJauivPH24+jYDz0qHgclk9faxuiGhnqI1sH2h/MoVJeCiX57rGg/lmjoeXom/XLnauljp5xaFxjG1CyyhegGfx599jQttYLaWVjISS0eN65X3IEkcXmL7l39Y/yHvMwIn8sIyJdDzcB+5GYS0AbhiHMUIeIOVFztNyLThiBIvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PZ9PvlzfS7AD26UEQn+/9MykRUGPOkU7tlEXTIP46gebDSn5xMObHJRiVRlAn9TUowD+fO2LCTc3RrMq6hW+JBBPWuD/A+6DWvUJNEKexjxley6rKHKmy1w45ohBARDvVUw0AKOPbJ6coG4kF1r7shk0rhuKeKkX5mcvn243mo8=
Received: by 10.114.254.1 with SMTP id b1mr882262wai.1181753958347;
        Wed, 13 Jun 2007 09:59:18 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Wed, 13 Jun 2007 09:59:18 -0700 (PDT)
In-Reply-To: <20070613163136.GA28101@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50098>

On 6/13/07, Matthias Lederhofer <matled@gmx.net> wrote:
> Lars Hjemli <hjemli@gmail.com> wrote:
> > Could you please try one or both of the following escape-sequences?
> >
> > \.gitmodules
> > #.gitmodules#
>
> #.gitmodules# seems to produce a good xml file, html is fine too.  But
> the conversion from xml to a manpage seems to be broken:
>
>     $ xmlto -m callouts.xsl man gitmodules.xml
>
> transforms
>
>     <refsynopsisdiv>
>     <simpara>.gitmodules</simpara>
>
>     </refsynopsisdiv>
>
> to
>
>     .SH "SYNOPSIS"
>     .gitmodules
>
> ".gitmodules" is not shown in the manpage and vim highlights the ".gi"
> just like ".SH" in a special color.  Perhaps we should just highlight
> .gitmodules like commands with single quotes.  This solves both
> problems :)
>

Ok, thanks for trying to clean up my mess. I guess there's a good
reason why Junios examples drop the leading dot (cat
/usr/share/man/man1/git-submodule.1 was an eyeopener for me right now
;-)

-- 
larsh
