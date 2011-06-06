From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Jabber, question on push,pull and --tags, and no help but jabber
Date: Mon, 6 Jun 2011 18:21:25 +0300
Message-ID: <BANLkTikYhWxONOCaPx7P0RX6By6GmEum=g@mail.gmail.com>
References: <20110606130205.GA41674@sherwood.local>
	<4DECE4D6.9000204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 06 17:21:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTbcS-0000Ql-T1
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 17:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757200Ab1FFPV2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2011 11:21:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43019 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab1FFPV1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 11:21:27 -0400
Received: by bwz15 with SMTP id 15so3389236bwz.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/+wJbxYMGLJtMlSgdZmXzYIRNen5vgkUKfQnVtE7PoQ=;
        b=As8AVx8pQhlmYodpr4FtfUDAzjVuz0AUOaP8q9nFWNQvR90qyzzjA6bJdkuXZOrONU
         EGgBW2Rymnjz+ONZBWVCTf0QE3kCeLPfVr4DvXUWrGbrMl/u5hUw4DU3x/3nFsjNOkYQ
         obYzuAe/S+zQ8N4g7vjmdXlkOHcxUJmdZAvcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=COME+QRFPtRKMw22croi4TbeyL2+9qxfCpptucbeqgwa83q4vnB3E1xZe09d/16wIw
         TssdVSHpi1USB99l18vyydAn9Vz76ZeRzlBnAGxXdsDJy7t8IPnuGePL0pUytt/2FwiF
         Q01MAZYQL5UIdwIjRj+Nb5tyEQlH8qwYUZTPs=
Received: by 10.204.136.71 with SMTP id q7mr1372049bkt.182.1307373685903; Mon,
 06 Jun 2011 08:21:25 -0700 (PDT)
Received: by 10.204.52.193 with HTTP; Mon, 6 Jun 2011 08:21:25 -0700 (PDT)
In-Reply-To: <4DECE4D6.9000204@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175128>

On Mon, Jun 6, 2011 at 5:31 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Steffen Daode Nurpmeso venit, vidit, dixit 06.06.2011 15:02:
>> Hello GIT,
>> =C2=A0 =C2=A0 first paragraph is reserved for praising your existenc=
e.
>> =C2=A0 =C2=A0 'Used cvs(1) for long years in small team projects wit=
h local
>> =C2=A0 =C2=A0 private repos and never felt the need for anything els=
e. =C2=A02011
>> =C2=A0 =C2=A0 is different. =C2=A0I first tried you but failed resou=
ndingly. =C2=A0Due
>> =C2=A0 =C2=A0 to vim(1) and mutt(1) i discovered hg(1) and i still l=
ove it's
>> =C2=A0 =C2=A0 simple usage. =C2=A0'Talking about the front-end anywa=
y. =C2=A0It's huge
>> =C2=A0 =C2=A0 memory consumption and slow performance forbids it's u=
sage on
>> =C2=A0 =C2=A0 our old PCs (e.g. Cyrix 166+) though. =C2=A0So i came =
back and
>> =C2=A0 =C2=A0 found you still receptive! =C2=A0And the more i work, =
the less
>> =C2=A0 =C2=A0 i hurt, the greater the knowledge, the smoother the
>> =C2=A0 =C2=A0 interaction. =C2=A0Are you the final word on RC in the=
 end?
>>
>> I stumbled over one thing i don't understand, because it seems
>> illogical: why do i need to use --tags to force pushing of tags?
>> Because there is even a config option for the latter, i suspect
>> this is because of intention. =C2=A0It would be nice to get some
>> information on the background of that, like a link to yet existing
>> documentation. =C2=A0Anyway i was a bit astonished to look at some
>
> Tags may contain private information. Say you pull some changes from
> your head of group, find a strange commit you want to look at later a=
nd
> tag it with "what-is-this-crap"...
>
> More seriously, tags are not part of the "remotes layout", so when yo=
u
> push them and others pull them they overwrite their tags if there's a
> name clash.

Until tag namespaces are merged.

--=20
=46elipe Contreras
