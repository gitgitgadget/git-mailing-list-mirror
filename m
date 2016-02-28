From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.8.0 round 1
Date: Sun, 28 Feb 2016 22:12:08 +0800
Message-ID: <CANYiYbHV_hpGoF9_6ng8eTfnzU+fHvyzZfSQncitGNVZZMfaxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Changwoo Ryu <cwryu@debian.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 15:12:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa251-0002MO-KQ
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 15:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757658AbcB1OMM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2016 09:12:12 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34354 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757527AbcB1OMK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Feb 2016 09:12:10 -0500
Received: by mail-wm0-f46.google.com with SMTP id p65so37960071wmp.1
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 06:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=8sz0AZ7KNDyiwYEpG6OVgUcL4KjpbE6InvDSZhj30EE=;
        b=XCzo2RUAfsZs52d49/dXn2RswZrC3/ryBnXWjRN82PLD7yOAGSm0XRP4LH0lC9b1AM
         +UNjeUFRQnbL7X8jcvNktc9p8Utc1ae1dVqZEhAshbuAYcxvw2VjMpLzXv1yC+BDjDFE
         NiPmEtJCGSS70p5Wl0+qk49Pzf+xIuf6LV+xgYUxquZQ686kImkxqvNbbuhyL/sekqSk
         LMyOkP6+sinDuqKl+bP8/kYMK8UdRL90KXlxYbIMBEo+PApQSxtr7sVJZ+nmSkMpEFqA
         Ox7RUyRAJ39gakwG65Jfn4SYNk3jg60JeSjIAvSB0pD2zcQQCDocARfBTd5lm2naT4b+
         y7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=8sz0AZ7KNDyiwYEpG6OVgUcL4KjpbE6InvDSZhj30EE=;
        b=AOdbBrwlRUWqhNTRHoRIvzBwK8MAYnOFDMHde/6pas/pxoytVcQhfTW54fbvVge3DW
         XaWhmiAT9wIyyN/muFEUMMj0RTSbMRuXuE12o5KXI3NXVzoa2PdTirfMdEjYkUOd/ZB2
         icqCTHQmhm+JSQa6FNS+55Rnmp7QcxMo0iZqISayUV0QIeWJu3MVpq7mzIBJ9Z+yPBKU
         wLmBqO+hUfzQkl5dBM7lYvatfTLGpxbnTEwIEoWe0lwJuevuaNkQ8T8K5KzHBSZjXdcI
         rMyt0uS55BarhEdjqHxt6RoAa7ECEYjRhAb+QO+979ZOCZ2qLbUqXSPx0q9i7gUDggoD
         IdtA==
X-Gm-Message-State: AD7BkJK5Vy5GHZgMR8nUztMB7RtDe8Mddp9T62x/NBw1omS2bNKOweA+yWG7lhNPYxYkH9kmdg/FyssLpOnltw==
X-Received: by 10.194.109.161 with SMTP id ht1mr989198wjb.43.1456668728792;
 Sun, 28 Feb 2016 06:12:08 -0800 (PST)
Received: by 10.194.54.8 with HTTP; Sun, 28 Feb 2016 06:12:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287774>

Hi guys,

Git v2.8.0-rc0 has been released, and it's time to start new round of g=
it l10n.
This time there are 48 updated messages need to be translated since las=
t
update:

    l10n: git.pot: v2.8.0 round 1 (48 new, 16 removed)

    Generate po/git.pot from v2.8.0-rc0 for git v2.8.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
