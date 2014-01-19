From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [Question] Usercase about git clone
Date: Sun, 19 Jan 2014 15:44:00 +0100
Message-ID: <CAP8UFD2w=UpMFXMsT58GbMVZWQ-yANjhL-VEitN4u-HJsttwDA@mail.gmail.com>
References: <C4261F36-897A-4131-B76C-2E370AFBA63C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	Wang Shilong <wangsl.fnst@cn.fujitsu.com>
To: Wang Shilong <wangshilong1991@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 15:44:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4tbx-0007uc-V2
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 15:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbaASOoD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Jan 2014 09:44:03 -0500
Received: from mail-vb0-f54.google.com ([209.85.212.54]:55874 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbaASOoC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jan 2014 09:44:02 -0500
Received: by mail-vb0-f54.google.com with SMTP id w20so2380654vbb.27
        for <git@vger.kernel.org>; Sun, 19 Jan 2014 06:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xbTy89nhejKynAgcQBa/7cGh7D4xEfsIWYuWgrywoPE=;
        b=EQzjquMedcx/3HSfK7o3LjC82L7APpw9+HwDVXJ1F7u9ypSFlAWUOYM0EL5Jwlx5nb
         E/hu5Q+x4F3NzXxDYok3ZNYUQEYO0JeEnAtyxz8wm532VYfB6Nm+tafN+B/EIAXs16HC
         UUFMEEa36MUVzHYhNlTty+6jI9wkNEGacirhCPAjDMKYmshMxX+MBOo0OTDbo8/kp/va
         4Zx7MghzgH61On/rMDoeZUMczqtpFvx6RgK5JQjxr6EkULHzITTndGtq0ln/85u3RphE
         LoYebmZ/UuRyWvgLHSB7UplkskB/05MNH/h2T/qTwn8dVTaX6YHEYG9TX8ugy7ygmYnx
         BlTA==
X-Received: by 10.52.89.173 with SMTP id bp13mr6111366vdb.5.1390142641020;
 Sun, 19 Jan 2014 06:44:01 -0800 (PST)
Received: by 10.59.7.2 with HTTP; Sun, 19 Jan 2014 06:44:00 -0800 (PST)
In-Reply-To: <C4261F36-897A-4131-B76C-2E370AFBA63C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240692>

Hi,

On Fri, Jan 17, 2014 at 4:53 PM, Wang Shilong <wangshilong1991@gmail.co=
m> wrote:
> Hello everyone,
>
> I have a question about command 'git clone'
> If i clone a repo from remote, and if i run command:
>
> # git remote show origin
>
> It will output origin's url, however, this is what i want,

Is it really what you want or not?

> i just want to clone
> codes, but keep everything else unchanged, for example branches and
> they url=85.

There are urls for remote not for branches.
Did you look at the --mirror option?
Do you want something like the mirror option but with a working directo=
ry?

> How can i implement such functions by 'git clone'=85.I think this is =
really
> helpful because i really don't want to reset my branches' url every o=
ne=85

Again there are no urls for branches.

Could you explain better what you would like exactly?

Best,
Christian.
