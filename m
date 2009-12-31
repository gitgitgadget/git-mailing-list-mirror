From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH v2] cvsserver: make the output of 'update' more compatible 
	with cvs.
Date: Thu, 31 Dec 2009 16:20:26 +0100
Message-ID: <46a038f90912310720l4b1cbdebs2b85774ae7e33c0e@mail.gmail.com>
References: <87zl5z4y0w.fsf@osv.gnss.ru> <87bpibdonj.fsf@osv.gnss.ru>
	 <20091230224115.6117@nanako3.lavabit.com>
	 <7vfx6rzlkg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 16:20:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQMpJ-0005MM-BS
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 16:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbZLaPU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 10:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbZLaPU3
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 10:20:29 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:36085 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbZLaPU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 10:20:28 -0500
Received: by ewy19 with SMTP id 19so4700573ewy.21
        for <git@vger.kernel.org>; Thu, 31 Dec 2009 07:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=0RNw3SBUOxatVp/JdsFFRTivVlXaa0E1YHn2sm5OOFE=;
        b=f7FiU2YxeG6NWnzeDBPIWBduOImSVLTPEc3lpEmNPg6opDRaA3GcNx5Fig+ttExmC1
         GxgSMRTwCZ2Ed7VfbV1tB4gdK2WLL09/Anp2tz3abyoUfg+lKRfANMkjCmmJU57EX6oU
         Jeqwqypgf0jebK1MBAZ+X6WLk332VMCYopQA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WJHxC+H6mpPQPZmaSVAArRW9Hd7dDtmNMpaZPCnLXkGAyCYl54DqVqk3Ffg88gqu6C
         Cb7uvGr25eynxAIeqC1R0bMBM/XkJWzy3g23gG4c9w0xUr7Rg6pTxqUgu1Mguw+OO8N9
         EuvWPsPq8kjJtVNIBibPUwNPXJtgxVC2FSrQQ=
Received: by 10.213.2.82 with SMTP id 18mr23191174ebi.58.1262272826338; Thu, 
	31 Dec 2009 07:20:26 -0800 (PST)
In-Reply-To: <7vfx6rzlkg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135954>

On Thu, Dec 31, 2009 at 7:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Well, since I don't use cvsserver myself, but this v2 was done with
> improvements based on some review suggestions, I was waiting for a
> response or two from people who know better and care more about cvs server
> emulation than me, which unfortunately didn't happen.

Looks good to me -- good to get it into pu. While I continue to use
git extensively, I don't use cvsserver anymore, nor work with people
that do. Might have reason to revisit cvsserver in the near future
though, to help Moodle transition to git.

That transition will bring a few top-posters and Eclipse lovers to the
list. Looking past such details, they are fine people who may need a
little bit of git-newbie help ;-)

happy new year,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
