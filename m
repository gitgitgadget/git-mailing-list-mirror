From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 7/8] user-manual: add global config section
Date: Wed, 25 Mar 2009 00:17:12 +0200
Message-ID: <94a0d4530903241517g1453033fs2c02de631595f7e9@mail.gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-5-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-6-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-7-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-8-git-send-email-felipe.contreras@gmail.com>
	 <20090324215223.GL19389@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 23:18:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmExL-0004l0-Eb
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 23:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbZCXWRS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 18:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbZCXWRQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 18:17:16 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59467 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbZCXWRQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 18:17:16 -0400
Received: by fxm2 with SMTP id 2so2500375fxm.37
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tTVKcJVIhhp6RRJ/uWOrsJ3/bH6CgqEGWPH7pXylJbs=;
        b=EdNHObxTeuHB0iEZOvfsIgQdOn4R7T8EukQjQUhQ5YgxvUbLsAQWfWyaPOlVnjHxw2
         fYrIQBvemDIfr88Atly95bEbkmFAvy84E6SQP1t4drR5oXY68Z+YYHbbGMVud1SIn/3b
         0nezv2qGA5A7WusH8/sVJ2SUnKtb8Ioi/FFdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QV+ugMhTn0Dyl/CAMWzbAg/RkHxDW7XzhCTH8v+k0lfI81DABCQdWvIuTercoaOn62
         Lo3grpy6WKou14NrRmt/nxKakypgd1vduF9DTD57lSfUCDzxiN+Yk1kSPNW6jLSEwtCi
         yjBTF6QllzR95ZWdr54pXY64eoaskW/sT3Lpg=
Received: by 10.86.65.9 with SMTP id n9mr5024608fga.55.1237933032738; Tue, 24 
	Mar 2009 15:17:12 -0700 (PDT)
In-Reply-To: <20090324215223.GL19389@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114501>

On Tue, Mar 24, 2009 at 11:52 PM, J. Bruce Fields <bfields@fieldses.org=
> wrote:
> On Sun, Mar 22, 2009 at 08:05:20PM +0200, Felipe Contreras wrote:
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> =C2=A0Documentation/user-manual.txt | =C2=A0 34 ++++++++++++++++++++=
++++++++++++++
>> =C2=A01 files changed, 34 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/user-manual.txt b/Documentation/user-manu=
al.txt
>> index 3278aa7..b7678aa 100644
>> --- a/Documentation/user-manual.txt
>> +++ b/Documentation/user-manual.txt
>> @@ -40,6 +40,40 @@ without any explanation.
>> =C2=A0Finally, see <<todo>> for ways that you can help make this man=
ual more
>> =C2=A0complete.
>>
>> +[[getting-started]]
>> +Getting started
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +You can skip this section safely, however, configuring git at an ea=
rly stage
>> +would probably make your overall experience with it more pleasant. =
Also many
>> +parts on this manual would be easier to grasp.
>
> I'd skip this first paragraph.

Ok. I was regretting it even as I was writing it :p

>> +
>> +Git's configuration is distributed on different locations: 'system'=
, 'global', and
>> +'repository'. Variables are stored in the form of 'foo.bar', and th=
e precedence
>> +order is 'repository' > 'global' > 'system'.
>
> "distributed on" isn't right ("among" instead of "on" might work). =C2=
=A0It's
> not obvious to me what ">" means in terms of precedence. =C2=A0And I'=
m not
> sure the comment about the form conveys any useful information. =C2=A0=
Also, I
> think the systemwide configuration is less important, and could be le=
ft
> to the man page.

Ok. That would make it easier.

How about:
Git's configuration is distributed among different locations--on this
manual we are only going to deal with 'global' and 'repository', where
'repository' variables take precedence over 'global' ones.

>> +
>> +You would probably want to start setting up something useful:
>> +------------------------------------------------
>> +$ git config --global color.ui auto
>> +------------------------------------------------
>> +
>> +This will make prettier the output of certain commands such as `git=
 diff`, but
>> +that's not important; what is important here is that `color.ui` has=
 been
>> +stored in the 'global' (for the user) configuration.
>> +
>> +You can take a look and manually modify the configuration with the =
`--edit`
>
> "take a look and" isn't really necessary; either eliminate it or repl=
ace
> it by "view and" or just "also".

I like "View and".

>> +option (will use '$EDITOR'):
>
> s/will/which will/.

Ok.

--=20
=46elipe Contreras
