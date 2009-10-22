From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git describe is failing
Date: Thu, 22 Oct 2009 11:10:06 -0400
Message-ID: <76c5b8580910220810n389d065di349339ab38909ef7@mail.gmail.com>
References: <76c5b8580910220747w709d2b41s4f7b121e421e843c@mail.gmail.com>
	 <200910221702.39452.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 22 17:10:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0zIu-0003yj-Ih
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 17:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909AbZJVPKF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Oct 2009 11:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755670AbZJVPKE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 11:10:04 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:48798 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489AbZJVPKD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Oct 2009 11:10:03 -0400
Received: by ywh40 with SMTP id 40so5526929ywh.33
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wGL6xNDI6MuiWQGORT7rR7Q1FhUtnS5VUDPk93ORtB0=;
        b=p4DcqtkMWswbBh97MlVOIiY1rn3YkehGsmrC55XyTDuZgmp1+nzBh9fYf9/eEY6C8C
         szPVRsTfWaelKjt0hnyLPg8bh2dQOast5ifLktQy8D7geQpDLPZegNEwcBqWWrN+/Rao
         UiLPOmyCGuhH9CM6GS1t25amCnaOxww9fdCqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PjtEdhqDRZzdJhYKhsDnJe2xGeJ9qiRBU99F0qfVTn6fnEAKqxm6syWe/QrqqKtGgp
         VWkI7h3S/rrv7GoSIkpxix2MdZ792i0njF/HaJc4burSIeIlGqtLXb0YXlRX2BZ6Yvuv
         j3cnNFpPnK43j3kv375vC9u3ZRNwjvmygPEl4=
Received: by 10.91.143.18 with SMTP id v18mr11520921agn.71.1256224206894; Thu, 
	22 Oct 2009 08:10:06 -0700 (PDT)
In-Reply-To: <200910221702.39452.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131025>

> man git-describe:
>
> DESCRIPTION
> =C2=A0 =C2=A0 =C2=A0 The command finds the most recent tag that is re=
achable from a
> =C2=A0 =C2=A0 =C2=A0 commit.
> [...]
> =C2=A0 =C2=A0 =C2=A0 By default (without --all or --tags) git describ=
e only shows
> =C2=A0 =C2=A0 =C2=A0 annotated tags. For more information about creat=
ing annotated
> =C2=A0 =C2=A0 =C2=A0 tags see the -a and -s options to git-tag(1).
>
> If there is no such tag, it refuses to work. =C2=A0Annotate your tags=
, or
> try --always.
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
>

Thanks! It is working ok.
Although it is probably not the best error handling.
I believe git should fail with some meaningful message in this case...

Thanks,
Eugene
