From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: fix Gmail workaround
 advice
Date: Sun, 7 Feb 2010 15:54:28 -0600
Message-ID: <20100207215311.GA2177@progeny.tock>
References: <1265555642-40204-1-git-send-email-git@aaroncrane.co.uk>
 <7v8wb4gaef.fsf@alter.siamese.dyndns.org>
 <bc341e101002071203x52bceaach8d42c6188630f1d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	John Tapsell <johnflux@gmail.com>
To: Aaron Crane <git@aaroncrane.co.uk>
X-From: git-owner@vger.kernel.org Sun Feb 07 22:55:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeF5v-0005Z5-5B
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 22:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878Ab0BGVyi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 16:54:38 -0500
Received: from mail-iw0-f183.google.com ([209.85.223.183]:37017 "EHLO
	mail-iw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274Ab0BGVyh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 16:54:37 -0500
Received: by iwn13 with SMTP id 13so4202936iwn.25
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 13:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SMOMCKAbk+6y/YTxLoCglVP4q5yAvd8yiCX3MoX47l4=;
        b=VX+Rl9p51vld5gXv93WmT6YJZQ0VajgS9mLB2hFxZeU/+oyzSApkx5gTyVZrvjKOes
         o/ZqZCPg2U9jPc3YBPeTp7WBSSFNWOuFjF0Iy/mQr+GFHgpa+wXETpyrE/+FvwtctKmD
         0wd8Tf+HiGXvzvxSy3H4p/OKMv9XxRKobgMbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=o+TclV+JqES3Hj+/TW4TznGGF1xsjNN/Nfw0k/LlhXgtcI088qwpRPMw8Uiz1B/qvZ
         wbERy7OEi4gcmqqIChIYUVcnhA+IbpHSANgQUD/Jb37bCwHFU8MqakL2pbfIko3H65I3
         8dDigzWZQsHarFyHzqtJP8gxluUo2Kzt8SJsc=
Received: by 10.231.143.148 with SMTP id v20mr2425672ibu.14.1265579676879;
        Sun, 07 Feb 2010 13:54:36 -0800 (PST)
Received: from progeny.tock (wireless-205-208-124-228.uchicago.edu [205.208.124.228])
        by mx.google.com with ESMTPS id 23sm3753851iwn.11.2010.02.07.13.54.35
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 13:54:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <bc341e101002071203x52bceaach8d42c6188630f1d1@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139259>

Aaron Crane wrote:
> Junio C Hamano <gitster@pobox.com> wrote:

>> What I am trying to get at is to see if the current imap-send sugges=
tion
>> is fundamentally unworkable with gmail. =A0Perhaps they stopped supp=
orting
>> imap. =A0Perhaps the procedure never worked.
>
> As far as I can determine, the current imap-send suggestion is
> fundamentally unworkable with gmail at the moment.  I don't know
> whether it ever used to work, though I've been assuming that it did.

I think it still works, or depending on your perspective, it never did.
As John Tapsell wrote in SubmittingPatches (commit 50dffd4e, 2009-02-19=
):

| GMail does not appear to have any way to turn off line wrapping in th=
e web
| interface, so this will mangle any emails that you send.  You can how=
ever
| use any IMAP email client to connect to the google imap server, and f=
orward
| the emails through that.  Just make sure to disable line wrapping in =
that
| email client.  Alternatively, use "git send-email" instead.

I am not sure what that means about what SubmittingPatches should say:
should it explain both methods, then?

If I were doing it, I would put the information in the git-imap-send an=
d
git-send-mail man pages as examples.  That way, it would be visible for
people submitting patches to _other_ projects, too.  The section in
Documentation/SubmittingPatches could be replaced with a pointer.

Jonathan
