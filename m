From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: [GSoC] Proposal
Date: Fri, 25 Mar 2016 11:45:24 +0800
Message-ID: <CAKqreuwbGC1=42V2ZnTj53z76sgGcqfzjjrD7SP2AeuHJo9etQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 04:45:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajIgl-0001QH-Jc
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 04:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbcCYDpZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 23:45:25 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36552 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcCYDpZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 23:45:25 -0400
Received: by mail-ob0-f169.google.com with SMTP id m7so51583263obh.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 20:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=/TcvLpjLWQ2iF+TA+bCDN0qeHNieLddWAnHz1+kexPA=;
        b=EBbnxqS3pKAcPfJMsKAemQJ0zEM+6wyRetMTEEy4dUwlp3BwphIDrIaV5pemsFNtQ7
         x450OKbprA2Yrp0+Onzbw+7uxq1TgDwtKyojBYPDLdWjGf0MAo020hnvoMSs0czFU6mD
         cWsNP8wWquKLF9NkJK4ZfxJNgPFMV0SAjGGX3Oa41E8dzyECKu9AI1Z3hqRMlXlDHpKi
         VoKl6MLEQkIi4r+Im/D5gQMKhEqMPSz3XP0lfrnzzcG+DxvL+SOWTUkrbJHBjshu3EGk
         iovomufI7bgbsPodVZrFDJrDiFRjtsp20Yhd6lnGN874LfnPP0+GPRgDtJfLuG0kyvCz
         AlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=/TcvLpjLWQ2iF+TA+bCDN0qeHNieLddWAnHz1+kexPA=;
        b=dIzzZ0qtqlSUTUStEPhY3ieagkFeFbCB49sVWDLH7JfvY1U3E3E7f6USWrO9JoL4uS
         AnIdaex7ZBRV8vaA2NVZmYPMs0Fefm6zD4vyI42XbTxO4mKoYuDKGB71M2CbIZfFc/b3
         odlJxZYfAv2bdpo53cHgeRbkmIbL83sSa/WrgsfRFj2jc1hY8d7TS/pnVv5sA2Fa3Hyx
         cnkJ7rkSaV/zSWNup2Aq3vxVqdMCj/WvSo+fIxUWrirkAht2WDC5OIvnTlc2hIvewPec
         /zma4eXuShDPGAjTpYMVDuMLu9q7NdZRklxXabNW33M8umH3rfCm4R5LwcYvycIlrGXS
         DogA==
X-Gm-Message-State: AD7BkJIFAAElEKJ20AxXvsKFqrTqY6KvAe+8GYLuX2aOZuSXb9FutBOV6oMo0pnMGO2+clZceTwIERVb9RIXbw==
X-Received: by 10.60.150.163 with SMTP id uj3mr5971712oeb.67.1458877524399;
 Thu, 24 Mar 2016 20:45:24 -0700 (PDT)
Received: by 10.157.27.250 with HTTP; Thu, 24 Mar 2016 20:45:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289844>

Hi,

I'm proposing to take part in GSoC as a developer of git.

Here is my [Draft](https://docs.google.com/document/d/1zqOVb_cnYcaix48e=
p1KNPeLpRHvNKA26kNXc78yjhMg/edit?usp=3Dsharing).

I'm planning to refactor some part of git. Following is what I'm intere=
sted in:

- port parts of =E2=80=9Cgit rebase=E2=80=9D to a C helper
- =E2=80=9Cgit status=E2=80=9D during non-interactive rebase
- etc interesting during the development

If time allow, I'd like to also improve git-bisect, for example:

- convert =E2=80=9Cgit-bisect.sh=E2=80=9D to a builtin
- etc

Sorry for toooo late. I was so busy these days. sorry again.
