From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: remove duplicate code and not needed break statement
Date: Sun, 18 Jul 2010 20:56:33 +0200
Message-ID: <AANLkTilU1T5ppfVZ5UXpsRXet0tcffjJ2Bi3q67wnF6L@mail.gmail.com>
References: <1279475399-6081-1-git-send-email-ralf.thielow@googlemail.com>
	<20100718184716.GD14367@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 20:56:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaZ2W-0004Fd-PM
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 20:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757122Ab0GRS4g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 14:56:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38877 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757101Ab0GRS4f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 14:56:35 -0400
Received: by wyb42 with SMTP id 42so3697559wyb.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9UTRlcYhopn598Wpi8PHfovuNcxd/V4LfofGaGDObQw=;
        b=V8sXEtaROLqWiq+lpKrlX1to/y42F1CNzpdmYnAnJwPK7gPJjZ+4oAIwLwAFJ6A/D7
         24rQANmOpwudAcExYPux2YiTKWImFFdhnPCJPEDcCgLwxUyVMp5uy4E+uTcAQ02Esg98
         WcSpezhfCVEgIvk9XlB6q+S3oMY0sDD4z3o90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a6PMwYsPuc4F5F0KzVykEZVyDR8qV3gYBo2Njieywu58hbGHQ+VYsTAYzQLxnyb8Qy
         tChdoo+pxGs1TVNQdrdy9gzfVop8O6cUoK+1ewSw0WfyUXl7QebhaWwZPpNr+YYxJwTB
         dH9CfAQrimfMRcRxTTSs9f/RZhaGmfk/KCtAo=
Received: by 10.216.187.142 with SMTP id y14mr2942421wem.45.1279479393967; 
	Sun, 18 Jul 2010 11:56:33 -0700 (PDT)
Received: by 10.216.91.11 with HTTP; Sun, 18 Jul 2010 11:56:33 -0700 (PDT)
In-Reply-To: <20100718184716.GD14367@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151239>

2010/7/18 Jonathan Nieder <jrnieder@gmail.com>:
> Hi Ralf!
>
> Ralf Thielow wrote:
>
>> Remove duplicate code and not needed break statement.
>
> This looks like a reasonable change, with the nice effect of getting
> read_pack_info_file() to almost fit in one screen.
>
> The commit message is not super clear. =C2=A0I would say:
>
> =C2=A0Subject: update-server-info: Shorten read_pack_info_file()
>
> =C2=A0The correct responses to a D and a T line in .git/objects/info/=
packs
> =C2=A0are the same, so combine their case arms. =C2=A0In both cases w=
e already
> =C2=A0=E2=80=98goto=E2=80=99 out of the switch so while at it, remove=
 a redundant =E2=80=98break=E2=80=99
> =C2=A0to avoid yet another line of code.
>
> i.e., impact in the subject line, details in the commit message body.
>
> It is missing a sign-off. =C2=A0See Documentation/SubmittingPatches f=
or
> what that means.
>
> Hope that helps,
> Jonathan
>

Thank you,
this is my first patch on a mailing list using git, you see.
In future I do it better and read the whole documentation
before. :)

Ralf
