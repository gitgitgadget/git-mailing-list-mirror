From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What is the scenario for a commit with 3 or more parents
Date: Thu, 29 Jul 2010 15:50:33 -0500
Message-ID: <AANLkTinT4SpdYHfaiwPqVHDEaN6gEr-3kyHbE4-g=HN5@mail.gmail.com>
References: <AANLkTikMRa_LrD2fU9Piv3GW2H0r7Jf_9s5iM0wc9t6s@mail.gmail.com> 
	<20100729021946.GG25268@spearce.org> <AANLkTik-wOB-iEGK8EnW1Rdk9wwc1E86tYoBU26WepYJ@mail.gmail.com> 
	<C77AA970-4288-487F-9568-E86CF776FCED@gmail.com> <AANLkTikpLHdMzbpix8jnyS6YwSkgie=Ts44AJP5dA4=T@mail.gmail.com> 
	<7vzkxarqry.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joshua Juran <jjuran@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Bradley Wagner <bradley.wagner@hannonhill.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 22:51:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oea4B-0007y0-Tv
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 22:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439Ab0G2Uuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 16:50:55 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36262 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab0G2Uuy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 16:50:54 -0400
Received: by yxg6 with SMTP id 6so292951yxg.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=+Ef76jyginV8w3vmaEIQAesGsp7+NYXkZIc3tPloROw=;
        b=ecYZ1XwHpayKG95KciCR13/Md+jHhyPJj2f7s5PgjHJNl39HstS6wNJ5cBAs55sUa5
         ztzSZ5RzyVd9PnVBVDGH2A1KWcF0DuhhIcU+AeI+zEOxTwkF9C5/kmvHvcls11O983F+
         oY0OONRqvkMsC18PmrBU135iJinrkhIpgPhJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=N0dXv0GPiX8u5QqLHEYnwE6Trnbv42cR3vgAs9pb4LOq2oFjWgFdx9HHrikm4ooZyw
         DGRH1+NF/Fwp+8x/3tG9BMkzYijfp1lrZ/qB2N2L95OKvKtny0EL2iIdEHEm/6RNbAES
         T7VGyVotRLeRCA98BJ4+/YWDE0+dwR5gB+ztg=
Received: by 10.151.17.4 with SMTP id u4mr1802520ybi.346.1280436653223; Thu, 
	29 Jul 2010 13:50:53 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Thu, 29 Jul 2010 13:50:33 -0700 (PDT)
In-Reply-To: <7vzkxarqry.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152197>

Heya,

On Thu, Jul 29, 2010 at 15:12, Junio C Hamano <gitster@pobox.com> wrote:
> Compared to that downside, it is not worth to use an Octopus, only to have
> a smaller number of merge commits and a cool-looking lantern-shaped merge
> commit in the history.

Ok, do we have _that_ documented anywhere?

-- 
Cheers,

Sverre Rabbelier
