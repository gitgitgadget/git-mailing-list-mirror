From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Wed, 25 Jul 2007 08:35:19 +0100
Message-ID: <200707250835.21181.andyparkins@gmail.com>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net> <200707241134.31950.robin.rosenberg.lists@dewire.com> <alpine.LFD.0.999.0707241144490.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jason Sewall <jasonsewall@gmail.com>, raa.lkml@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 09:35:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDbPZ-00026Q-9y
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 09:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761341AbXGYHf3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 03:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760144AbXGYHf2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 03:35:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:28200 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761701AbXGYHf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 03:35:27 -0400
Received: by ug-out-1314.google.com with SMTP id j3so300649ugf
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 00:35:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mqU3tcqyigAT8g9UFeWOEYnTAzg3ZccujVk9aHTvFnPBJZ95dZ/s7cxOeeeLlH9YJII2pewXPE8xeQ33hqhmFyfZcgPorSlvDGqzAPjaAEpVZLutIPqJWQe7QCsnuyFd65QAAjjE/0KBoHe/jT8zl94BbI46Il/oCunK2GWt3SM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AK2Eb3zEnYVlSVsT+/b6rJNfVRf8Q9KCffWWfoO8/F4y3y5+byjBNjoQRWbryCBIUyAEYP8JEI96Po4Ba+MTu3thPe2LpuGv8ooX7rX0KwrTELrWufwTZscuL2WVY2JYP6QyGvomoYxE9GlmlNGtDDf9ro3LE250Zvnbk/D0Ib8=
Received: by 10.67.97.18 with SMTP id z18mr1205058ugl.1185348925051;
        Wed, 25 Jul 2007 00:35:25 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id b33sm748340ika.2007.07.25.00.35.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2007 00:35:24 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LFD.0.999.0707241144490.3607@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53672>

On Tuesday 2007 July 24, Linus Torvalds wrote:

> So if you sleep for one second, the filesystem times will update by one
> second, but if you try to *synchronize* to exactly one second, it's not at
> all certain that the *filesystem* clock will be synchronized to the same
> second! Time skew is simply a fact of life.

I think it's even worse; if memory serves one of the Windows file systems 
(spit) only stores times to a two-second resolution.  So half the time, 
waiting for one second won't change the time stamp _at all_.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
