From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 17:31:38 -0500
Message-ID: <4B0DB04A.6020209@gmail.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <20091125203922.GA18487@coredump.intra.peff.net> <7viqcytjic.fsf@alter.siamese.dyndns.org> <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org> <4B0DAC9F.2010205@gmail.com> <7vljhuqm84.fsf@alter.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 23:31:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQOp-0000k9-22
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 23:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758898AbZKYWbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 17:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753401AbZKYWbf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 17:31:35 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:51728 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000AbZKYWbe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 17:31:34 -0500
Received: by ywh12 with SMTP id 12so200469ywh.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 14:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=6RmC26T6rCRtLoeJ20zeIpnui9GchI2qg0+X8g3UEWY=;
        b=t47VDZUy6od1mqfso1Sy3MwUPvWWQHtvm2rkBAihdzZuHiA8v+6u+aT0x2WQDkkIxU
         whUkkoz3gb6jdes8kHVCDHAb9A2ynPlee8aO3GBTbuiGLi7C9cPgxJjnePyjjDkHC5G6
         5Rrqf5/uisV7fRZe+hsg/HyudT+Y+pDpl278A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=DckxxbuOhaT/4BXP31h43CcYNBCpEnnBCd78CIuUKfhT8Rzy30k4YHPs8knObJMyIR
         xQOFzugOEGwxzrbTP7UT7vaDaXYyzdibtAa9P3yi5JHz17/eMod75q70VIKu4I9eIzMI
         H22aGBMQKdAEBVF3tLhD/cPWLDjlVyq7mOEgs=
Received: by 10.150.170.2 with SMTP id s2mr14620661ybe.222.1259188301013;
        Wed, 25 Nov 2009 14:31:41 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 7sm37852ywc.51.2009.11.25.14.31.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 14:31:40 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7vljhuqm84.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133688>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>> To make the reconciliation  even more difficult, some git commands
>> will also work on out-of-tree paths.
> 
> I think people know my feeling towards "diff --no-index".  It makes many
> nice features invented in git to people who do not use "git" (e.g, to
> compare files outside of control of git using --color-words).  If it
> happened in an ideal world, it wouldn't have been done as a patch to "git"
> but to something like "GNU diff" to benefit people who do not even want to
> install "git".  But unfortunately that wasn't the way it was done.
> 
> It has turned out to be an unnecessary maintenance burden ever since it
> was applied and every time we needed to change small things to "git diff".
> I would not be very unhappy if we need to ejected it from "git diff" if it
> turns out to hinder the necessary UI changes too much.
> 

git-diff aside, I would be much happier with git's interface, and I 
think new/occasional users would be also, if it was consistent across 
all of git commands. And even more so if git's conventions matched most 
other commands on my system of choice.
