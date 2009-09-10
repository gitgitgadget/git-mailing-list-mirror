From: John Tapsell <johnflux@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Fri, 11 Sep 2009 01:04:05 +0300
Message-ID: <43d8ce650909101504q32448cb9w562a43969d01b1fe@mail.gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
	 <200909101850.26109.jnareb@gmail.com>
	 <43d8ce650909101246l50189c97r4f3fc4a8d7a0bd4@mail.gmail.com>
	 <200909102223.31602.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 00:04:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlrkX-0007Ty-HX
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 00:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbZIJWEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2009 18:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbZIJWEI
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 18:04:08 -0400
Received: from mail-yx0-f176.google.com ([209.85.210.176]:59449 "EHLO
	mail-yx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbZIJWEH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 18:04:07 -0400
Received: by yxe6 with SMTP id 6so749881yxe.22
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 15:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9lpMT3bQua8qX06G4DGQEwRIEqh9pdenU/ajc1xOxhY=;
        b=P8MjYzGTqjNnsj3h2Ip8quu8BVXw1Uvrkp6NKmYgIvNzA8GsSnZE2DSmLUQKwuxpJO
         YCJi5xKW1/p3gClm/t2d+0aLzJ5EHmZS8uynCVWV22/xej+AhpFLq4WJyeyxRqBTcg5I
         2yHdfoYifmMh7SDk2wvdEoED/djdwVCN+VoqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=akl/S1ml7cN3ZvimDgJ2TdY/02Jx6S0QmDlyDNjbQb2+cKKnH3GyGeAfsApQ1FzV3Q
         R85p6+tNMU2lbFLGGWta+co6c8oIdZsBuL1P0YSufxpCs9mbKib786wqopzrsQIRF+8C
         qq9H9J6/R20OxMJcV41QBjzobb3CjzF4+xRpE=
Received: by 10.150.254.19 with SMTP id b19mr3692706ybi.6.1252620246026; Thu, 
	10 Sep 2009 15:04:06 -0700 (PDT)
In-Reply-To: <200909102223.31602.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128152>

2009/9/10 Jakub Narebski <jnareb@gmail.com>:
> Dnia czwartek 10. wrze=C5=9Bnia 2009 21:46, John Tapsell napisa=C5=82=
:
>> 2009/9/10 Jakub Narebski <jnareb@gmail.com>:
>
>> > First, it would be consistent with how ordinary archivers such as =
tar
>> > or zip are used, where you have to specify list of files to archiv=
e
>> > (in our case this list is HEAD). =C2=A0Second, I'd rather not acci=
dentally
>> > dump binary to terminal: "git archive [HEAD]" dumps archive to sta=
ndard
>> > output.
>>
>> That could be fixed by outputting to a file. =C2=A0git format-patch =
outputs
>> to a file, so why wouldn't git achieve?
>
> "git format-patch" outputs to files because it generates _multiple_
> files; generating single patch is special case. =C2=A0Also git-format=
-patch
> can generate file names from patch (commit) subject; it is not the ca=
se
> for "git archive" (what name should it use?).

What if it used the current (or topleve) directory name?  Wouldn't
that work in most cases?  For cases it doesn't work, the user can just
rename or specify the output name, so it would be no worse than the
current case.

John
