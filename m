From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Make git-prune submodule aware (and fix a SEGFAULT in the process)
Date: Mon, 20 Aug 2007 09:39:50 +0100
Message-ID: <200708200939.50955.andyparkins@gmail.com>
References: <200707021356.58553.andyparkins@gmail.com> <alpine.LFD.0.999.0708170956140.30176@woody.linux-foundation.org> <7vtzqxen8b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 10:40:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN2o4-0001ol-Hf
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 10:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbXHTIkB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 04:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754512AbXHTIkA
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 04:40:00 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:37244 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbXHTIj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 04:39:59 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1764207mue
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 01:39:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tu3iBUwTA2/jRPI1qRgp50wMEXHIChAW+4+k+EaURFrllVFJ+rGEbnKoP0RHkLl4rUicv07eAm9qpbfWVxlZa2HRkXMRKu+gfftJgJMSBMG9YhKhNbSUyDMdjS3LBTCKrJGWFzLuGDAcKIdzTZFeUR8NgzaW//kgfV9amyUt5q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WS1ii9PXv6yA7JcGls5dnx2HaeeDbCfUH40qALah4ZO08Oo4E9PHW7MkXeBLLZs8jthBNWuVObiylf9ruviZHXyMk7kUogP1ff3j/anBa3kd8AfDRefoLwxIUXV2NqTwqBHhrgLJ2jgcZO2JJtROxsLkFQ2p/l/KZ+hw2najN+4=
Received: by 10.82.186.5 with SMTP id j5mr7233181buf.1187599197215;
        Mon, 20 Aug 2007 01:39:57 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id b33sm9454491ika.2007.08.20.01.39.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2007 01:39:55 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <7vtzqxen8b.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56198>

On Saturday 2007 August 18, Junio C Hamano wrote:

> Andy, in the repository your fetch fails, if a fetch-pack
> without "--thin" before Linus's patch does not barf, that
> strongly suggests that the breakage you are seeing is related to
> this codepath.  And with Linus's patch, "fetch-pack --thin"
> would also be fixed.

I'm really sorry, somehow during my attempts to find the fault, the fault went 
away.  I think it's because I managed to get the fetch to work in some way, 
and from then on fetch completed perfectly.

The upshot of this is that I have no way to test this patch, until I manage to 
get myself in a similar state.  I'll wait until it happens again though and 
then try this patch.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
