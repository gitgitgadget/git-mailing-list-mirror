From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git-svn troubles with calendarserver SVN repo
Date: Mon, 2 Dec 2013 16:31:20 +0530
Message-ID: <CALkWK0mPHzKfzFKKpZkfAus3YVC9NFYDbFnt+5JQYVKipk3bQQ@mail.gmail.com>
References: <52991FE0.6040503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@redhat.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 12:02:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnRGR-0007H3-5i
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 12:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab3LBLCE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 06:02:04 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:43118 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab3LBLCB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Dec 2013 06:02:01 -0500
Received: by mail-ie0-f181.google.com with SMTP id e14so20843049iej.12
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 03:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WvvPc+nCPQgmSJySFO0gQpH5NZRC56p8wUJw5TRev0c=;
        b=onzocbADJYLP8XlUyKsld6WNjdSBErRX3uBUd47jP4mbz1gfkAXhRcWBPpr0BxtlIb
         YfNnQntiiJOFNb5UOk3f9NZGmN2zwa6xMZyfnfAssWyt1BbOE+TFSG4l91TsC3nBjKAM
         ySSoUjdu/w34HTPq08oLR23hcePMtspKO3KngxgrRgrqj3ZisK+vymBA1SrKCek9uF8r
         F6i8M+rgAvBTrbEAluFErEQIqcF9mha5CaLJ8CGwbxwzrlwKlI18pvVRM5gI/fyBTQo5
         Q9xtNOaJEpHtLeHpqPfTYTryfyCbwkecJ3wa/f2XoOcZFPpyBSvHwFfftbVKFrE8bfTh
         0b/A==
X-Received: by 10.42.61.147 with SMTP id u19mr26726262ich.36.1385982120776;
 Mon, 02 Dec 2013 03:02:00 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Mon, 2 Dec 2013 03:01:20 -0800 (PST)
In-Reply-To: <52991FE0.6040503@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238625>

Mat=C4=9Bj Cepl wrote:
> I am trying to git-svn clone
> https://svn.calendarserver.org/repository/calendarserver/CalendarServ=
er/
> and I cannot say I am much succesful.

Consider using (the somewhat experimental) git-remote-testsvn and the
underlying contrib/svn-fe/. For starters, try:

  $ git clone testsvn::https://svn.calendarserver.org/repository/calend=
arserver/CalendarServer/

You might need to hack a bit to get it working properly, but you'll
find that it's much faster than git-svn in the long-run.
