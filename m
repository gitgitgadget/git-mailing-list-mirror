From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Thu, 01 May 2014 20:14:29 -0500
Message-ID: <5362f1755f2a9_d1310572f0fa@nysa.notmuch>
References: <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362266a3ca00_284da2f2eca3@nysa.notmuch>
 <7vbnvhil5x.fsf@alter.siamese.dyndns.org>
 <53629da233345_76612eb2f075@nysa.notmuch>
 <20140501194846.GA6227@odin.tremily.us>
 <20140501200703.GB6227@odin.tremily.us>
 <5362d7dc7b12_12fe14dd31095@nysa.notmuch>
 <20140502000208.GB28634@odin.tremily.us>
 <5362e8b09aba1_429131b31038@nysa.notmuch>
 <20140502011004.GD28634@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 03:25:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg2E5-0002iS-Tf
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 03:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbaEBBZL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2014 21:25:11 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:38776 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbaEBBZK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 21:25:10 -0400
Received: by mail-oa0-f50.google.com with SMTP id i11so4420027oag.37
        for <git@vger.kernel.org>; Thu, 01 May 2014 18:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=g6wK8VJMFIQBSI9qAaRZrmAWlx96uY31HgVD/ilN6l4=;
        b=oEhvxrdG0s/BpTFbme5VFb0n6OvaSyaCDDhw2b4MQJnf/13a70VpdbMnvBZlHMRJq/
         /lVemKCIekYZP/DQTt6urc7mKUuXRojotkWYIFjG2A4/m/6jq4BKawpPG6lHwnjLLKW5
         VKYpUA9ZWg1KpbhxcygVYS+YQ/rkz18rOGh5VfYiONOyP3r7qI79KLzeNsQxbXI9kgDe
         q+1ncc7hL+rfTq9qjLm6WkLVS6iIa5VxbnDzOIz5cvaTI3OCaCyVtb99LsaYLOyHLbdE
         +9gBJKTkoKordkiHSfmBC0dSys1z5Z4mgzvwWcdZmf5iKrDvyHPVqPc+ZIB9Kw2AUlsU
         IpHA==
X-Received: by 10.182.42.136 with SMTP id o8mr188186obl.80.1398993909653;
        Thu, 01 May 2014 18:25:09 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ko3sm123622045oeb.1.2014.05.01.18.25.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 18:25:08 -0700 (PDT)
In-Reply-To: <20140502011004.GD28634@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247919>

W. Trevor King wrote:
> On Thu, May 01, 2014 at 07:37:04PM -0500, Felipe Contreras wrote:
> > If that was the case the user wouls have run `git merge
> > --no-ff`. Only expereinced users would answer 'no'.
>=20
> Folks who are setting any ff options don't need any of these training
> wheels.

Indeed.

> My proposed --prompt behavior is for folks who think =E2=80=9CI often=
 run this
> command without thinking it through all the way.  I'm also not used t=
o
> reading Git's output and using 'reset --hard' with the reflog to
> reverse changes.  Instead of trusting me to only say what I mean or
> leaving me to recover from mistakes, please tell me what's about to
> change and let me opt out if I've changed my mind.=E2=80=9D

Unfortunately those folks by definition wouldn't know about the --promp=
t
option.

> > For example, I'm thinking that by default when the a fast-forward i=
s
> > possible, just do it, =E2=80=A6
>=20
> But just because a ff is possible doesn't mean it's what the
> user/project wants.

Yeah, so? We cannot read minds, especially not the minds of the people
that are not sitted in from of the computer.

> It may be the most likely guess, but why guess when they've explicitl=
y
> asked for a prompt?

*If* the user has specifically asked for a prompt, sure, ask. But I'm
not particularly interested in that, because I'm certain very very few
people would use --prompt.

I'm interested in the defaults.

--=20
=46elipe Contreras