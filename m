From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: git 2.8.0 tarball rpmbuild error
Date: Sat, 2 Apr 2016 21:31:39 +0530
Message-ID: <CAFZEwPPQPsk3ERu-h5qk+VZ=f3Ta4oPwgHN=5hTuVH5wxeiPGQ@mail.gmail.com>
References: <CAHHSH-JrPiXnkdpU0cP6KE46hUr3-ZiSjW5FDMpV2HGmSou8kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?44Oe44OD44OB44On44Kz5aSq6YOO?= <mebius1080p@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 18:01:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amNzd-0007Mx-NJ
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 18:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbcDBQBl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Apr 2016 12:01:41 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:32830 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbcDBQBk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Apr 2016 12:01:40 -0400
Received: by mail-yw0-f175.google.com with SMTP id t10so19155472ywa.0
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=k/KiOifz5jlvS6NE2hm6aL4jAxlcrsSbTl7kjDVMPHU=;
        b=CbINQ8wUhYGrdjL68VL3beabfL6c2x88gC8rKleU2fR3j8R6l72zx/sjrSHAoD90AM
         TxWwE2d7iJTYwbkBIi9pw6Dl+wMaHNlnrB6xPbYVZlXlBvvj41drfZt6iJs+5eBlm+E0
         x1WeDjIbCgYydHQkZ24EI1D8DCKpBMIyDZpjtUCBA6lL0XynUP6HoYbUS5nrj8e47Vek
         uAAdguRdajZHOHOxr+6krxftb3TYABTQh8BOTMRGme4TAuUV2me5FoztZAb5cAg+4qg4
         zhzSUJll+Ulg5uEk8cUCC5EqvxWYIXo5C4qGqm0Y1vVKpYtSCu/FzeuPX2xsHJN7UOi8
         gPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=k/KiOifz5jlvS6NE2hm6aL4jAxlcrsSbTl7kjDVMPHU=;
        b=lsrrevE2cSN7jr5VvuAPGYYNHRHLhwEFSE3kRIEmcyaoTCR2Nlix+UsSKnmU9n/Zc1
         HhBtxMxPUXEJ6nSVvFsH+8MPljyX7zR0mP+SskDMaP72dkmdEM88BMuDoEM2YAIbb18w
         UgKnzlvT5Kzq/1nZtMdEFUcEBLl7uP4YlhgoZj8p+b7TDl4mVrWUxllapGudHInmyOUe
         VvbOVf4Dl5VQdjO4YWN83vfHtrLBKZWjNC5cFD8xNIFUvgh+/DptmFP/rnE5xzd/Ocif
         E2bdLtyQnhkBbU1SzakM0awwpplzdLqy6FYyfomwDS7gL3T0Nab8mpSRi4lLasQ1sA56
         dW/Q==
X-Gm-Message-State: AD7BkJKrMH7+Byc8+uvLud6HVDkNsVTmwCbU8SQzpnWdXoNoflJddASKJhvx3MtpjFM6X/eiEgtKapVhMWf50w==
X-Received: by 10.37.104.10 with SMTP id d10mr10322866ybc.7.1459612899886;
 Sat, 02 Apr 2016 09:01:39 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Sat, 2 Apr 2016 09:01:39 -0700 (PDT)
In-Reply-To: <CAHHSH-JrPiXnkdpU0cP6KE46hUr3-ZiSjW5FDMpV2HGmSou8kA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290592>

On Sat, Apr 2, 2016 at 9:18 PM, =E3=83=9E=E3=83=83=E3=83=81=E3=83=A7=E3=
=82=B3=E5=A4=AA=E9=83=8E <mebius1080p@gmail.com> wrote:
> hi
> I downloaded tarball (tar.gz) from git web site and tried to make rpm=
 file.
> But, when I run command "$rpmbuild -tb --clean git-2.8.0.tar.gz",
> error message is displayed and rpm file creation stopped.
> The error message is looks like this:
> cp -pr README ~/rpmbuild/BUILDROOT/git-2.8.0-1.el7.centos.x86_64/usr/=
share/doc/git-2.8.0
> cp: cannot stat 'README': No such file or directory
>
> It looks like README file does not exist on expected directory.
>
> Im using Centos 7.2.
> I hope this bug will fix soon.
> thank you

Actually this bug was identified a few days ago and a patch has also
been sent by Matthieu Moy. Thanks for reporting!
