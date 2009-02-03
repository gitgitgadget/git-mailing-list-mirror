From: Tim Visher <tim.visher@gmail.com>
Subject: Git -> SVN importing
Date: Tue, 3 Feb 2009 10:17:17 -0500
Message-ID: <c115fd3c0902030717u6a8f3bbck3027cf74715c79a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 16:19:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUN39-0001qU-Dd
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 16:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbZBCPRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 10:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbZBCPRT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 10:17:19 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:54450 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbZBCPRS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 10:17:18 -0500
Received: by yw-out-2324.google.com with SMTP id 9so718548ywe.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 07:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=YUBcyFADelRhX/u7DaTJ0ACTP5KWXDWYttcbAfOYorA=;
        b=cdv1Bkl9r3oKs4rjTotxe4xDLNdJKY0g5lpbNuCJPPAJ/6MD0F8PMLHKDW0xeQGjtI
         UQdHLx0t+DTOve3ebp+smpHFyz3SByvdvEqQZuIaTj2Bfm+OmlzDkH3aSZm8G1PIMgAP
         RYivsHycbeLXURljhTjQFlA7ofS8I7wVB+X1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Af675Wb2IvwkNeoe9JOytDQIDrrpJW/us9HL6SB5CAb2+bZh2tOtWR4AcqKLdSrlWj
         VTTNGsECVvWxYgjfreKb8msBvgYpQAbajQz2vTHM9nzZ6hpM3z03rqNCGv58uxI6SbXt
         oDv3G7+gKmopX84NSAd+pPKA5d8u/kAJE0etw=
Received: by 10.100.119.17 with SMTP id r17mr1746973anc.130.1233674237592; 
	Tue, 03 Feb 2009 07:17:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108198>

Hello Everyone,

In light of company decisions that are yet to be known, we may in the
future be stuck using svn.  My team and I really want to experiment
with Git, but one of the concerns that my supervisor brought up was
that in the future we want to be sure that we can relatively
painlessly bring the history into svn if required.  Obviously, it's
expected that we would loose the local branching history, but we would
want at least the published information to be sucked back into svn
without change, if that's possible.

I figured that someone would have to have done this before since
git-svn is so magical.  However, I thought I'd ask.

What's the story?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
