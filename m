From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git
 push --mirror" update mirrors
Date: Mon, 28 Apr 2008 07:07:11 +0200
Message-ID: <48155B7F.8020202@gnu.org>
References: <4812DA50.3000702@gnu.org> <20080426170126.GC29771@spearce.org> <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org> <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org> <7vabjflvlh.fsf@gitster.siamese.dyndns.org> <20080427173446.GM29771@spearce.org> <7vy76zf449.fsf@gitster.siamese.dyndns.org> <4814E097.7030407@gnu.org> <20080428012613.GB15121@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 07:08:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqLb3-00069P-O9
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 07:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764425AbYD1FHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 01:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764255AbYD1FHX
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 01:07:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:47192 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763930AbYD1FHV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 01:07:21 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4788476fgb.17
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 22:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=AFr5i1RcjLzdPwaAdrUsWOaxQDJ7MAdVNaoDMxVQ84o=;
        b=h3ei/stsSVVyL78bES68HmdBwNmElzS5PbMQjQirI9OY1Wg32/etTr5O47BrFz5Y9Mol633Vx11Fd6Wsr5GQrXXRpD+hxcUguH7wrHPxAOQ55xZsz/Xbc4fjBKp54yBKBjDL1Oh6tPL1UrM+zwTJIr4twg7knKO4z+zx28WJ3s4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=i1IJO0p2W3crub5k/fqhlHkv3X/5jnx5PgGS/mT4rlsCoxrcXtbfHoT3opnqXSF2ubjYUDiLtsypEPiDNr8ed5Si4tzjhl9IAE5uUkh/gEH6CkjhAOzgI/S4hIsjxxxBHIJCDs2Moi2e2cI33TN66M72CclcippCdMI606UYg4E=
Received: by 10.86.99.9 with SMTP id w9mr6740225fgb.58.1209359240116;
        Sun, 27 Apr 2008 22:07:20 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id j10sm8180870mue.14.2008.04.27.22.07.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Apr 2008 22:07:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <20080428012613.GB15121@sigill.intra.peff.net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80502>


>> I think "git pull" is different, because it is more often fetching from  
>> one defined place (while Shawn said that he has a need for one-to-many  
>> "git push"es and so do I).  For "git pull", the branch config provides a  
>> valuable default more often than for "git push".
> 
> I think it is highly dependent on your workflow. I would have said the
> exact opposite.

Ah, to do so I always do fetch+gitk+merge (or cherry-pick instead of 
merge).  I use "git pull" (without arguments) only when I can blindly 
not care about what's on the other side, e.g. because it's Junio who 
assures it is good. :-)

I actually think I never use "git pull" with arguments, but that's 
evidently me.

Paolo
