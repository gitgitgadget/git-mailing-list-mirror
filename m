From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/6] Another attempt to get the SVN exporter merged
Date: Thu, 10 Jun 2010 15:22:45 +0200
Message-ID: <AANLkTinw7j3MHQ_4Xw7axWWZUIWubJZSKrBCgKIzc2uN@mail.gmail.com>
References: <1276175389-6185-1-git-send-email-artagnon@gmail.com> 
	<AANLkTin3iQK7YHGgjxlAjtchu3ZpntjQHK7LkfxxJj6q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 15:23:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMhj5-0001XK-0I
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 15:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab0FJNXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 09:23:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51297 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab0FJNXH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 09:23:07 -0400
Received: by yxl31 with SMTP id 31so1360688yxl.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=T3D/WjrbGU/c0dPtKNidQ0WbZFf0/+DVKHp60HL7OEQ=;
        b=v5oEvktnTIBd3IWkhk81f3j3KhmMw6u6grOhwaNTNHwR2uZdOyQjsel3rhF4axy4Bi
         /+iqHOz1sGiM0TW4b4QFzfqHgb0gStXtKTjv57xVaKeRwDOiNbVsqCmaMo7ptwHLeCQ0
         vt3GVJ+xw4zigynbYgIqRW8awEqfq9MXUTKAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gr1PQu1gLFXquerCl6G5Z+x1JH6MvCctkQA7qPfql3uBe5kcjFn8f3znOMXzQwaeoR
         6j3fT9OP8zPzumUNJxPKOpFIGHbgWuEDxfGNOZHHULRmb+h1bUQgHv2TqQQ38ixx6u4y
         SfE1EuElZBJEcBbuIrNX0vfH6Npo7eXyADlkE=
Received: by 10.224.66.23 with SMTP id l23mr129354qai.346.1276176186644; Thu, 
	10 Jun 2010 06:23:06 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Thu, 10 Jun 2010 06:22:45 -0700 (PDT)
In-Reply-To: <AANLkTin3iQK7YHGgjxlAjtchu3ZpntjQHK7LkfxxJj6q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148873>

Hi =C3=86var,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I'd like to test this out but funneling patches into git-am with GMai=
l
> is a pain. Is it available in a public Git repository somewhere?

Thank you for bringing this up- I'm aware that others might be
interested as well. I've rolled out the patches from the 'git-merge'
branch, but you can test the independent project from the 'master'
branch which includes a Makefile and small manpage (courtesy Jonathan)
as well [1].

-- Ram

[1] http://github.com/artagnon/svn-dump-fast-export
