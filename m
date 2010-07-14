From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/9] Get svnrdump merged into git.git
Date: Tue, 13 Jul 2010 19:15:30 -0500
Message-ID: <20100714001530.GB2308@burratino>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
 <20100713235825.GC12639@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 02:16:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYpeB-0001tT-Cv
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 02:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab0GNAQS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jul 2010 20:16:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49474 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab0GNAQR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 20:16:17 -0400
Received: by iwn7 with SMTP id 7so6385379iwn.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 17:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZTNBNX4I6wJhCasUQVi4mzVvZnQ8Tn8VJluISPnU5Bw=;
        b=XNFrGnPusMYJdOCBPhg2m/7/f3v7dsxxTdfeMaaFoaAOdRGAWdCh6naFPsv3KhEFRx
         aWAs+FAEVbYfS7spHA2uLVbe8OWSNqssQcCV6Whu18NobkxQa1gqVZ0xVq2wdPMTNeGw
         CFAkDbVfz7nSapxVVPwVm5NX8hbrZeyr7p7us=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RUeHZZEAlSWtIVA2GkDizT17SwIUq9C4x0+tVzVf7y4DmZeEDiAbk5hrqSplxlw+3P
         znNKdE9oey1UOqz65B6cZg3EMkcMAZCYBcS1nfhkI1pJAUgb6IbK6gXTBgHOWC09Iz/L
         iCQI/NoW7pEq8Pme6Dpvc6xsOXQXNmOhLW8wQ=
Received: by 10.231.147.18 with SMTP id j18mr16856484ibv.19.1279066576664;
        Tue, 13 Jul 2010 17:16:16 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n20sm27392714ibe.11.2010.07.13.17.16.15
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 17:16:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100713235825.GC12639@debian>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150951>

Hi Ram,

Sorry I missed this message before.

Ramkumar Ramachandra wrote:

> It's
> alright if the git.git version of svnrdump rots for a few months
> (before a Subversion release includes it), as long as it works and
> doesn't halt future work.

To clarify: is that because of API differences between svn 1.6 and
trunk?

If we are including a convenience copy of files that are (soon to be)
in svn trunk, I don=E2=80=99t see much reason to diverge from the svn
version except for API differences and the overhead of updating too
frequently.
