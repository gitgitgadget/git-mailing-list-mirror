From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: more merge strategies : feature request
Date: Tue, 2 Dec 2008 20:07:36 -0500
Message-ID: <ee2a733e0812021707i82049eai866035aef3386264@mail.gmail.com>
References: <81bfc67a0811290848m6cb219c0y71a7266001096f2d@mail.gmail.com>
	 <4933AC03.6050300@op5.se>
	 <ee2a733e0812011849l1b319c96u9abbb4e8dd4f53ce@mail.gmail.com>
	 <81bfc67a0812020546o79906a20jcd04bd42d18dd803@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Caleb Cushing" <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 02:08:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7gEa-0007lC-Mk
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 02:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbYLCBHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 20:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbYLCBHj
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 20:07:39 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:40570 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbYLCBHi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 20:07:38 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2679269fkq.5
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 17:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XXEgtaSUg/kxHgynOT7oVgVxU0Aj03P+pMBZQvqotLo=;
        b=uIMBnpaAxVt0SUe2RTv/qP2UvhPf6CADSt5e41uGInOlQB653a5UZbkLidVMraMNrN
         4YuM2xnXf0BSX/6TotN3T6pa7AHJ6xxeZ9qvjPxR4nj1G1YvrUevxwB0RujNU+qojZOE
         L3JUdEPwHU9jilW5yXhxctCGF3+NOxrFtBlC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=DmJV7uOE3A3BmPGpey18rlWgDPMj2F8vYHnss22MsHDx9ggdhUaHm3YGEvlk0EUPHi
         2Q0R/u3aevvULHo2ZpAbU9nsPiNaQ2/SyzZL5zuNWU1MMRmt0ckRjqD3IOa3OhDRluTu
         MMmvBYsl0B3fWw71p2+5SOD2quA0dPetApzLE=
Received: by 10.181.59.19 with SMTP id m19mr4446391bkk.91.1228266456234;
        Tue, 02 Dec 2008 17:07:36 -0800 (PST)
Received: by 10.181.7.8 with HTTP; Tue, 2 Dec 2008 17:07:36 -0800 (PST)
In-Reply-To: <81bfc67a0812020546o79906a20jcd04bd42d18dd803@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102195>

On 12/2/08, Caleb Cushing <xenoterracide@gmail.com> wrote:
> > I guess that "no-overwrite" can be achieved by
>  >
>  >  git merge -s ours --no-commit
>
>
> no it doesn't. which is why I called it a bad name. no-overwrite would
>  still add new lines to the file not in ours (and no-commit isn't
>  needed in that case) it just wouldn't overwrite conflicting lines, my
>  understanding of ours is that it will keep the files as is.
>
> Caleb Cushing
>

>From your original email in this thread

"no-overwrite: if a change from the branch being merged in would
overwrite something in the current branch don't merge it. (I think it
needs a better name)"

I got the impression that you would like to preserve "ours" branch
whenever other branch tries to overwrite something? Is it
"no-override-conflicting-lines" that you are really after?

--Leo--
