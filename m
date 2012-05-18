From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] send-email: support coloring dry-run output
Date: Fri, 18 May 2012 11:26:57 +0700
Message-ID: <CACsJy8D=O81cFu0X1g7J++bBaadObkfJ2rsV_WUfDpVrEYotTA@mail.gmail.com>
References: <1337260596-15498-1-git-send-email-pclouds@gmail.com> <CAOBOgRaEnFOJ9=ZHczAq_TNerrrMciG8g0SHYDiKrqfhASU-iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Angus Hammond <angusgh@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 06:27:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVEmr-0001I0-FW
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 06:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065Ab2ERE13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 00:27:29 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58088 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab2ERE12 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 00:27:28 -0400
Received: by wgbdr13 with SMTP id dr13so2384359wgb.1
        for <git@vger.kernel.org>; Thu, 17 May 2012 21:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RjlJ2UwQ5/MyWOQNJZToE44E8QZC/J+KYPh0PlSNpXc=;
        b=ktSfRjwx62Gv6xyMxHkeT+bJfat5xm/0dghhCVOJ7WTqO6P5WoItXKrEoXTOXILDYu
         bbgc1LKMfAW8QpdrRamoqBb5pYM9zdU9UmZI82gnRcS6rX7qwHXMj9D9WfiTZE8AfhDL
         38C9uON21jc7X9hyWvwgEuoKDvc7Qu4K0HMXiqTssUpYg0wDO97+cWFx0eYlYM99vRc1
         ApjC7FrxfIZTuc3jWzpFoploD78JQW2T2pgSzjMBqxseLh5Wd9Jdmv7k70KF7xyCr4EY
         K1zUhnpZokEUUJW0NWIdjN1RtbvUb/DwPGEIN6g3G0DgX5bdGC87+y102zYri3MeFYgL
         SYkA==
Received: by 10.216.142.200 with SMTP id i50mr6308235wej.47.1337315247311;
 Thu, 17 May 2012 21:27:27 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Thu, 17 May 2012 21:26:57 -0700 (PDT)
In-Reply-To: <CAOBOgRaEnFOJ9=ZHczAq_TNerrrMciG8g0SHYDiKrqfhASU-iA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197937>

On Thu, May 17, 2012 at 9:27 PM, Angus Hammond <angusgh@gmail.com> wrote:
> This seems like it would be a useful patch for those of us using sendmail.
> I'll admit I don't know any perl at all, but one bit seems a little
> odd to me. Is there a reason you use 3 separate print statements to
> deal with the colours on the Sendmail line, but a regex substitution
> the second time? I have no idea which would be considered the better
> practice but surely we should pick one and be consistent? Unless
> there's some difference between the two that I'm missing.

No reasons. It was what I had in mind at that time and it worked, so I
did not bother cleaning up or anything.
-- 
Duy
