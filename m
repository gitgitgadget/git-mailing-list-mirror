From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin commands
Date: Wed, 11 Jan 2012 22:09:04 +0530
Message-ID: <CALkWK0=gvsvqk7Th7YY_eRzb+Ri52AZbOVokC98i9BXVAJOZEw@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com> <1326212039-13806-3-git-send-email-artagnon@gmail.com>
 <20120110183857.GC22184@burratino> <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
 <CALkWK0=bEPPv4rtPrMrQnk3MK=JY4-wwAByWPmzg86NBm_56iQ@mail.gmail.com>
 <20120111050404.GA13507@burratino> <CALkWK0kJpEXvBMV=D7h91sz7U2sLvXdW1UzomW0kG2bbM+byYA@mail.gmail.com>
 <20120111131854.GG32173@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 17:39:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl1DA-0001QP-FV
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 17:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974Ab2AKQjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 11:39:35 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:60726 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab2AKQje convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 11:39:34 -0500
Received: by werm1 with SMTP id m1so666489wer.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 08:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SqppMutjQOllwEhasHtevm8Vt6z7nVg3ebBVzaEYgMQ=;
        b=ZKBzfd7nogWmwgS9Wv5PqAuW3goFDpr5pfr76qt3DdVC8kEpjbRPdVRLtNdelFTDcS
         1oVTRmm5ldpySsnmJuvJletd/rDV5M1or0GVLfhzDMHgBm5UXQ+KgxbM50ItEV40E32Z
         VsQtwNVARKFkOkk/+yECDm16xWZJciLuGj8Mg=
Received: by 10.216.134.69 with SMTP id r47mr11353965wei.17.1326299970955;
 Wed, 11 Jan 2012 08:39:30 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Wed, 11 Jan 2012 08:39:04 -0800 (PST)
In-Reply-To: <20120111131854.GG32173@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188371>

Jonathan Nieder wrote:
> Honestly, moving code verbatim between files is very easy. =C2=A0Repe=
atedly
> rebasing a patch that carries out such a move would presumably be
> hard, though. =C2=A0But this pain is unnecessary!
>
> Just like I haven't been reviewing the code movement, I'd be perfectl=
y
> happy to read a "patch" that says
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"And then we move the functions from the f=
ollowing list to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sequencer.c. =C2=A0I'll send a patch doing=
 so once work has settled
> =C2=A0 =C2=A0 =C2=A0 =C2=A0down in patches earlier in this series."

More than the pain of rebasing the patch everytime, I guess what I'm
asking is: is it worth stretching my foresight like this?  Once the
code is in sequencer.c, it just becomes so much easier for me to write
scratch code to help me wrap my head around the generalization.  If
the answer to the question is yes, I suppose it makes sense to submit
the good parts now and work on the other parts over an extended period
of time.

-- Ram
