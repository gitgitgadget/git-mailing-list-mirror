From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 8/8] user-manual: simplify the user configuration
Date: Mon, 23 Mar 2009 01:01:08 +0200
Message-ID: <94a0d4530903221601hb3bf8aelf98b22ee560dfb7b@mail.gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-5-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-6-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-7-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-8-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-9-git-send-email-felipe.contreras@gmail.com>
	 <0A3F8ECD-EEFA-4DB0-AFED-AEE7DAFE8DB3@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:02:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlWgl-00025u-EE
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 00:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756298AbZCVXBM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 19:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756152AbZCVXBM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 19:01:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:36721 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983AbZCVXBL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 19:01:11 -0400
Received: by fg-out-1718.google.com with SMTP id 16so297698fgg.17
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 16:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lICiAI1tpSpMUpLRoQl26wvhcu3KxxXNSjdUTaqMnfo=;
        b=XZ4jrmDF+avZezMebKzo2t0VznwAviITHpqpGCsM5+b6vKn2uwnhqw/qV39Ccca6yG
         VZw9NUW/tgv+YhBNF0IaGY5KBQSGw8IUwoYbBf0n/HnMkwyPCH+3O0r13eNHtedNJhY+
         NX/K+ubgvX2NAqZpmK89MsDbN4R0IIgUPdAoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o8D+38E1YAVa/4LnAlV7m8uG+atzQ2LAkQTvnNT+utktn87FjBB4tL751S1wTn1H9x
         +lAi/AygGQ4fB+AXg9jC9CqpoRwwgqrt8CDzgxGGFQPXZRDIeUQLIMQ5znMNzoD6osIU
         nUl9rcJnGlc0ncIwNTyDUYS7z2yXDG4JGEQFE=
Received: by 10.86.33.10 with SMTP id g10mr3150696fgg.44.1237762868380; Sun, 
	22 Mar 2009 16:01:08 -0700 (PDT)
In-Reply-To: <0A3F8ECD-EEFA-4DB0-AFED-AEE7DAFE8DB3@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114194>

On Mon, Mar 23, 2009 at 12:42 AM, Wincent Colaiuta <win@wincent.com> wr=
ote:
> El 22/3/2009, a las 19:05, Felipe Contreras escribi=C3=B3:
>
>> This is shorter, avoids the burder to think about the format of the
>> configuration file, and git config is already used in other places i=
n
>> the manual.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> Documentation/user-manual.txt | =C2=A0 =C2=A08 +++-----
>> 1 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/user-manual.txt b/Documentation/user-manu=
al.txt
>> index b7678aa..c6ed940 100644
>> --- a/Documentation/user-manual.txt
>> +++ b/Documentation/user-manual.txt
>> @@ -1015,13 +1015,11 @@ Telling git your name
>> ---------------------
>>
>> Before creating any commits, you should introduce yourself to git. =C2=
=A0The
>> -easiest way to do so is to make sure the following lines appear in =
a
>> -file named `.gitconfig` in your home directory:
>> +easiest way is to use the linkgit:git-config[1] command:
>>
>> ------------------------------------------------
>> -[user]
>> - =C2=A0 =C2=A0 =C2=A0 name =3D Your Name Comes Here
>> - =C2=A0 =C2=A0 =C2=A0 email =3D you@yourdomain.example.com
>> +$ git config --global user.name "Your Name Comes Here"
>> +$ git config --global user.email you@yourdomain.example.com
>> ------------------------------------------------
>>
>> (See the '"CONFIGURATION FILE"' section of linkgit:git-config[1] for
>> --
>> 1.6.2.1.352.gae594
>
> See this lengthy thread:
>
> http://article.gmane.org/gmane.comp.version-control.git/106634

I've obviously seen that thread because I started it.

Can you write more than one line to explain your point?

--=20
=46elipe Contreras
