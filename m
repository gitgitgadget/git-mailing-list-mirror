From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Newbie in Git. How to get back from last pull?
Date: Sun, 1 Aug 2010 14:00:02 +0530
Message-ID: <20100801083000.GF26006@kytes>
References: <1280649966984-5360499.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yankovsky <YankovskyAndrey@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 01 10:31:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfTxY-0008Ph-5h
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 10:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593Ab0HAIbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Aug 2010 04:31:46 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57830 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab0HAIbo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Aug 2010 04:31:44 -0400
Received: by pvc7 with SMTP id 7so1022342pvc.19
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 01:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=A9j/lFHGv4GpiY9Y1gr0vIm5jaI+zBfw7yhDMH5/Dto=;
        b=Y+T1e4jFrtPiqvnJF6P2ztr/nwMxjDCHBx9E9EX7FmO4sEARCQEWPL1DcVWYrb5jEZ
         4kDqYKr9qEVUrBCtd/ekvkOvUebG4f5/m6RlYWhBcOjZ1WFTjfFByZuf3glpBP9m1CNA
         MkPixovsWklPPLtJnGjT2Aqc+qEilopYcp1vk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bgalTO5hmtaqZKE5XmbSMQbiUCjD0cd8nfZnKOUKvARVNb72cYQa5vjBo8pOeIxIru
         ens7X6qDOEV4XvTPNWVJgZNSrA2cipeba34B/TLLO9RRSYK8cnTZQ+SFw1mudZ8TS5CI
         0mmgsMv9yDtnU0OFInkJTGheku777xl1/i/+Y=
Received: by 10.142.147.7 with SMTP id u7mr3941000wfd.219.1280651504091;
        Sun, 01 Aug 2010 01:31:44 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id f2sm5705079wfp.11.2010.08.01.01.31.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Aug 2010 01:31:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280649966984-5360499.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152371>

Hi Yankovsky,

Yankovsky writes:
> I have commited all my changes, and accidently typed git pull, then was
> paniced and aborted the operation. now all my changes in project disappear.
> but i have commit. how can i restore my project status using this commit?
> I hope you understand my rus english)

I don't understand exactly what you want to do, but here are the
basics- you can decide what you want to do.
1. Use `git reflog` to see a history of your operations.
2. If you want your working copy to switch to an existing commit, use
   `git checkout <SHA1 of commit>`.
3. If you want to irreversibly destroy everything and switch your
   working copy to a desired commit, use `git reset --hard <SHA1 of
   commit>`. Use with care!

Hope that helps.

-- Ram
