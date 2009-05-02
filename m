From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 2 May 2009 18:13:24 -0500
Message-ID: <b4087cc50905021613j1d269757g8c599b484208c188@mail.gmail.com>
References: <200904240051.46233.johan@herland.net>
	 <200904242230.13239.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <20090424231632.GB10155@atjola.homenet>
	 <b4087cc50904241701jb78ce50m122fef475b0f1de7@mail.gmail.com>
	 <20090502155348.GB6135@atjola.homenet>
	 <b4087cc50905021136l5209777bs2209bab385deeef6@mail.gmail.com>
	 <20090502211110.GC6135@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 03 01:13:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0OOn-0001SK-Oh
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 01:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbZEBXNZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2009 19:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752577AbZEBXNZ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 19:13:25 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:45650 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbZEBXNY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 May 2009 19:13:24 -0400
Received: by qyk34 with SMTP id 34so4478891qyk.33
        for <git@vger.kernel.org>; Sat, 02 May 2009 16:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mD1qooasdlf/R9esh0QqCt1KN9MXD7bcrS7p/LspS3c=;
        b=r+F68Tvm58pFp+7R9rY6urMeXXDjRx6GRrQhUi+3IhZGPGa6c8/MWU2ab40JumaSP8
         Xs3DH9Ykb/RBxxKuRr7RszMaHISME5t4vxcFOScfovMbnNL97BBtN/fAmkEhua3X0qcP
         gg/9IZm743r+zfQ5KozQ2WrUS9wdjeYmEXBEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RHF5R1p6gW5kjiKkKflFDYA0pDp/x1iIs7F9/5DTd0gf2tJjZ6mX+SET1BLMvq4v0w
         GvjhY0HYKatpNgqYrfoSpixAoE01LkhPpEzI/z9biexQQhFC2muFBjyeODF5xkp5pULF
         f2WR3G2I6TTAGT7hb2hisQ4xIBiFGshziFAS8=
Received: by 10.224.60.148 with SMTP id p20mr4509848qah.55.1241306004670; Sat, 
	02 May 2009 16:13:24 -0700 (PDT)
In-Reply-To: <20090502211110.GC6135@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118147>

2009/5/2 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
>> In any case, I *think* my point is that it's important to understand
>> that git uses content addressing; at first I was emphatic about the
>> idea of 'addressing', so I went with pointer terminology (which work=
s
>> quite well, in my opinion). However, I think the 'content' part is
>> more important, which is why 'object hash' is loads better than
>> 'object name' or 'object id'. Also, at least the documentation could
>> say that 'objects are addressed by their hashes', which says a whole
>> lot in one quick sentence about how git works.
>
> Hm, like chapter 7 "Git concepts"?

That's exactly the problem. It should be in chapter 0.

I also dislike the use of 'name' rather than 'hash'; a name is
something provided by the user, but a hash is something computed. The
use of sha[-]1 is even more egregious.
