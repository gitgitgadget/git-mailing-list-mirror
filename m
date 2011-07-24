From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 01/18] advice: Introduce error_resolve_conflict
Date: Sun, 24 Jul 2011 15:53:24 +0530
Message-ID: <CALkWK0mfVXTb+p_73YpxY-hhTCN-XbR9jz7iDTKK+uKiE5prkQ@mail.gmail.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
 <1311095876-3098-2-git-send-email-artagnon@gmail.com> <4E284750.4040104@cisco.com>
 <20110722223555.GB19620@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phil Hord <hordp@cisco.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 24 12:23:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkvqg-0003sT-BN
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 12:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751Ab1GXKXq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jul 2011 06:23:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50651 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab1GXKXp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2011 06:23:45 -0400
Received: by wyg8 with SMTP id 8so2235013wyg.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 03:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rvlIVjgYSEHVH6b7pe4Q2h/AxbSUTQlyMIik/LXdY/8=;
        b=aMnNfGXyS95z9M1Hg4ky2Bx1gS5yIayul81KKGVeocZ0gOoybIfwdpfWIxsdBEZM1k
         pxYXPAAViwkU/q7n6QXhsm1Lnsk2zPFqKo2MfJ4FyHvcPSsNkPtco2UMJIbCaSZnwg7i
         jmmtVuVOXgX9tPNz5hnO5vxMW6wrwIHm4kyow=
Received: by 10.216.155.134 with SMTP id j6mr2990083wek.81.1311503024096; Sun,
 24 Jul 2011 03:23:44 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Sun, 24 Jul 2011 03:23:24 -0700 (PDT)
In-Reply-To: <20110722223555.GB19620@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177738>

Hi Phil and Jeff,

Jeff King writes:
> On Thu, Jul 21, 2011 at 11:35:44AM -0400, Phil Hord wrote:
>> In either case, the comma after "Please" is wrong. =C2=A0(There are =
other
>> messages in the git code which make this same mistake, but there are
>> more which use "Please <imperative-verb>..." correctly.)
>
> Still, I think I find it more readable without the comma, and better
> still if every spot were converted to "hint: ". This question has com=
e
> up once or twice before, too, so I don't know that a patch removing t=
he
> commas would be out of line.

Ah, I was wondering about this too.  Even if a patch that goes around
removing commas or "Please, " in the entire codebase isn't desirable,
I can make the change in this series.

Thanks.

-- Ram
