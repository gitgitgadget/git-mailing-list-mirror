From: Fabio Augusto Dal Castel <fdcastel@gmail.com>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Tue, 10 Feb 2009 18:40:34 -0200
Message-ID: <38cfbb550902101240x1202c592ra7eb01d66e22da43@mail.gmail.com>
References: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com>
	 <etsYQzEDjdk-_NxhvO3i6EyShR6eZ202GBdQx7ZZpPHH5iNfWiuV6g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Feb 10 21:42:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWzQi-0002E8-RR
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 21:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229AbZBJUki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 15:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754991AbZBJUkh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 15:40:37 -0500
Received: from qb-out-0506.google.com ([72.14.204.226]:11514 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654AbZBJUkh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 15:40:37 -0500
Received: by qb-out-0506.google.com with SMTP id q18so14252qba.17
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 12:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RkBQmFU+vOt5EUSVA9EGb5HGb63nzq6tPYTTyCxxXRU=;
        b=otFkyQ63CeDVGfL1Klw5sZikmzjtj9+ek5mAxx1oQ6URtprFEpSXooylTgARkA+yWB
         cFzMtNt1iAGudrE/gJDibXLf8l2XFmcM+8wDcH2ML9a3S33ygpm23Vvnb+UUBg4hKFUI
         G/MzZWFOEVvTC57EMN35NCCsm1sAr9QacwTI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ba988cbxBw6RAmydsWoRbfT5W8RiL1bwF0QlSF2LTAx2KLXpT9Fp7X87YaxQnrZLWX
         rLEMRb9Ds8wmVQjT/0ouf/EGuK+JS1ehG1yBCNOFFwEiDePHHhTpXzsafhLxFwMNhYM4
         ysvObQBHqwfwXPtjVwVeIHoPCjFe7rwvj/uQc=
Received: by 10.231.16.197 with SMTP id p5mr1815303iba.51.1234298434847; Tue, 
	10 Feb 2009 12:40:34 -0800 (PST)
In-Reply-To: <etsYQzEDjdk-_NxhvO3i6EyShR6eZ202GBdQx7ZZpPHH5iNfWiuV6g@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109304>

Brandon,

> If stashes were per-branch, then it would probably
> be pretty easy to build this snapshot tool on top of it.

Or the other way around <g>.

Remember that 'stash' is actually TWO commands in one:
* Save current state
* Reset to HEAD

My primary reason to use snapshots is to AVOID the second step.
