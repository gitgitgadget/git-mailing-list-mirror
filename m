From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 2 new messages
Date: Fri, 7 Sep 2012 18:36:55 +0200
Message-ID: <CAN0XMOL+2RV3wxp0nCAJzBBVF2vRNsK6H=MFYEqvKTw+nkcuXw@mail.gmail.com>
References: <1346865100-10908-1-git-send-email-ralf.thielow@gmail.com>
	<CANYiYbFBoK7D+9oZ2YGsrHYafOETLRUWUmHzfnAyA7RRhqgEkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>, trast@student.ethz.ch,
	jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 18:37:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA1YK-0003Mk-A3
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 18:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469Ab2IGQg7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Sep 2012 12:36:59 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53205 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab2IGQg4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2012 12:36:56 -0400
Received: by wibhr14 with SMTP id hr14so2998186wib.1
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 09:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+cikyq6etefFXSzTqNE8O0utBhuSl2eOB2qanJsccMk=;
        b=Ehr3i3Hi4QCEGKusuR7cpraOzjB9gJ2ujJ4y7dH2tGV7yyt2eKwf90mfLw+G7eCfcI
         vx5jiNUCQot2cezLenHWs5UDoczhECHZ56UnlPMphjvPwYEbQ2GL6A7jvesuBQT8zYT2
         lu4ywObe2HV9l3RysHtBiDaw5UUk/mDxFQ9gZ8ya04VzXsVSD5wtpxf4COYDibhNXeD7
         odcZsRSCxX5YFQpkxpTfBn/CMB5VTYUFq3PSMKvd+lk0fBkoOZZoWPM0iTpICmtUYAxp
         u8yqVRD/wjqP+S8z0AT2Efnuuox1w8xxQIyU2eesdWPtHVUzQg6V/L3AQltPr/FeXk49
         e0gA==
Received: by 10.180.84.169 with SMTP id a9mr13429570wiz.8.1347035815075; Fri,
 07 Sep 2012 09:36:55 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Fri, 7 Sep 2012 09:36:55 -0700 (PDT)
In-Reply-To: <CANYiYbFBoK7D+9oZ2YGsrHYafOETLRUWUmHzfnAyA7RRhqgEkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204973>

On Fri, Sep 7, 2012 at 12:31 PM, Jiang Xin <worldhello.net@gmail.com> w=
rote:
> I just notice that the 1st line of the orignal message below has
> only 56  characters, much shorter than other lines. It is because
> this is a warning message, and would add a prefix: "warning: ".
>
> #: builtin/push.c:151
> msgid ""
> "push.default is unset; its implicit value is changing in\n"
> "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
> "and maintain the current behavior after the default changes, use:\n"
> "\n"
> "  git config --global push.default matching\n"
>
> For this reason, translations as follows are not well-formed.
> So I rewind git-po, and your commits may need a bit amend.
>

I admit that I don't really understand what you mean. I can't
see a big difference in line lengths. It's not more than others
have.
Do you mean that the first line just lacks of a "warning: "
part? In this case, the message needs to get fixed.
Imagine that this line starts with "warning: ", the updated
German translation would looks like this:

msgstr ""
"Warnung: 'push.default' ist nicht gesetzt; der implizit gesetzte Wert =
wird\n"
"in Git 2.0 von 'matching' nach 'simple' ge=C3=A4ndert. Um diese Meldun=
g zu\n"
"unterdr=C3=BCcken und das aktuelle Verhalten nach =C3=84nderung des St=
andardwertes\n"
"beizubehalten, benutze:"
[...]

I'll send you another pull request contains this update.
