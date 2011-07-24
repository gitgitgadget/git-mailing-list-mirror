From: Thomas Adam <thomas@xteddy.org>
Subject: Re: Help using git I'm review process
Date: Sun, 24 Jul 2011 13:16:00 +0100
Message-ID: <CA+39Oz5OT_RjyGeQdKaFycHjwN6hzy+N6P6DDBAtSv3vTYo_4A@mail.gmail.com>
References: <245B4B40-CA0A-43F6-A3F0-85E50D75CB93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Mathew Benson <mathew.benson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 14:16:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkxbY-0005S7-Rq
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 14:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab1GXMQR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jul 2011 08:16:17 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52080 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab1GXMQP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2011 08:16:15 -0400
Received: by qyk9 with SMTP id 9so1998790qyk.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 05:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pTN2XzqqLIOtyEuy+P5beQInLY3xGr9ipVpykE3pIRU=;
        b=NCYkH6WKuCEnggr++MURMnF0mQcVCaKsfsRD2Fd94N5JTYHxLxW2bq0XuECyU8T27H
         cP+iL2ObuT7jma9zAHSV9pc/U+tytMLbsj+D8gi81Q2bEFLt91IBwsnELORMCQ3o5AKO
         L8b7XsOagHGL9byb4xH4qDl4w8Z00dHBNahNQ=
Received: by 10.229.37.71 with SMTP id w7mr2841619qcd.15.1311509775207; Sun,
 24 Jul 2011 05:16:15 -0700 (PDT)
Received: by 10.229.95.210 with HTTP; Sun, 24 Jul 2011 05:16:00 -0700 (PDT)
In-Reply-To: <245B4B40-CA0A-43F6-A3F0-85E50D75CB93@gmail.com>
X-Google-Sender-Auth: RZ8hKQhgafUnVgo1m7uofY7hC0c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177740>

On 24 July 2011 13:12, Mathew Benson <mathew.benson@gmail.com> wrote:
> I'm planning to use git for a work project, which requires tight cont=
rol of the peer review process. =C2=A0In previous jobs, the peer review=
 was a tedious manual process of creating PDF files, writing comments i=
n spreadsheets, and copying comments to the CM system. =C2=A0I want to =
use technology to my best advantage.
>
> Once a developer has completed all his changes in his development bra=
nch, what's the best way to get those files to the reviewers, without r=
equiring the author to stop work? =C2=A0First, I think I should create =
a tag in the developer branch. =C2=A0Each developer has a local reposit=
ory, and my review tool writes files directly in the work area. =C2=A0C=
an they just fetch, checkout a tag (don't know how to do that), commit =
changes, and push it back to the central repository? =C2=A0Is there a b=
etter workflow?--

This is what Gerrit is useful for.

-- Thomas Adam
