From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH] contrib: remote-helpers: add move warnings (v2.0)
Date: Wed, 14 May 2014 09:57:42 -0700
Message-ID: <CAL=YDW=W1-fDXzQJFbv0xASErzq8gtKE1K_P9FVAYCAEWdEUNA@mail.gmail.com>
References: <1400016596-13178-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq7g5pmj5r.fsf@gitster.dls.corp.google.com>
	<53729b2150a84_34aa9e5304e0@nysa.notmuch>
	<CAL=YDW=jCEtfEmvO-173jpJB0f3mJ2+efihprVw+MpVjxyyExQ@mail.gmail.com>
	<5372acd699145_7e25141b300bb@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 18:57:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkcV4-00080i-Ad
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 18:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756324AbaENQ5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 12:57:46 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:53187 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756317AbaENQ5n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 12:57:43 -0400
Received: by mail-ve0-f175.google.com with SMTP id jw12so2751703veb.34
        for <git@vger.kernel.org>; Wed, 14 May 2014 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6SiInDxn2EwAlVHOe/0fFDKia028wsT17pWOZAqIm0g=;
        b=N/rJtffjimBswEMMCmflK2cin1PgNmubtGnG1gKNXx8+SsO/m5Dez5H19AA/NsLppx
         zGUGNvXBW4BUm715Mf4b13AZc7XhnUgodabDFux0Gc02+NMBb1hhaO13vKEiqLSOidRn
         /w3+DqJd25xAizQw1gylBZDtHufgcUU1gmWiLucUYJFsXx7Al6qugVqMfH8EthvGENJU
         7FwaT9GpBuzIpGyU+fN5IHYGzCqktrnRrdBN23reSKFmlkSD3wlFvnK+UKUfX1RzHYST
         0pgS0yDbvnGzFTmWbVrZS/k3uH7DdWo054taO+MEJ5LJRlOoEt1ztV1hVnv1gve3x2kT
         VJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6SiInDxn2EwAlVHOe/0fFDKia028wsT17pWOZAqIm0g=;
        b=GbUpDLe8/0my93Kl35WtGo8BbW0D7MsmHSBjDbWeW/idYEfycyZzXNeYD/fV/IMOFh
         6P9fOppZuPC3+WZkoS90EHUg1wlMET7fsPTzrdujyJhcHcn/NyKmQZK0J6gEzoYGVbMg
         5Mi93oiarCWObX7AFD2cThwvz3Nc9OAr6Ff1/tBJW1NoNg2NY59/5X+eRXLBUbv7POW9
         K2CVe0ojwfC44Wi0Q8syKea8TaAM8pzhMRiYzd/Xjz5CkJ3bpRmah/m0azjOBvJc4Ee7
         SwkXpPliurTvBCkOpWp6DvbyvfGFQ0SfSFcgKngngRNMpj8SdHu1tXE/49n8gEgBbLh6
         D3IA==
X-Gm-Message-State: ALoCoQmPPeWKC9V8AOnQjVsiFt+qMwzF3YEaz+wQCwvHyTaB9u7EN/x38MEI7UNAW9BfMPFKvI3z
X-Received: by 10.58.34.143 with SMTP id z15mr1074715vei.52.1400086662459;
 Wed, 14 May 2014 09:57:42 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 14 May 2014 09:57:42 -0700 (PDT)
In-Reply-To: <5372acd699145_7e25141b300bb@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248925>

On Tue, May 13, 2014 at 4:37 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>> Could you please calm down and adjust your behavior.  This constant
>> hostility and rudeness makes the mailing list very unpleasant.
>
> I explaind that to him multiple times. In the mail I replied to he is
> once again assuming I'm a *insert-your-favorite-non-smart-adjective*,
> and explaining to me what a regression is.
>
> How many times must one repeat something before one is entitled so thay
> something is not "getting through the skull" of another person? 5? 10?
> 20?
>
> But fine, let's assume I do have to adjust my behavior. Maybe I should
> have said "it doesn't register in your brain", or just "it fails to grab
> your attention".
>
> But if I have to adjust for saying that (which was true), what do you
> say to Junio for saying this? (which was not)

I know I shouldn't but I will respond anyway.

The problem is about you and your behaviour. Not Junio or anyone else.

Please adjust and stop your constant hostile, confrontational and
abusive behavior on this mailinglist.
Your behavior is not a winning strategy and will only result in
alienating you and impair your interactions with
the rest of the git community.


If anything, Junio have shown an amazing amount of patience and
restraint with you.
I would not have tolerated your kind of behavior in any project I am
maintainer for.


>
>> > Stop this idiocy.
>
> I presume nothing, because Junio is a riskier target.

Please follow Junio's advice. It will benefit both you as well as all
other participants in the community.
