From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with
 NO_NORETURN
Date: Mon, 20 Jun 2011 17:31:56 -0500
Message-ID: <20110620223156.GA695@elie>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
 <1308445625-30667-2-git-send-email-andi@firstfloor.org>
 <7vsjr4b3tf.fsf@alter.siamese.dyndns.org>
 <20110620213001.GB32765@one.firstfloor.org>
 <7vfwn4b1vb.fsf@alter.siamese.dyndns.org>
 <20110620220347.GE32765@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 00:32:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYn0u-0004Vp-6A
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 00:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147Ab1FTWcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 18:32:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64399 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab1FTWcE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 18:32:04 -0400
Received: by iwn6 with SMTP id 6so1576349iwn.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=sFzJFjsyOc//bxzU/wPnnMmyYzgVymiHnHPohOwoMts=;
        b=tyfjSE6n1B/BZWcp+EpDv7VP5lSoPi8o73vCrRzPqBgGYVA1Bnm/nROBnv0/oEN0h6
         70ZEONW+VM8oOWg6Uic0RdWL5FwnACbvlF/cO7Ew9aSc17o7qTlPWugw0Mt5wnDwZM3b
         BpSnZLs5ttGfhuHQkSbSUORWhA41udSuickGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fhJC+XsCHxh1QMjLBfMm22A5oqgPCrBjx1ZxDcGGeE+7GZkxD5gqC9VaKLZ9y18JB1
         H2aH4986+pH+NlZOC/W6JjsQahCIKLDhpSfOV2esIwAeHYALpkNpjsokoS/g0mnmsdBC
         UO5Dy6o45IJkySQ2LXpgtExis3hhS6G//a3ss=
Received: by 10.42.28.72 with SMTP id m8mr363470icc.242.1308609123494;
        Mon, 20 Jun 2011 15:32:03 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.sbcglobal.net [69.209.79.158])
        by mx.google.com with ESMTPS id q15sm3441103ibb.14.2011.06.20.15.32.01
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Jun 2011 15:32:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110620220347.GE32765@one.firstfloor.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176102>

Hi Andi,

Andi Kleen wrote:

>> Sorry, I do not recall suggesting to add these dummy returns. The NO_NORETURN
>> workaround (your [1/3]) is what I remember.
>
> It was just a logical followup to quelch the warning storm NO_NORETURN 
> caused.

Please remember to think for yourself. ;-)  Junio generally gives good
advice, but if you don't see the wisdom in it, that's the time to ask
questions, not blindly do a wrong thing.

In this case, since the NO_NORETURN knob is to work around a gcc bug,
wouldn't it make sense to add a -Wno-something-or-other option to
BASIC_CFLAGS or COMPAT_CFLAGS when it is set?

Hope that helps,
Jonathan
