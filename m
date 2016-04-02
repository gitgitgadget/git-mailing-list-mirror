From: Todd Zullinger <tmz@pobox.com>
Subject: Re: git 2.8.0 tarball rpmbuild error
Date: Sat, 2 Apr 2016 12:16:36 -0400
Message-ID: <20160402161636.GD13271@zaya.teonanacatl.net>
References: <CAHHSH-JrPiXnkdpU0cP6KE46hUr3-ZiSjW5FDMpV2HGmSou8kA@mail.gmail.com>
 <CAFZEwPPQPsk3ERu-h5qk+VZ=f3Ta4oPwgHN=5hTuVH5wxeiPGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?44Oe44OD44OB44On44Kz5aSq6YOO?= <mebius1080p@gmail.com>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 18:16:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amOE8-0006b2-MA
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 18:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbcDBQQl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Apr 2016 12:16:41 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:32788 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbcDBQQk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 12:16:40 -0400
Received: by mail-qg0-f43.google.com with SMTP id j35so119304733qge.0
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Qm1dCE8LTtYml/f1mnMz4VxuX6aqV9nec4SD4rTGAVo=;
        b=KSSW7IpnYh/CTMUAIzl10L2nBGBs2p+4opXoAwE9rbq1iT19Crt6djyMbW1zDGAf/V
         Q2OWk5ynXab0yrq0lU3JP8nHrUcR2p0IegjFWvfw6Nnam3sDa1Mrzhyk92CTSeISDVjQ
         dbRDUDQVI7ol+r26O6VSgyO1DnZLqZybyJSJTNmB5ocOCx5TefHghUaCl0NAmK+JBIzc
         dBskGpAxichHuIGHg64mZGdmqBA5MEvrz4F7Bbg4rQfFiJTL/qjmNAo7GKusBoLDKnZd
         OEuEWZwiokV18E3Ksgog6fJe/DkULEQVlNT5loOnaVIwsl/KwJigvdGAHOC1bNms9OJ6
         Q0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Qm1dCE8LTtYml/f1mnMz4VxuX6aqV9nec4SD4rTGAVo=;
        b=JzJNxXbi+7LIgR7tf0M6h42VL+Asijqkg8+lilrsgbwqcUlJ0WjSd/SRgU5EnWw3ot
         IdRgzZMwzXLEaQdvSWxmMNxq4DeJxptwLBJccwguVMG15bBF8yxkk1iNPs/n/ehdvML8
         EziPqrRTl7fvrPphlPJeHlvxrFayylpg3hDQcK6C1hDF1AyLDG93KYxXrzmVpcUsrh5q
         7ww14uj4JU5lf9V05mzosQHUIe0TBrqkUJYZuQR8S17Tq4tc8ZHSiDdy4ekB+5pgJU7z
         qUQM58U4QPILAk+YZtE6lNgBMs4V1fG5Mghbbj6uTBxanUG7tyZNtzcVisorqmwYiL97
         7C2g==
X-Gm-Message-State: AD7BkJKNiyfDr+HfFwhCGpm6orfh43pcbQv880jazG1HIVn9KRu74A+VrawBKNb22w1NFg==
X-Received: by 10.140.222.136 with SMTP id s130mr3844876qhb.62.1459613799526;
        Sat, 02 Apr 2016 09:16:39 -0700 (PDT)
Received: from zaya.teonanacatl.net (zaya.teonanacatl.net. [2001:470:5:873:862b:2bff:fe5e:698b])
        by smtp.gmail.com with ESMTPSA id a189sm8487399qhd.33.2016.04.02.09.16.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 09:16:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFZEwPPQPsk3ERu-h5qk+VZ=f3Ta4oPwgHN=5hTuVH5wxeiPGQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290594>

Pranit Bauva wrote:
> On Sat, Apr 2, 2016 at 9:18 PM, =E3=83=9E=E3=83=83=E3=83=81=E3=83=A7=E3=
=82=B3=E5=A4=AA=E9=83=8E <mebius1080p@gmail.com> wrote:
>> hi=20
>> I downloaded tarball (tar.gz) from git web site and tried to make rp=
m file.=20
>> But, when I run command "$rpmbuild -tb --clean git-2.8.0.tar.gz",=20
>> error message is displayed and rpm file creation stopped.=20
>> The error message is looks like this:
>> cp -pr README ~/rpmbuild/BUILDROOT/git-2.8.0-1.el7.centos.x86_64/usr=
/share/doc/git-2.8.0=20
>> cp: cannot stat 'README': No such file or directory
>>
>> It looks like README file does not exist on expected directory.
>>
>> Im using Centos 7.2.=20
>> I hope this bug will fix soon.=20
>> thank you
>
> Actually this bug was identified a few days ago and a patch has also=20
> been sent by Matthieu Moy. Thanks for reporting!

D'oh, I didn't notice this had been reported already and a patch=20
provided.

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Sometimes I wonder whether the world is being run by smart people who
are putting us on or by imbeciles who really mean it.
    -- Mark Twain
