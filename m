From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [RFC/PATCH 4/4] Re-implement 'git remote update' using 'git 
	fetch'
Date: Mon, 9 Nov 2009 07:37:48 +0100
Message-ID: <6672d0160911082237p4645b8d3n8f667b8fc7c80732@mail.gmail.com>
References: <4AF6E865.1030900@gmail.com>
	 <76718490911081643w46e34858kd82270be0482f8b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 07:37:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Nsy-0001ul-8C
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 07:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbZKIGho convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 01:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbZKIGho
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 01:37:44 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:64005 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbZKIGho convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 01:37:44 -0500
Received: by bwz27 with SMTP id 27so3104000bwz.21
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 22:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NMo2MMhNB73Zr06ZGCGK9l9Z+ogj5/TwraLMhBorZqk=;
        b=lkw+sULsFYBzj5hkvhhrjOX82NqHmBh7KgnDDoYkTzne5UXEiK+dzPYReajYrnvmPZ
         AqhK8Qjxh1jQJOq5nXWKjesow/M2q2rrX35LVLgirL9FBajnz/u+/ig0Dyj9qEGr77oW
         z8Z2FNI+IfzBD9jmHZAm5fC3DJNL4G6/6G9Kg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D8A7XhkdTAAEv73UB8q7hkTBcmYL+vVudabVYaVulPmXbdK00nzOhWF/rfZmx9MP+j
         NXTxovGnADI/wWluZ0nSw24ZdMFh5T9hCk/I6PelENSGxnVVjGzbZx+YuiYkdKaI1sAx
         Tei63rCeY+rtxDyByGg6Fuh85Qjvyh7pKQVrQ=
Received: by 10.204.15.22 with SMTP id i22mr1945538bka.13.1257748668529; Sun, 
	08 Nov 2009 22:37:48 -0800 (PST)
In-Reply-To: <76718490911081643w46e34858kd82270be0482f8b9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132443>

2009/11/9 Jay Soffian <jaysoffian@gmail.com>:
> 2009/11/8 Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>:
>> In order to not duplicate functionality, re-implement 'git remote
>> update' in terms of 'git fetch'.
>
> Junio, I guess I'll wait for this to hit pu and then rebase my fetch
> --prune changes on top of it?

It has hit pu now.

If you'll rebase and finish your patch series, I can base my final
patch in my series on your changes, because that patch will need a
fetch that supports --prune in order to support 'git remote update --pr=
une'.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
