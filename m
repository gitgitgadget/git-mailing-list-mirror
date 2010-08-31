From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 00/17] Begin gettextizing Git
Date: Tue, 31 Aug 2010 17:18:51 +0000
Message-ID: <AANLkTinKgOdgTpORf-NSJ1wpURw9xOkQ3rXZvmV6XtBb@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
	<7v39tveq0j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 19:19:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqUU8-0006VC-E8
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 19:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612Ab0HaRS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 13:18:57 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64386 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab0HaRS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 13:18:56 -0400
Received: by pzk9 with SMTP id 9so2525092pzk.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=eaY12tuhyFFt1LoGbj5XsiQTHXMv3tFfo0GHA4fHVbU=;
        b=vS06yfZKhUC98QVyCAQ4J6n+P/hhKaM5lIjvyuCSlKHJZFmhHl6N+32xgw5X+l0wve
         F5nJasinScWCEnac7mg/PvAeC7ZwpSWTN5uN+yGZWS2W9iXEo4OlqemPmVhXnDtme0I2
         Ep37ygZRkjlZJktRgfr5CAFDs9vK8qDxO17Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OaNGscPemK0mOJi7Io2fjQA8CfOSIcDsI02xxhy1ZB0rkI2gs/FzQvM/RLXzLB5E8Z
         9JNcYUaTKp2FqvzkbZaXHZyVXfxDUL8yBI7m+C+bgeB9qptEgiVp7rVQCtld6m5qgpMq
         Hkrx1BVKz2c4hpp4zuXV8S98sN9v/fcEa7Yk8=
Received: by 10.114.127.18 with SMTP id z18mr7294425wac.171.1283275131550;
 Tue, 31 Aug 2010 10:18:51 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 31 Aug 2010 10:18:51 -0700 (PDT)
In-Reply-To: <7v39tveq0j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154943>

On Mon, Aug 30, 2010 at 21:42, Junio C Hamano <gitster@pobox.com> wrote:

> Thanks; will queue them.

There's a v2 available here:
http://github.com/avar/git/tree/gettextize-git-mainporcelain-v2

Or: git://github.com/avar/git.git gettextize-git-mainporcelain-v2

It:

 * contains the "gettext: Make NO_GETTEXT=YesPlease the default in
   releases" patch. Please only apply that to next, not pu.

 * A "Makefile: use variables and shorter lines for xgettext" patch,
   which implements Jonathan's suggestion of using more variables for
   the xgettext invocation.

 * Elaborates on the issues facing us in the "gettext.c: work around
   us not using setlocale(LC_CTYPE, "")" commit message, and mentions
   the perror(3) issue.

I didn't send it to the list because it's a huge series and this is a
little fixup, and I rebased it to inject the Makefile patch early in
the series, which isn't easy to express in a v2 PATCH.

Thanks.

I can also send it to list if you want, but I suspect this is better.
