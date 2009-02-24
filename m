From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 00/23] builtin-remote improvments
Date: Tue, 24 Feb 2009 12:49:47 -0500
Message-ID: <76718490902240949i6ef70fc9i88b7a30a069ef374@mail.gmail.com>
References: <cover.1235461736.git.jaysoffian@gmail.com>
	 <1235472816-52420-1-git-send-email-jaysoffian@gmail.com>
	 <7v7i3fhgye.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 18:51:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc1RA-0002w4-9f
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 18:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758819AbZBXRtu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 12:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758499AbZBXRtu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 12:49:50 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:9270 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758161AbZBXRtt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 12:49:49 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2573308rvb.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 09:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dAb6aT31sCHMB58OKZBA0NNIdteY8TP2QFe40XSPId0=;
        b=p3pCIwB4RbQEBQAvgdypReFbjNCLD2RD9q+mviodKb+AmFBt4r0fVSMq8BzNBsN6mK
         7AEvLVlvn3IwXh7S2uk/QsHXibrYsXBlS0lMwx4Hv7CrAe2YRIkSG0V4qquGs/hl87KM
         Yjm3DUtUSelZtaSjptMLhtTQrdHT54HNi/MOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jko+NFkx36MW+z3V6Cfxj1FTlRtZuLt0IkPM4iUbim9qdRC1xfIaqOgXcBGlrqmnqm
         IQ/2lzat0HfS6nRfpsCyG7AF0aM63BO5ngzelJJMwAccxEn1hS9Ri/FyRzz3UnSc8kaB
         vOla9+taHuOsww+pu3xKVr5uFbht1+gvDqv7Q=
Received: by 10.141.196.8 with SMTP id y8mr2709945rvp.101.1235497787172; Tue, 
	24 Feb 2009 09:49:47 -0800 (PST)
In-Reply-To: <7v7i3fhgye.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111325>

On Tue, Feb 24, 2009 at 12:39 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> I don't mind pulling, as it is less work for me, but it would make
> harder for others to see the changes in flight and discuss, so...
>
> Even though I'd need to re-read them before merging them to 'next', I=
 also
> think the earlier remote-set-head series and Jeff's changes on top of=
 it
> looked more or less reasonable. =C2=A0Perhaps I should rebase them on=
 top of
> 'master' before moving them to 'next' and then you can build on top, =
which
> would reduce your new series by about 10 commits.

Putting Jeff's changes first reduces churn a small amount, as we don't
introduce new code just to change it a few commits later in the same
topic. So it keeps the history marginally cleaner. That was my
thinking anyway. Otherwise you may as well just use what I sent last
night and let me add one more patch on-top to clean-up that unused
variable that gets passed to get_head_names().

Your call. :-)

j.
