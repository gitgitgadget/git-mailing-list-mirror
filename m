From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t2203: fix wrong commit command
Date: Wed, 11 Jan 2012 09:51:10 +0530
Message-ID: <CALkWK0kDBFvssyX2ZPJ9WNzfNXD=wEJoXTRVpFWm1TDKJrvNzA@mail.gmail.com>
References: <1326252098-2891-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 05:21:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkpgv-0007Px-Kj
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 05:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584Ab2AKEVd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 23:21:33 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33340 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932516Ab2AKEVc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 23:21:32 -0500
Received: by wibhm14 with SMTP id hm14so71611wib.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 20:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KJL6CJELaAz1cfaL7z3FlKU0m5q76XQGRFFsLx9YR7Q=;
        b=ewufDuQp/z8RMhhrSes+xBkeo1lfqyuPZlM+yO+oQQVo8xZRJikipFxadb62dmkV0o
         LAAraU/ZrUIWHUFfe9PEmVCZ3SbyVeksOCbCQt8NZ5mCnTjscbdLF9Z/oXy1s5AEwe/0
         wf3KA7rZIjZ+B8QsmoA8UcK3Qw6Yx0mWBiVzE=
Received: by 10.180.77.200 with SMTP id u8mr16685905wiw.18.1326255691233; Tue,
 10 Jan 2012 20:21:31 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Tue, 10 Jan 2012 20:21:10 -0800 (PST)
In-Reply-To: <1326252098-2891-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188324>

Hi Duy,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> Add commit message to avoid commit's aborting due to the lack of
> commit message, not because there are INTENT_TO_ADD entries in index.

Is there any way to differentiate between the two kinds of errors, so
that we can avoid this in the future?  Can we grep the error message
for something, or inspect the exit status?

-- Ram
