From: "David Tweed" <david.tweed@gmail.com>
Subject: specifying "fast-forward" only in git-pull
Date: Wed, 28 Mar 2007 22:12:31 +0100
Message-ID: <e1dab3980703281412m78c2481bj9b9f7ec885dbbe4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 23:12:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWfRc-0004kh-NK
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 23:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbXC1VMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 17:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbXC1VMd
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 17:12:33 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:22493 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbXC1VMd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 17:12:33 -0400
Received: by nz-out-0506.google.com with SMTP id s1so2910651nze
        for <git@vger.kernel.org>; Wed, 28 Mar 2007 14:12:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VCjBdIz5yqWL4uNbsivMIhqSls3rs/Smtskdq9TAjFruHykkDwKAqXgsCU1pShCZCk58LpIpvz0lNwp6AyTzRfHj33ulqWTidOcx7iMnqd0+3KpDQzBVvK2xm5rcbwHvKvVOMHAdDpIFoMGTNpv6j2z7hGH79FmUcjGTMb0GkoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=G/NZdoDs1DYwenadY/Og+qiuCz07dWpGcW5BZreHpSxHbwnZ8mzh8xyoD2ASKj3UaIvbB+nZAuX0DXkE68p6i8xwxq9zvFKK1km1S6fPQpFOtzMvzBRBjyb4jJkf5fOAotvghi1jskGLh5RKueMhIPOmtEz8RyTFDhi+UXdxm/k=
Received: by 10.64.183.6 with SMTP id g6mr18984839qbf.1175116351542;
        Wed, 28 Mar 2007 14:12:31 -0700 (PDT)
Received: by 10.65.160.15 with HTTP; Wed, 28 Mar 2007 14:12:31 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43389>

Hi, I'm looking through the documentation on git-pull and
I see that I can specify a particular (sequence of) merge
strategies, but I can't see a way to say "only do a fast
forward, stopping if a fast forward doesn't apply".
(Fast-forward doesn't appear to be a named strategy,
which is why I can't use it with -s). Is there a way to
do this?

Rationale: I have a repository on several machines that
are synchronised via usb-stick. 99.9% of the time a fast
forward is all that is needed, and for scripting the
synchronisation I'd like to restrict it so that only
fast-forwards can happen automatically and everything
else I have to do by invoking git myself. (Somehow I managed to get
a merge that gave a weird result without me actually
noticing for a couple of days, which combined with
my chronological version scripts seemed to put new
trees onto an unnamed branch. I've got the repo sorted
out now, but I want to avoid the same issue in future.)

Many thanks for any help.
-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
Details are all that matters; God dwells there, and you never get to
see Him if you don't struggle to get them right. -- Stephen Jay Gould
