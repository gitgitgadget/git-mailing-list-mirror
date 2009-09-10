From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 22:17:54 +0200
Message-ID: <fabb9a1e0909101317t4cbfc582k641a64a806ed8dcc@mail.gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com> 
	<m3fxavvl5k.fsf@localhost.localdomain> <4C1FB36D-F8A6-4C01-A42A-8AD2355A9961@wincent.com> 
	<200909101850.26109.jnareb@gmail.com> <43d8ce650909101246l50189c97r4f3fc4a8d7a0bd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 22:18:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlq6R-000897-3D
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 22:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbZIJUSO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2009 16:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585AbZIJUSN
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 16:18:13 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:58777 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbZIJUSM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 16:18:12 -0400
Received: by ewy2 with SMTP id 2so492310ewy.17
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 13:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wIrICTzCcnd7oMz5vpn4sjjbzP32QAvt0svv+DazDM4=;
        b=A/WyDE9efBGEcBkekojmJSfWVsmAxXwIBcdjgQKv3/7W2M4xwTqqD5TeqURNeo637c
         WbYhRSvf6W8GIkT+MkgwHS5YE1F+pp3JahHoFI3TPHChg6Zz5fK/QnHPLkOVkwhKQW1k
         /Bu8ZJYm5MpQI4V4u/FiNSWXxnNiG+dedkkhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kBPieEduDZW6YEaWOzk0d1ywem9xX6lpa+zO6jBa+NSBOVe+yqf+3onDBU02hPBGOZ
         gT2LWL3HasbEXMHoOZ0RYqDLpCX/i1hRkQ5K6OK7euW7jjnGMDL3V8bOKJp/N91zTK8a
         vluOelAaF+rEtOJlLCRmIo7xgbNeuoWLYoccY=
Received: by 10.216.8.5 with SMTP id 5mr78907weq.181.1252613894202; Thu, 10 
	Sep 2009 13:18:14 -0700 (PDT)
In-Reply-To: <43d8ce650909101246l50189c97r4f3fc4a8d7a0bd4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128139>

Heya,

On Thu, Sep 10, 2009 at 21:46, John Tapsell <johnflux@gmail.com> wrote:
> That could be fixed by outputting to a file. =A0git format-patch outp=
uts
> to a file, so why wouldn't git achieve?

Because git format-patch works on a per-patch basis, and patches
inherently have a 'name' (the first line of the commit message), an
entire repository does not, so one would have to resort to arbitrary
names such as 'archive.tar.gz' or such.

--=20
Cheers,

Sverre Rabbelier
