From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Fri, 02 May 2014 13:55:36 -0500
Message-ID: <5363ea28d3c14_70ef0f30c94@nysa.notmuch>
References: <5362266a3ca00_284da2f2eca3@nysa.notmuch>
 <7vbnvhil5x.fsf@alter.siamese.dyndns.org>
 <53629da233345_76612eb2f075@nysa.notmuch>
 <20140501194846.GA6227@odin.tremily.us>
 <20140501200703.GB6227@odin.tremily.us>
 <5362d7dc7b12_12fe14dd31095@nysa.notmuch>
 <20140502000208.GB28634@odin.tremily.us>
 <5362e8b09aba1_429131b31038@nysa.notmuch>
 <20140502011004.GD28634@odin.tremily.us>
 <5362f1755f2a9_d1310572f0fa@nysa.notmuch>
 <20140502145433.GF28634@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:06:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgIms-0005ER-2y
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 21:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbaEBTGS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2014 15:06:18 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:45285 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbaEBTGR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 15:06:17 -0400
Received: by mail-oa0-f51.google.com with SMTP id l6so5618757oag.24
        for <git@vger.kernel.org>; Fri, 02 May 2014 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=EKZmP4kxJYsYXQrd6FlABt7yvPeGcgb3OtU4IhPj5ug=;
        b=X2W4RkcdXsJoBfJ+yOluIbXioxyDzydYkPszazT2lNVPr2PxypuTrdcfqRmfjgcyys
         7BBTh0oQgxfnaJMC/b7WMW09kEvqS8nagJo+9IeZWY6CDFNnF112mM/uqe9KvVD4jxmf
         Smk0wHxeWUHOzeorRaXo19YeE8GcgBFmLs4AULlTZ77gpnVp9drRF+KG5P5Ogj89F8mG
         fRPOAcXgKa8InDR+hSoPCvH3GhmjepPVyzpxOZ3KjZ/6iRfrkyksPZOGyn3DTJLNF0Ey
         TW6AmwE5PI3dwIIxbb5owxAoT+dlY2TBum98jM98t+ilWGxd7SnJ0iyeq1gG6r+INuvs
         k/wQ==
X-Received: by 10.60.37.99 with SMTP id x3mr18739934oej.2.1399057576844;
        Fri, 02 May 2014 12:06:16 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ub1sm8379423oeb.9.2014.05.02.12.06.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 12:06:15 -0700 (PDT)
In-Reply-To: <20140502145433.GF28634@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247952>

W. Trevor King wrote:
> On Thu, May 01, 2014 at 08:14:29PM -0500, Felipe Contreras wrote:
> > W. Trevor King wrote:
> > > My proposed --prompt behavior is for folks who think =E2=80=9CI o=
ften run
> > > this command without thinking it through all the way.  I'm also
> > > not used to reading Git's output and using 'reset --hard' with th=
e
> > > reflog to reverse changes.  Instead of trusting me to only say
> > > what I mean or leaving me to recover from mistakes, please tell m=
e
> > > what's about to change and let me opt out if I've changed my
> > > mind.=E2=80=9D
> >=20
> > Unfortunately those folks by definition wouldn't know about the
> > --prompt option.
>=20
> But once such folks are identified, you just have to convince them
> (once) to set the pull.prompt config.  That's a lot easier than
> convincing them (for every pull) to set the appropriate ff flag.

It wouldn't matter if by the default non-fast-forward merges are
rejected.

--=20
=46elipe Contreras