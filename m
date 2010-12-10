From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] get_sha1: support relative path "<obj>:<sth>" syntax
Date: Fri, 10 Dec 2010 08:35:20 +0700
Message-ID: <AANLkTimYcdLmqj=db45nzsDShsAMTnsRJHhLJwtxDDai@mail.gmail.com>
References: <m3eiatfbg2.fsf@localhost.localdomain> <1289407021-30287-1-git-send-email-pclouds@gmail.com>
 <7vipz2fy98.fsf@alter.siamese.dyndns.org> <7v7hfifx00.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jnareb@gmail.com, dirson@bertin.fr,
	kevin@sb.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 02:35:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQrtu-00033q-U9
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 02:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757768Ab0LJBfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 20:35:53 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37204 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757558Ab0LJBfw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 20:35:52 -0500
Received: by wyb28 with SMTP id 28so2927223wyb.19
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 17:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=JA1Q52vEYl1iwgql4Ru18kFaEYM2hZbSoaxsEruS4WM=;
        b=E7pS0kU2OstW6D8e+Su0tProIEqaTtcPsbKIsGPPAeTvnMosg/I8xzKDzlKWbehEEG
         ATQMxRtUipQz5gHuPInO2axnKbF6680u7JDO8JTpO1fNaFDVPJV+wXY6n8grMy/Rv+na
         yFukGkiwC8Hqah9p/4L4fWD8PXCm+kB3kfOkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Ssds/ZZC4NkhNLOuU3RyRO2utucUiMLxcJkc3njVHTjxKupmCh/VqA6D+xXxdwEai2
         MKnq5IBcfpxE0xzAP8yoRaYUM2KCm9Faz7Ei0xJHuG0ISw1nJEYAsFOM9nXjAS/8cVv/
         8jL+UbiirrH761TpvyxWSyyrDrAMaYaq+Rc/I=
Received: by 10.216.177.9 with SMTP id c9mr213440wem.34.1291944951000; Thu, 09
 Dec 2010 17:35:51 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Thu, 9 Dec 2010 17:35:20 -0800 (PST)
In-Reply-To: <7v7hfifx00.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163376>

2010/12/10 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I think it is just the matter of moving "if (startup-info)..." logic
>> outside the "is the :$path lacking an explicit stage number" block and
>> having it after that if/else, no?
>
> Like this, perhaps?

Yeah, looks good. Sorry I missed that else block.
-- 
Duy
