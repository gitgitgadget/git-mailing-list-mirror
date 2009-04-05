From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 7/7] user-manual: simplify the user configuration
Date: Sun, 5 Apr 2009 12:14:02 +0300
Message-ID: <94a0d4530904050214y256cc0d3icc1843cfd148d69d@mail.gmail.com>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-6-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-7-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-8-git-send-email-felipe.contreras@gmail.com>
	 <76718490904042036q26bebc13p91c8cffaf432c02c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 11:15:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqOS6-0000aK-B0
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 11:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584AbZDEJOK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 05:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754559AbZDEJOH
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 05:14:07 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:49616 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128AbZDEJOF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 05:14:05 -0400
Received: by fxm2 with SMTP id 2so1486440fxm.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 02:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cjfpCFgGJysG6mK12i+yTl09atkqtVaJEnbWdj85v4s=;
        b=eCp26FSS0K6HfIt+D+7onqRVXd5R2wwy0nFRpXtRVCpdtc1fQs9TDr2lmHSBryjAs5
         MayBjZD6nXT+CgIaQYh3zOcmWezeZjODGlMwkIKyDYfQN7ODhZmxwIFqXGe9WDJqDtgw
         weqsFSmH6nFxfhsjVPB+BzToJmlIaVqbj6Xk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MJ8wSq3yMfKA7Hve2rVk/DHMvPdJyBRqViUSpoylqIk7M3xLlI/AjXaitb1kKqKeJv
         wGEIQNIpbESL/DeBu4w9MjfERRLYt1hbPIDaLJq+zn0Y4/bDNgYvCk0/jrd13BVzsyEG
         jSQy3/PSsklSoXCNT6B1xwF38zKf91g8hz5uM=
Received: by 10.86.31.18 with SMTP id e18mr2163793fge.72.1238922842430; Sun, 
	05 Apr 2009 02:14:02 -0700 (PDT)
In-Reply-To: <76718490904042036q26bebc13p91c8cffaf432c02c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115640>

On Sun, Apr 5, 2009 at 6:36 AM, Jay Soffian <jaysoffian@gmail.com> wrot=
e:
> On Sat, Apr 4, 2009 at 5:38 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> This is shorter, avoids the burder to think about the format of the
>> configuration file, and git config is already used in other places i=
n
>> the manual.
>> [...]
>> =C2=A0------------------------------------------------
>> -[user]
>> - =C2=A0 =C2=A0 =C2=A0 name =3D Your Name Comes Here
>> - =C2=A0 =C2=A0 =C2=A0 email =3D you@yourdomain.example.com
>> +$ git config --global user.name "Your Name Comes Here"
>> +$ git config --global user.email you@yourdomain.example.com
>> =C2=A0------------------------------------------------
>
> This has come up before, and the idea was to hint to the reader that
> .gitconfig is something they can edit themselves.

Ok, I forgot to explain this again the commit message of this
particular patch, but it's described in the patch series description.

The previous patch adds a 'Getting Started' section that explains
exactly that; you can edit ~/.gitconfig.

So that concern is already addressed.

--=20
=46elipe Contreras
