From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 20:57:20 +0700
Message-ID: <AANLkTimh2E5i5Jgs2z3t-ai1pVkiNs5VdiP7T4pS_fzL@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <87k4h34bhj.fsf@catnip.gol.com> <7vr5bbupj4.fsf@alter.siamese.dyndns.org>
 <AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
 <4D58D2DF.1050205@viscovery.net> <AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
 <4D5906FD.7030502@drmicha.warpmail.net> <AANLkTi=RcJfEGv966VCrOMPE640xyyw1wEFFkdA9fFWq@mail.gmail.com>
 <4D59316E.5090203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Miles Bader <miles@gnu.org>, Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 14:57:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Poyw8-0005WN-Bz
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 14:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab1BNN5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 08:57:52 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42823 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab1BNN5v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 08:57:51 -0500
Received: by wwa36 with SMTP id 36so4898742wwa.1
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 05:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=lCAYVSLZolJlymY3LAsha/+Z1yfuMkqW+zbOBMVbzl0=;
        b=rQDIbNXhUDF9jugJkV91lQ082knGWY1Lo+BAw+7/g897rDxD2YF+uLRtB1XDu5Gy4r
         8vXTGlTde1mP2JLdRBGNgVxr0y7AdqbDqg7InH1am4UZIE/y+++Fok1MclDyD5OrLPpp
         vxQd94QBpYAvYz6y9Ly6CTimn+pzWgt7e/o6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qBo6ceCdYXZR8g5Cv1NIXJxUvKjj8rD2j2Fc0b15p33SLtflhmQrTzUSoRvzUSqDBi
         UEt8xX68u9MecB94iwZ4LQ2Cme1/pY/D7wNSr++bBvDQTlmB/diLnv3zWf9FQHekwg9x
         7sWQETKILK7g3RpdbcjD8hmi3IP2mMAn04uB4=
Received: by 10.216.24.135 with SMTP id x7mr678679wex.43.1297691870115; Mon,
 14 Feb 2011 05:57:50 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Mon, 14 Feb 2011 05:57:20 -0800 (PST)
In-Reply-To: <4D59316E.5090203@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166712>

On Mon, Feb 14, 2011 at 8:43 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Nguyen Thai Ngoc Duy venit, vidit, dixit 14.02.2011 14:14:
>> On Mon, Feb 14, 2011 at 5:42 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Full disclaimer: I have an alias "staged" for "diff --cached" myself...
>>
>> Be careful with your fingers. There's a command named "git stage".
>
> I know. Can we remove it as part of 1.8.0? It's our only builtin alias.

It's out in the field. I don't think we can just simply remove it.
It'd be nice though to have a mechanism to override (or even remove,
in your case) builtin commands, or at least porcelain ones. A feature
with a big "your feet is expected to be shot by yourself" warning.
-- 
Duy
