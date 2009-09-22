From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Trivial fix: Display a more friendly message with  git-shell.
Date: Tue, 22 Sep 2009 01:17:18 -0700 (PDT)
Message-ID: <m3fxafbdh0.fsf@localhost.localdomain>
References: <1253466672-21051-1-git-send-email-tfransosi@gmail.com>
	<4AB71A76.5010509@viscovery.net> <vpqeiq0ssn7.fsf@bauges.imag.fr>
	<a4c8a6d00909211345q593e673bo4964204afa5ce807@mail.gmail.com>
	<vpqr5tzqvzm.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 22 10:17:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq0ZJ-0004jY-9p
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 10:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417AbZIVIRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 04:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754285AbZIVIRT
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 04:17:19 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:49294 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbZIVIRR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 04:17:17 -0400
Received: by bwz6 with SMTP id 6so2454290bwz.37
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 01:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=GWxUNBdcZ+2USyxOgqd/xqIPAURLo5heMvcC5fJQSBk=;
        b=fEX50ymd6nx3FROzSBOEzTVdeW3wpDVRogfHoPiMtXVBx8aMaKWvzSlLsTheK+W05j
         uwnswnE67BABbKc+A49NsINz1+3jOpFUMFa/VSZR7zKY6X4GS8Zysyr4JQI5017lqZW1
         f7wtU8hhomKjNbvz92e2W0dWzz3ehyq2/juR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=qvYt+9JNLqvsNUEIEiO5OsPm84YTufT6g+K2nJCGAm77Mpa4PWli7u0Vm6LVB6maTK
         OyE4nSOxfXcagU6WjP06KPM1QbDoZ7QpROAwmQ/0AKThiZEeQWYQHptmJKbeikxx4tLy
         sw/Ac7wEEFgD/kSjuyazEMCBHW0oc7oTCQF0s=
Received: by 10.204.34.205 with SMTP id m13mr574180bkd.80.1253607440345;
        Tue, 22 Sep 2009 01:17:20 -0700 (PDT)
Received: from localhost.localdomain (abvd208.neoplus.adsl.tpnet.pl [83.8.201.208])
        by mx.google.com with ESMTPS id d13sm775449fka.30.2009.09.22.01.17.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Sep 2009 01:17:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n8M8HGwJ029254;
	Tue, 22 Sep 2009 10:17:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n8M8HFfb029251;
	Tue, 22 Sep 2009 10:17:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <vpqr5tzqvzm.fsf@bauges.imag.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128925>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> Thiago Farina <tfransosi@gmail.com> writes:
> 
>> Hi Matthieu
>> On Mon, Sep 21, 2009 at 3:45 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Perhaps one more line saying what 'man git-shell' says in addition
>>> would help:
>>>
>>> $ git-shell
>>> git-shell: Restricted login shell for GIT-only SSH access
>>> Usage: ...
>> I added this line to the output usage, but would be good to show the
>> commands that git-shell accept too?
> 
> Well, at some point, I think the user will have to read the man page.
> I find it better to have a non-agressive error message, but I'm not
> sure it's relevant to try to give the complete manual here.

Perhaps:

  $ git-shell
  git-shell: Restricted login shell for GIT-only SSH access
  This shell cannot be used as a login (interactive) shell

and/or

  $ ssh user@repo.example.com
  This user is restricted to GIT-only SSH access

(or something like that, especially in the second case).

I don't think giving 'Usage:' here would be a good idea, as this
program is not meant for end user, but for automatic use.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
