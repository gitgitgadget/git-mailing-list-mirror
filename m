From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] Use correct grammar in diffstat summary line
Date: Fri, 3 Feb 2012 08:11:23 +0700
Message-ID: <CACsJy8CcBB9OF=8a1hQEpDFzqsrkbpFKnVAcU65h_5Cnym90SQ@mail.gmail.com>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com> <7vhaza2qjw.fsf@alter.siamese.dyndns.org>
 <20120202142255.GA25871@do> <7v8vklxfe4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 02:12:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt7hR-0006TJ-Ge
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 02:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382Ab2BCBLz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 20:11:55 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54244 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172Ab2BCBLy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 20:11:54 -0500
Received: by bkcjm19 with SMTP id jm19so2676900bkc.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 17:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rvRvxQ85KfZFPmA5T4N54t6AHw3BnX06H7Gap0+pZyI=;
        b=Jy2JUNxvJ+JxYN0DQZULaSc9xbzlp6sWP51Q79cu8+CI8ksb7krM4IytY6zOwVvrab
         3s8XHYBR4WTjyAxSqH/Wf5LcobVB2BjKvyBlrOBPAe4WeXvoc5hju78KJr48lb47vEkv
         sBqf6lJLIhdn3u7ezgIPg84zsikPJSaHs2SMw=
Received: by 10.204.130.150 with SMTP id t22mr2450145bks.1.1328231513207; Thu,
 02 Feb 2012 17:11:53 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Thu, 2 Feb 2012 17:11:23 -0800 (PST)
In-Reply-To: <7v8vklxfe4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189727>

On Fri, Feb 3, 2012 at 1:24 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Wed, Feb 01, 2012 at 01:26:43PM -0800, Junio C Hamano wrote:
>>> Nice. =C2=A0Will queue
>>
>> Please also squash this in (resend looks ugly and it's hard to point
>> out changes). It makes the code look less ugly, use Q_() for gettext
>> poisoning and revert am input text back as Jonathan suggested.
>>
>> I take it --summary is un-i18n-able,...
>
> ... because?

=2E. of scripts? We have --numstat for scripts, but I see no alternativ=
e
to --summary. Does anybody parse --summary output?
--=20
Duy
