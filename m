From: Geoffrey Irving <irving@naml.us>
Subject: Re: bug with .git file and aliases
Date: Mon, 20 Jul 2009 10:27:16 -0400
Message-ID: <7f9d599f0907200727v5b258a73n3fa664f134c0eead@mail.gmail.com>
References: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com> 
	<adf1fd3d0907200704sb097a99h1ab8f118be5854f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Jul 20 16:27:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MStqA-0003cF-9G
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 16:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbZGTO1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2009 10:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbZGTO1h
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 10:27:37 -0400
Received: from mail-vw0-f202.google.com ([209.85.212.202]:63207 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZGTO1h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2009 10:27:37 -0400
Received: by vwj40 with SMTP id 40so142945vwj.33
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=q8DbaE2qlCqj5wJsiTnAN7/wEgqzVwpgO86AZwyHUdw=;
        b=TGL0eEyjdS+zVoWVkkxsERYE029qnK6zb8F3toXkabCegJ8JTJH+jCs5ygwgKksfDF
         u8cmLR2IowsuF55YAOYic0YZc0Ei+7eiAX0fzqF0OtwTaQfYpuD2gOz+W0K0QriznOYW
         Ds1U0OLweXKAkLkekJCyUliuvBCtXs0tCeTkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=sYKLqGtl3xz+si39kWAGwIYeMa9qm4vc0v+L3g1TEUZ6932r84recrMfXrFNWWW0Ib
         djxtr9924QEj1/LJUTo9z3MMxmVKmdES7tZORwS6Q9KpxuB6ztyyMwbkWdlhYGn6eD46
         LrLcDs5n3JNt4jVCfA2auhY15xEi+nvzH7MR8=
Received: by 10.220.96.66 with SMTP id g2mr4839342vcn.119.1248100056093; Mon, 
	20 Jul 2009 07:27:36 -0700 (PDT)
In-Reply-To: <adf1fd3d0907200704sb097a99h1ab8f118be5854f9@mail.gmail.com>
X-Google-Sender-Auth: a3a22a0b47175bf1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123604>

On Mon, Jul 20, 2009 at 10:04 AM, Santi B=E9jar<santi@agolina.net> wrot=
e:
> I suspect that the $GIR_DIR and .git file works equally in this
> aspect, so you should specify where is the workdir in .git/config wit=
h
> respect the repository:
>
> git config core.workdir `pwd`

Nope, that has no effect.

By the way, I can work around this problem by using

    git config alias.st "!git status"

but unfortunately that has slightly different behavior (it ignores pwd)=
=2E

Geoffrey
