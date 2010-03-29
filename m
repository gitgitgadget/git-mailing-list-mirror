From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH] Write new giturl(7) manpage
Date: Tue, 30 Mar 2010 01:05:06 +0530
Message-ID: <f3271551003291235p690dc200mfff119270768d873@mail.gmail.com>
References: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com> 
	<20100329191832.GA26842@progeny.tock> <f3271551003291224s7fb0d8d3sce75b7c893fabfa8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 21:35:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwKkH-0006bq-R1
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 21:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012Ab0C2Tf2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 15:35:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52613 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab0C2Tf1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 15:35:27 -0400
Received: by gwaa18 with SMTP id a18so4245991gwa.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 12:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qh6YeUnZhtPnLd0zTYpcXcfuxWfAfwdSOA6BXmpdivI=;
        b=SAFxzbm7UGbYCvM3kE0x6I5F7Zv721QiJIkB2HdE+8mxzA9rPnmEnEClgzbOmIKd6B
         2JqdcOmWT4mfBpGeC34JwUbwjNkW0SpQIpHxiV76HYtQadf4YxS3a8siNVhQTuYZemY4
         Z3QnlpkHFcwkK6BXw3Ezf1v1c+YB4m7DhYnoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Zr4zqlhjDDDCNanu4cBqlVQV35/FrYepduK0iXWuqsrfIb497Xofci4PgJcqLC4Yzp
         2WIRiCWXPS4IGVUyMl3zbLWOTMpr8zP3+3skw5j8AAUb7bL0N83CX0cFJB6lFEITPVLi
         4/GK98pzfuLZzT92Iod0Pr9SZPLzFlxnFpD0c=
Received: by 10.90.69.14 with HTTP; Mon, 29 Mar 2010 12:35:06 -0700 (PDT)
In-Reply-To: <f3271551003291224s7fb0d8d3sce75b7c893fabfa8@mail.gmail.com>
Received: by 10.90.17.23 with SMTP id 23mr960022agq.82.1269891326416; Mon, 29 
	Mar 2010 12:35:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143511>

> On Tue, Mar 30, 2010 at 12:48 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
> I suppose you are right. =A0I was imagining something like this:

My only concern is that it shouldn't duplicate too much of the
information in urls.txt. Also, it'll be nice if it's consistent with
the new urls.txt after my patch [1].

-- Ram

[1] http://thread.gmane.org/gmane.comp.version-control.git/143499
