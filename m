From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 2 May 2009 20:10:14 -0500
Message-ID: <b4087cc50905021810y28ab2019ob99857670383ba46@mail.gmail.com>
References: <200904242230.13239.johan@herland.net>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <20090424231632.GB10155@atjola.homenet>
	 <b4087cc50904241701jb78ce50m122fef475b0f1de7@mail.gmail.com>
	 <20090502155348.GB6135@atjola.homenet>
	 <b4087cc50905021136l5209777bs2209bab385deeef6@mail.gmail.com>
	 <20090502211110.GC6135@atjola.homenet>
	 <b4087cc50905021613j1d269757g8c599b484208c188@mail.gmail.com>
	 <20090502233232.GD6135@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 03 03:10:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0QEG-0004hw-Sm
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 03:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbZECBKS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2009 21:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbZECBKR
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 21:10:17 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:63285 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbZECBKP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 May 2009 21:10:15 -0400
Received: by qyk34 with SMTP id 34so4526384qyk.33
        for <git@vger.kernel.org>; Sat, 02 May 2009 18:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tl6BVbBd3hpxPCe6phq2KkoaRQfVG0ocCwddZIJ+ZrA=;
        b=WyjxkDQK0Kt6FWgd09KeIb1pj2Vd8LyVCOTnC0oo44682dmjni59XPrbOErCV5Sd9V
         NmH7pIXjvyyCWQE6ZYdc00YhzYlBqcQd80Wbv5SsfAKmirpOYXhClec32LxIFVTPZ5Se
         QUQnW7lhkhdx7V2pFohHKMsVkdahy3O1M6cpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vI7O/cfmY6ioTwn0ORHXKJOPvQLEojhcYb5c69dbmX1ICruXCxQDOt7DqTxpVwcqqO
         n3ot3kU7Xk2KXJF9Zx4IeThLCcSs8DSy8rmUbT64dZvdmkjpiK0y5JGwEaUI5f3goFEY
         yfwKhxfGVsQs2gR3YdOsiaUMhl+lVzumXpfgE=
Received: by 10.224.60.148 with SMTP id p20mr4556147qah.55.1241313014432; Sat, 
	02 May 2009 18:10:14 -0700 (PDT)
In-Reply-To: <20090502233232.GD6135@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118157>

2009/5/2 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
>> > Hm, like chapter 7 "Git concepts"?
>>
>> That's exactly the problem. It should be in chapter 0.
>
> I'm not opposed to re-ordering stuff. Though I often think that havin=
g
> commands and concepts "together" is better. =A0Maybe we just need tha=
t
> twice? Once the plain data model, and once a "hands on" version where
> the effects of the commands are described in terms of the data model.
>
> The former "sucks" for those that want to just "dive in" (but might
> still be happy to get told what their actions do), the latter sucks w=
hen
> you just want to look something up.

Indeed. I think the key is to split up the documentation for these 2 pa=
ths.

    http://marc.info/?l=3Dgit&m=3D124058631814726&w=3D2

The mixing of the 2 is what makes everyone unhappy.
