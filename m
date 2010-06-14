From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/6] Another attempt to get the SVN exporter merged
Date: Mon, 14 Jun 2010 16:41:16 +0200
Message-ID: <AANLkTim2qNNrInovraveWGcgr61FnrRzQXjuW_AsmiLc@mail.gmail.com>
References: <1276175389-6185-1-git-send-email-artagnon@gmail.com> 
	<20100612062613.GA2549@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 16:41:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOArB-0001IQ-Hh
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 16:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429Ab0FNOli convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 10:41:38 -0400
Received: from mail-yw0-f204.google.com ([209.85.211.204]:33941 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496Ab0FNOlh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 10:41:37 -0400
Received: by ywh42 with SMTP id 42so3453079ywh.15
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QhDdPHHRxOkrw25iQy+Un9H/wfF9+8zBTLOrW1ahmiE=;
        b=L9z7LHKXy0KDKEJZ57lgxW4xtFU0fbZNMjgw4j9oynyhHNlrpj206rNyW7uEsJpbyt
         /EufGnR31Z0TAOklR6mBalWAUF8J2IdUOS2Gz6lfKNyfunD39VbRE0QtbsLVKC6RZneV
         /xcRbwRTSEO1r5CirCMAyfr+hF0Mtv0OT7aCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eA5smoR7QNh9kNGzKDnuMYCRJ6dUmNjgHL1F9IRuOpm0DciWwI8KNXnQx6Ao59xqcQ
         yVZjSEVmnFLvDT26dvT5xQuHHEUp3z8xD8VLDuzMNJqe+trUfx467KgIYG2aAv3L/w/k
         8xUg6BnyTq+7e+872mnYtmmczT0H0qr7+WwQg=
Received: by 10.224.27.150 with SMTP id i22mr2149981qac.183.1276526496835; 
	Mon, 14 Jun 2010 07:41:36 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 14 Jun 2010 07:41:16 -0700 (PDT)
In-Reply-To: <20100612062613.GA2549@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149095>

Hi Jonathan,

Jonathan Nieder wrote:
> First of all, thanks for your work on this and sorry to take so long
> to respond[1].

Ah that's alright. I'm glad you're up and running again :)

> I planned to write a series adding svn-fe to contrib/ and then the
> computer died. =C2=A0If someone else doesn=E2=80=99t do it first, hop=
efully I can
> try again this weekend.

=C3=86var has also been asking about this. I have a branch ready to rol=
l
out from- I think I can do it today.

> Sad but perhaps necessary. =C2=A0I guess this also opens the possibil=
ity of
> later making the save operation atomic with the fsync() + rename()
> trick.

Yeah, mmap looked a lot more elegant.

-- Ram
