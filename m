From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Re* [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Thu, 29 Aug 2013 23:28:35 +0200
Message-ID: <CALWbr2xe8jC4QnLTEOWJX_kn_FcQjSafPn=NKd3UsK9fO5f=_g@mail.gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
	<vpqhae97f8j.fsf@anie.imag.fr>
	<CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
	<vpqy57l4jcx.fsf@anie.imag.fr>
	<xmqq7gf58okw.fsf@gitster.dls.corp.google.com>
	<xmqqhae82nsb.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 23:34:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF9rF-00010y-4f
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 23:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142Ab3H2VeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 17:34:21 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:58560 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab3H2VeU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 17:34:20 -0400
Received: by mail-qa0-f43.google.com with SMTP id bv4so1494257qab.16
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 14:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oRQEuIosBb0VePj/gKTyQWj5eZb4F4HboB6qNBVEV0Y=;
        b=CqSx45p82vw0xPfVhI7urvdYz96TT0yiJki88iTQtv6ktjDg4tXYnbeZHnAM3AytKt
         JEKfLPtM05GF5cWRtDTJQSRF5Yrl88CMzRovob0SA5aZEzxT836u5md9XPSh3g0z9Af4
         4v74O+nLhDdgw05f+U6wW7h4O7Ut68y0yK3xv/UJkLZQuxus4i9Ip5WH6ZC+pzI1wCri
         NNypUeS/Q0fjRskNyqapkSl3T/rFvBwuVl1w5pWh/GGoktEoCAWcEgvpTm6cL+XBe0Wu
         Yy0GfucsLta6UzFU+DDYOYJ8UeMAJ+E2bav8L31/NGc8fhdYz/aEoF+UGVfryaM56u8m
         eQgQ==
X-Received: by 10.49.3.131 with SMTP id c3mr6504161qec.33.1377811715851; Thu,
 29 Aug 2013 14:28:35 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Thu, 29 Aug 2013 14:28:35 -0700 (PDT)
In-Reply-To: <xmqqhae82nsb.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233367>

On Thu, Aug 29, 2013 at 11:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> -- >8 --
> Subject: [PATCH 9/8] contrib/remote-helpers: style updates for test scripts
>
> During the review of the main series it was noticed that these test
> scripts can use updates to conform to our coding style better, but
> fixing the style should be done in a patch separate from the main
> series.
>
> This updates the test-*.sh scripts only for styles:
>
>  * We do not leave SP between a redirection operator and the
>    filename;
>
>  * We change line before "then", "do", etc. rather than terminating
>    the condition for "if"/"while" and list for "for" with a
>    semicolon;
>
>  * When HERE document does not use any expansion, we quote the end
>    marker (e.g. "cat <<\EOF" not "cat <<EOF") to signal the readers
>    that there is no funny substitution to worry about when reading
>    the code.

May I ask what pattern you used to replace all these or if you went
through manually ?
