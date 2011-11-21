From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Fixing a broken GIT repo
Date: Mon, 21 Nov 2011 17:37:59 +0100
Message-ID: <CABPQNSaJVYqLw+JuOWg2wqa-Sig6+W_W-id7yRFLzZ0kTr73hw@mail.gmail.com>
References: <ja5dgo$nlf$1@dough.gmane.org> <4EC6625B.2070301@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bart van den Burg <bart@burgov.nl>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 21 17:38:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSWtM-0001uV-U1
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 17:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384Ab1KUQio convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Nov 2011 11:38:44 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46199 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab1KUQin convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2011 11:38:43 -0500
Received: by ggnr5 with SMTP id r5so2518594ggn.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=qSM1avDowBUdoDNbCrECr4IWhwakoU6EocbwD8677I0=;
        b=AtjNiDVGbsOjlnQu3keVnhj+OAWIp83u3LMs2tlOohbGpdQQELVYRvVc0f1MzFBXP6
         K7voCzpM87FGaq18+p994DRIqnD90i6VsPg68/4YT/vUcGPtJtiEMTKu5cMXXgOVXyOe
         vzInPPdMXUFT7ojYmZ+ZsyIh/he+oYHSrO8Po=
Received: by 10.68.60.71 with SMTP id f7mr32304428pbr.122.1321893523032; Mon,
 21 Nov 2011 08:38:43 -0800 (PST)
Received: by 10.68.21.39 with HTTP; Mon, 21 Nov 2011 08:37:59 -0800 (PST)
In-Reply-To: <4EC6625B.2070301@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185750>

On Fri, Nov 18, 2011 at 2:49 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 11/18/2011 11:54, schrieb Bart van den Burg:
>> I somehow managed to break my GIT repo. Whenever I try to clone or f=
etch
>> from a clean local repo, I get an error.
>>
>> I'm able to go back on the server, to the very last commit where
>> everything works, but as soon as I make a change locally and push it=
, it
>> breaks again.
> ...
>> $ git clone git@git.samson-it.nl:/home/git/shifter_rai
> ...
>> Receiving objects: 100% (9557/9557), 2.85 MiB | 1.06 MiB/s, done.
> ...
>> $ git push
>> Counting objects: 4, done.
>> Delta compression using up to 4 threads.
>> Compressing objects: 100% (2/2), done.
>> Writing objects: 100% (3/3), 271 bytes, done.
>> Total 3 (delta 1), reused 0 (delta 0)
>> To git@git.samson-it.nl:/home/git/shifter_rai
>> =A0 =A0cc5693a..85d1ee9 =A0master -> master
>
> It looks like you are pushing via git protocol from Windows
> (Git-for-Windows). This is known to dead-lock in most cases, and even
> though it did not here, I would not be surprised if it had other issu=
es.
>
> Do not do it. Push via ssh instead.
>

Does it? Doesn't the "To git@git.samson-it.nl:/home/git/shifter_rai"
line suggests ssh?
