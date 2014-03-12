From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: Re: [PATCH][GSoC] parse-options: Add OPT_SET_INT_NONEG.
Date: Thu, 13 Mar 2014 02:33:02 +0800
Message-ID: <CAGqt0zyPOGY18EhWPMTGdtU54NDYS0ppRHhemhDArX7oE-0LGw@mail.gmail.com>
References: <1394535016-9424-1-git-send-email-yshuiv7@gmail.com>
	<CACsJy8Dq5QyZdzCtew0qF37qThH8+05iTrD-ZOeBgbEukmCY5Q@mail.gmail.com>
	<xmqqr467mfrg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 19:33:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNnxl-0006YE-Dj
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 19:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbaCLSdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 14:33:05 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:56272 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbaCLSdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 14:33:04 -0400
Received: by mail-ve0-f179.google.com with SMTP id db12so10495184veb.38
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 11:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XwyWpTtjYJ1yNamchfIvMIP3gQq6h5Ws4mr7WjnFpcM=;
        b=dBiei0wysbUFhajBpDaambNpGteYMnoB9GT6yzkgsUqVcbCyC+sxWLAhAfF5g15qO6
         66qco+gcdf8egQm39qPpDezoqBzFpxZY7rbNHFxXMugRE2hNuk2B4CClhhzx2L6hpMW+
         V4Sp1KELa4G5/sKG2qryjOLM8rFKOtRkWurfVV6vMakYUqcJ2Exi5WoCH+FHIZ4+/yGz
         YPc6vdfBm8A104qRNnVuK9H6sRP8XpH3V6GJL1mLlRwpxli/WvrDlgwwzl2FpdoWVM2E
         8wIUIWEkDTeVxbNsG8Xo1lyu98NgFT1HUXHO62VMXKoUsUCE1mOxNgOttqx5z3/HIw7h
         8evw==
X-Received: by 10.52.237.167 with SMTP id vd7mr448934vdc.54.1394649182649;
 Wed, 12 Mar 2014 11:33:02 -0700 (PDT)
Received: by 10.220.89.209 with HTTP; Wed, 12 Mar 2014 11:33:02 -0700 (PDT)
In-Reply-To: <xmqqr467mfrg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243958>

Hi,

On Thu, Mar 13, 2014 at 2:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> By convention, no full stop in the subject line. The subject should
>> summarize your changes and "add ..NONEG" is just one part of it. The
>> other is "convert to use ...NONEG". So I suggest "parse-options:
>> convert to use new macro OPT_SET_INT_NONEG()" or something like that.
>>
>> You should also explain in the message body (before Signed-off-by:)
>> why this is a good thing to do. My guess is better readability and
>> harder to make mistakes in the future when you have to declare new
>> options with noneg.
>
> As I said elsewhere, I am not sure if doubling the number of
> OPT_<type> macros as your micro suggestion proposes is the right
> solution to the problem.
>
> What are we trying to solve?

OK, I'll switch to another micro project.

-- 

Regards
Yuxuan Shui
