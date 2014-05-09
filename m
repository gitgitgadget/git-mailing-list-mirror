From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 18/25] contrib: remove 'emacs'
Date: Fri, 09 May 2014 09:53:43 -0500
Message-ID: <536cebf798633_6bf0154f30c67@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-19-git-send-email-felipe.contreras@gmail.com>
 <CAFcZeCqbF54-KjHU1R3pC6XgWi21KcpRGB7HcbfSGyvTScQU2A@mail.gmail.com>
 <536c91f079e71_2bf0e952f0a@nysa.notmuch>
 <CAFcZeCo5mCfnUN1uBiaZnD6DL6y8hPhK5MPts5raLCTGwJX9Gg@mail.gmail.com>
 <87d2fnropz.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
To: Alexandre Julliard <julliard@winehq.org>,
	=?UTF-8?B?RGF2aWQgS8OlZ2VkYWw=?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri May 09 16:54:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WimBU-0006oK-Kr
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 16:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851AbaEIOxu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 May 2014 10:53:50 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:56148 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbaEIOxt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2014 10:53:49 -0400
Received: by mail-yk0-f179.google.com with SMTP id 19so3507834ykq.24
        for <git@vger.kernel.org>; Fri, 09 May 2014 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=YQWzPOkwG2bvr+A0CSrrvp+6JPaPVOPfUabaQNEfnHY=;
        b=uC8sZnldwnvp4kjhmlOIt1uLsUBS2E4w8NylmW3Jme6vyhZ5HocZDNrX6+HoyHl2vB
         g9xSbh4WAb+w27YPIkC4tk1bg0Yz0sH8S4BR4lyitIB/6h+MqDbope8OGf6rJIwe3mBY
         C4tfRplSUmXvURBMgK9LMDWNUN8vKIvauoE+yeaM9qEM9m9gjAX4Yk8TDTs199Q+q+dP
         fMix2nR4s7m5UqhTBv18KyvT/iHSCMTYDaks4sWEEWCEEaVLu7VhXbqb8WKtK2//Ycxz
         ce5UEcMCg8YwnV0TTsJH3yLJajkaW2PMU4wE9nWDNlbHgXM9qcbxunDxTk2f9wMnDKIl
         +nIw==
X-Received: by 10.236.230.41 with SMTP id i39mr15665533yhq.14.1399647228865;
        Fri, 09 May 2014 07:53:48 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id m69sm6465256yhn.16.2014.05.09.07.53.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 07:53:46 -0700 (PDT)
In-Reply-To: <87d2fnropz.fsf@wine.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248562>

Alexandre Julliard wrote:
> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>=20
> > 2014-05-09 10:29 GMT+02:00 Felipe Contreras
> > <felipe.contreras@gmail.com>:
> >
> >     David K=C3=A5gedal wrote:
> >     > What problem does this removal solve?
> >    =20
> >    =20
> >     Please do not top post.
> >    =20
> >     a) What problem does it solve by staying?
> >     b) Where are the tests?
> >     c) Why it cannot be moved to an outside repository like may oth=
er
> >     git-related tools?
> >
> > Fair enough. I guess the target should rather be to get it into the
> > emacs distribution.
>=20
> It's already in Emacs in a different form, as part of the generic VC
> support. And nowadays, users are probably better served by using
> something like Magit anyway. As far as my code is concerned I have no
> objections to removing it.

All right. Thanks for the clarification.

--=20
=46elipe Contreras