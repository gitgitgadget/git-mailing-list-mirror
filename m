From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 23:21:32 +0200
Message-ID: <4817915C.6060009@gnu.org>
References: <4816E40A.4020700@gnu.org> <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se> <4816D505.1000208@gnu.org> <4816E0F6.3030302@op5.se> <200804292108.m3TL8moV011790@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	peff@peff.net, johannes.schindelin@gmx.de, srb@cuci.nl
To: =?UTF-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:22:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxHb-0004vD-59
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbYD2VVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754940AbYD2VVv
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:21:51 -0400
Received: from hu-out-0506.google.com ([72.14.214.226]:12333 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbYD2VVu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:21:50 -0400
Received: by hu-out-0506.google.com with SMTP id 19so182164hue.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=3aQn1ZxQ+l35OKB9DYj63yHOmU5mU8voIhYAwjarGJE=;
        b=YmpNEEcunzevDNKXMz4smfjWVcTOVV5hrzabzO8lZXbe7USumCtg20tK4o72jjZhPCV21OSkaKA/BXeSkc5enVL3WP3ouIDDNme0+zkrflazDF9FB9RWtldjmm9romyj0yLzOMrfzWqyoeQ1IeFdlZkytMcpSyYCtqjPOsYtil0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=HFOux16pralLGan0xnp4QBfluLV4W+N2j01OdGq06yRlEuHl5yVXuJavL/CGX3U0cyID/XGk7dZDjqDcGYAPPpT+5GnIjhSZ31jUArI2nB6ZV/eeIknvrBqzXU+m5211B5TfMdINS1FrX8C02yoF8akh3ppRiTHMHEkDDr2rQMA=
Received: by 10.86.87.5 with SMTP id k5mr352956fgb.51.1209504107703;
        Tue, 29 Apr 2008 14:21:47 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id 3sm395001fge.7.2008.04.29.14.21.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Apr 2008 14:21:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <200804292108.m3TL8moV011790@mi1.bluebottle.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80738>

> Sorry but then why does this patch have to even touch "git fetch"?  
> Isn't it enough to run "git remote update"?

I'm tired of answering.  Please read the cover letter.  It's not about 
adding new features (it does in patches 1 to 3, but only as means to an 
end).  It's about rationalizing existing behavior so that "newbie usage 
patterns" generalize better, and patches 4 and 7 are the most important 
(and the most controversial) in this respect.

Paolo
