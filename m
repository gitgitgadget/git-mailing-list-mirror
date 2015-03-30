From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 99 new messages
Date: Mon, 30 Mar 2015 19:13:25 +0200
Message-ID: <CAN0XMOJyU+03A1bTdgVc10PLgkg9HjH51zt19oC7A-cARxcmgg@mail.gmail.com>
References: <1427571482-7508-1-git-send-email-ralf.thielow@gmail.com>
	<55181ED4.7020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	=?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
To: Phillip Sz <phillip.szelat@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 19:13:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcdFk-0007N5-4b
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 19:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbbC3RN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 13:13:27 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38182 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbbC3RN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 13:13:26 -0400
Received: by wibgn9 with SMTP id gn9so139329330wib.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Wnhc3GnsH6IsDautHAj/x/oJsVXy9e317QWapc7nZD0=;
        b=MPFwhXQsM0GyOR5Lh2/SnJAdw9z8Wnb5ZTxN6Zqeao1jhFkqQu+9hFOPHwKOm/mFb1
         P1HCc57U8jqiuXrEUfyOk13e1QTJJ+195Tr1Q2AnRFXwbs/F8KRaDd7CKzkNTORlrEzF
         slM7ow/top13iloiy9y78db1sGuqVep7O5lLcVCE8Kmu1WpFWfmcMuV3cPsTePucYbrg
         rQurD3rW8KgEpX5gkt5OI90HHtoKk56n3kH59WximUHYbGLYdcJz7DxBHtQZ+ypeHaSo
         F0qEuRQz82dzLUwFsRqsnzcK7O7JpP084rW+9e7NnONeIdosiAb7A1PnvD8hpHzyUIBD
         3VEg==
X-Received: by 10.180.104.7 with SMTP id ga7mr23638948wib.37.1427735605850;
 Mon, 30 Mar 2015 10:13:25 -0700 (PDT)
Received: by 10.194.72.5 with HTTP; Mon, 30 Mar 2015 10:13:25 -0700 (PDT)
In-Reply-To: <55181ED4.7020805@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266457>

Hi,

2015-03-29 17:48 GMT+02:00 Phillip Sz <phillip.szelat@gmail.com>:
> Hi,
>
>>  #: builtin/apply.c:3238
>> -#, fuzzy, c-format
>> +#, c-format
>>  msgid "reading from '%s' beyond a symbolic link"
>> -msgstr "Pfadspezifikation '%s' ist hinter einem symbolischen Verweis"
>> +msgstr "Lese von '%s' hinter einem symbolischen Verweis"
>
> "Lese von '%s', welches sich hinter einem symbolischen Verweis verbirgt"
>
> Maybe that's better?
> Also I'm not so sure what this string should actually mean.
>

If I read the code correctly, this is an error message that appears when
someone tries to apply a patch that modifies a file with the leading directory
being a symlink.

What about skipping the "read" part (because it's an implementation detail)
and translate it as
"'%s' ist hinter einem symbolischen Verweis"
to match other similar messages?

Ralf
