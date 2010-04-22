From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC/PATCH] cvsexportcommit: per branch cvsdir config option
Date: Thu, 22 Apr 2010 21:49:37 +0200
Message-ID: <m2k36ca99e91004221249l3cfd5772wc1d381ca984b4179@mail.gmail.com>
References: <1271810562-4196-1-git-send-email-bert.wesarg@googlemail.com>
	 <201004210832.25810.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Trent Piepho <tpiepho@freescale.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 22:06:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O52fj-0003Rc-Pn
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 22:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758041Ab0DVUDf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 16:03:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:2519 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096Ab0DVUDb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 16:03:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so31194fgg.1
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7lp2ItB3ilTPXXbt0g7+uypiS6eHb4IBWnGW0aa5zI8=;
        b=n/ocWfShmf1obotYf8hqk4/bgSGEqKcvhqzYgNXeXC3XcWiSuvnYjL2Ivm59E/+8oF
         3ecv2+o0PmhIl1D4EMVJJHsFU13fSwZS0bnJGGcUxi8Xwqngd8wUKmvayScw0bNl8BeV
         leh00FrHfQbUvJjBS0rRi4TTCj7naHtxygjhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P8k8dnYs+4FJMpTEqiv0f7e/izwde8Ucfo5iouDuQiAwAEVXfWxqAkL/wJCucgZqs3
         NsrILrcJo8poeQENgS3TQd6N0FqM+m+etmGmyDGWFzU32H9pWrGIUrnHtn0wuUotju2A
         EuhNDWb+oGJn/Dw6aN8bC7QWf6p0rj3wlTsdY=
Received: by 10.223.111.7 with HTTP; Thu, 22 Apr 2010 12:49:37 -0700 (PDT)
In-Reply-To: <201004210832.25810.robin.rosenberg@dewire.com>
Received: by 10.223.143.20 with SMTP id s20mr344513fau.38.1271965777917; Thu, 
	22 Apr 2010 12:49:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145552>

On Wed, Apr 21, 2010 at 08:32, Robin Rosenberg
<robin.rosenberg@dewire.com> wrote:
> onsdagen den 21 april 2010 02.42.41 skrev =C2=A0Bert Wesarg:
>> This lets the user of git cvsexportcommit specify a cvs working dir =
on a
>> =C2=A0per branch basis.
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>
>> ---
>>
>> The config variable name is currently cvsexportcommit.<branch>.cvsdi=
r, but
>> could also be branch.<branch>.cvsdir. Or whatever is prefereable.
>
> Your suggested names are fine and the idea is sound.

Thanks. Can I take this as an Acked-by from you? Than I will send the
patch to Junio with an request for inclusion.

Bert

>
> -- robin
>
