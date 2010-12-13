From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] get_sha1_oneline: do not leak or double free
Date: Mon, 13 Dec 2010 13:27:03 +0700
Message-ID: <AANLkTimMb2ouZQbgOFB_JTuJb99vzC=2CzeUH3TnFU8M@mail.gmail.com>
References: <1292209275-17451-1-git-send-email-pclouds@gmail.com>
 <7v1v5m6w26.fsf@alter.siamese.dyndns.org> <7vvd2y5h63.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 07:27:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS1st-00088b-Qa
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 07:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531Ab0LMG1h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 01:27:37 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44414 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851Ab0LMG1f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 01:27:35 -0500
Received: by wyb28 with SMTP id 28so5552469wyb.19
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 22:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0k5SFlglMVEjAAauiQ4wKVgCCIGbQQnmtqaw/VuSP1A=;
        b=oNYJvV4/u94FuzmEPB3hDz4R2Jb6LFMh6rCO9jaXjsPaMUQ8xHrWM4koh/WZMUoW/N
         suzhYUZ6iT1xA0dScdpfCB117kcTCAPdKVz3kC3vwEenfAHaqwPAnVpQEdXzHZqZA8jL
         gX88RBPbDmoutPPwJSfN3JCIssfRuFm8ET58g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CS+raDD3tfxwNb2c99RGFC0ZuMnnWQiKr8vV6HDYMMvojV4G7D1LVe6QyT/SdTkihl
         AVEAv0bnGCIgIr7eDRIosPrN/h0AU3soeYJ6iOU2Pm1bqYAmDbtQvC9C6cg3f8rJ2gYd
         JyeqCtVesdSmE8u8mjjmBUbXoAMHVSz73r/uU=
Received: by 10.216.24.134 with SMTP id x6mr2587866wex.34.1292221654016; Sun,
 12 Dec 2010 22:27:34 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Sun, 12 Dec 2010 22:27:03 -0800 (PST)
In-Reply-To: <7vvd2y5h63.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163516>

2010/12/13 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I think the following is easier to read and conveys what the code is
>> trying to do more clearly. =C2=A0No?
>
> This time with a proposed log message...

Much better. Thanks.
--=20
Duy
