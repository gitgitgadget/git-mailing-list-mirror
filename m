From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Re: [PATCH] Remove pdf target from Makefiles
Date: Tue, 18 Jun 2013 09:19:46 -0700
Message-ID: <20130618161946.GA2887@elie.Belkin>
References: <146574770.2154401.1371542391078.JavaMail.ngmail@webmail18.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:20:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoydX-00011m-9X
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933395Ab3FRQT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 12:19:57 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:62222 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933087Ab3FRQTz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 12:19:55 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl14so4167620pab.20
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Gnsh0dtWk8R0MXAn3BMEnYlLGrWn/ShcUvQBmd3X0WY=;
        b=JOOuxPSv1+7kb3FbWCKpsU5Cogdz7jC8OOsblTpgB/bUP4e3Wx4WGIWnohnaYkQSGd
         Fp/aRVsoh6Pd4WasDppv5KCP2bjwyXXgfdadLb36ZSHfaqGFx/dBt5801AXKAoYe76os
         321kZhIjd2nvw7ij7E8xw//hs+SG/Ju+Wncuq8yAjkGG5anWIOD2WSsKxWglhZa+y596
         8OFAYCETIj9/aE1d7dkdIZJXCdx4iDemX8Vg1UdQ2fQdb3PqncGmZimfaGH1wgizjhFv
         MkEUhwD8/mYdMTThsEyocg+DXfQ+0ZO5KNoE1oJPKlHKB6pDR3QRWb3CuQg3plRfiiY+
         dTLg==
X-Received: by 10.68.222.135 with SMTP id qm7mr7219288pbc.38.1371572395340;
        Tue, 18 Jun 2013 09:19:55 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id v20sm20343919paj.4.2013.06.18.09.19.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 09:19:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <146574770.2154401.1371542391078.JavaMail.ngmail@webmail18.arcor-online.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228262>

Thomas Ackermann wrote:

>>                                 Would generating different XML files
>> for the PDF and for other purposes (with different names) work as a
>> way to achieve that without losing the printable manual?
>
> This would be even worse when we have to create different xml depending on the
> wanted output. The problem here is in the xml->pdf/html step: I wanted to change
> the formatting of links in the pdf from "Section <number>" to "<section_name>" to
> make it the same as in the html. Thereby I noticed that the definition for this is
> in files from /etc/asciidoc/dblatex. So to change it we have to introduce our own files
> in ./Documentation and work on them to bring the formatting of user-manual.html
> and user-manual.pdf closer together.

Now I'm even more confused. ;-)

If I understood the original commit message correctly, you were saying
the XML file was not suitable for html generation and you wanted to
tweak it, and were dropping the PDF target to avoid breaking it.  Now
if I understand correctly you are saying the XML file actually *is*
suitable for html generation, and that the html generation rules just
need tweaking.  In that case, why remove the PDF target?

Puzzled,
Jonathan
