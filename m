From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Fixing branches from a (really messed up) subversion repository
Date: Tue, 15 Jun 2010 16:42:31 +0000
Message-ID: <AANLkTin268tbt5E2flbzwq8Rik0D21Uf4t2z-5fgb4BZ@mail.gmail.com>
References: <AANLkTinmU3tOkv9usjGogHn5cXm07FMde8ryDKuWNKD_@mail.gmail.com>
	<AANLkTink-Rm44xnzBHVo6W_29YCPrjScnolqx_9B8A5G@mail.gmail.com>
	<AANLkTim6pBqc1qQhvGrzmf5FDbVkfw1GmNP00BM_99n4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joshua Shrader <jshrader83@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 18:42:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOZDi-000545-B6
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 18:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757804Ab0FOQmd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 12:42:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55039 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757788Ab0FOQmc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 12:42:32 -0400
Received: by iwn9 with SMTP id 9so4702589iwn.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PiGxTfk5hlGhyaMS1g2aGYybJ4ZvmviRzEPCtlTTogM=;
        b=Nq/SfgaD9ePMn+2W7cvOurCRIDCAhcXe038pvTy+CZC5OGH33VWE2vTHYWMMYC/HIR
         8ubecFI8UkAlc1YpuZei7f4/B7jIjRb5sAmxZOYJOUkFKj4VnibA4QDE+0lhbeYjpBiT
         n9CeS2NwLggEyc1v8ewdNewY+g21/qKljIZDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=USsNjlZgOQ2KDLUiYexQqY5Ij1AzURFGG5Sfxl42ruU0FTr/z998ZLTXSTGjAAvXwU
         +n/JEtEUhqjgSdcJnLhI2dovO9tmT2ix9j1Vun69S828irbLQgi/QjqraReuETcXYAuV
         iUtvm6QRvnQ1IteJlJ/Y5ga6SY0jkcgsawnw4=
Received: by 10.231.191.66 with SMTP id dl2mr7997654ibb.101.1276620151840; 
	Tue, 15 Jun 2010 09:42:31 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Tue, 15 Jun 2010 09:42:31 -0700 (PDT)
In-Reply-To: <AANLkTim6pBqc1qQhvGrzmf5FDbVkfw1GmNP00BM_99n4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149204>

On Tue, Jun 15, 2010 at 16:40, Joshua Shrader <jshrader83@gmail.com> wr=
ote:
> Not quite sure if I understand correctly. =C2=A0Can Git import direct=
ly
> from an SVN dump, or are you suggesting to essentially re-build the
> svn repository correctly, and then import?

I mean:

  1. svnadmin dump /path/to/repo > svn.dump
  2. *filter svn.dump*
  3. svnadmin load ...
  4. git svn /path/to/loaded/dump
