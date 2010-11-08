From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: first para of man gitignore should refer to 'git rm --cached'
Date: Mon, 8 Nov 2010 10:16:20 +0530
Message-ID: <AANLkTinznLY3M4z7k-WeeFhGSR1xWHXj_zOrwMvZDfLQ@mail.gmail.com>
References: <AANLkTim=QCcJDb0600Je-jePvXSXfFMe7FAQ0WMhZKn7@mail.gmail.com>
	<20101107191425.GA32302@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 05:46:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFJcr-0003Ef-4P
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 05:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198Ab0KHEqW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Nov 2010 23:46:22 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61319 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0KHEqV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Nov 2010 23:46:21 -0500
Received: by ywc21 with SMTP id 21so3090651ywc.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 20:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ys7QLILmeHiR31SsdMsH1qViaqG+SlEA+/S3Rtf6w2U=;
        b=n1tpfhd24il9L/IsSE1y/xAZsrhXOj5xQCHwKeqZljGH9rEEFNrvMmNq2zq7usZiy1
         4H/VBz51sWDxlwrjkVq/J7Lo4jmZEqmvftQMfdePxaAngayQ/WK7qvtxf3xJL3wuQoLN
         Himso6YVDy0UNpCD7UTZY4tWLfhSKbvcBSuo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X2ZD9nsfq8lbB+1sYtOaz47MH3CI6m3ivtexy/vGcFL9si60IW7QFF2Gb1EnixKfUG
         zAkxHRQ/j5K9q5GZlMucIG2zyPLM5huXE3sQIJ+twCnw9y6BuqinRofIHyy1Dny6MF8b
         N0YYnR6y33kbpor8MfwuVQUvIIqYs6QJwRGeg=
Received: by 10.90.26.11 with SMTP id 11mr4650426agz.174.1289191580968; Sun,
 07 Nov 2010 20:46:20 -0800 (PST)
Received: by 10.90.52.8 with HTTP; Sun, 7 Nov 2010 20:46:20 -0800 (PST)
In-Reply-To: <20101107191425.GA32302@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160909>

On Mon, Nov 8, 2010 at 12:44 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Hi Sitaram,
>
> Sitaram Chamarty writes:
>> It's an FAQ that "why doesn't my gitignore work" when the files in
>> question had already been added earlier, usually in error. =C2=A0The=
 most
>> common remedy, I believe, is "git rm --cached" followed by a commit.
>
> Er, no. The documentation says "in order to ignore uncommitted change=
s
> in already tracked files". `git rm --cached` removes the file from th=
e
> index altogether- when the change is committed, Git will actually sto=
p
> tracking it.

I agree.

I'm just saying that ignoring uncommitted changes to already tracked
files is *not* the most common question I see when it comes to
gitignore, and am asking if it is worth putting what I believe is the
real FAQ in the first para, and move the assume-unchanged stuff
further down the page.

Sorry if I didn't say that clearly enough before.
