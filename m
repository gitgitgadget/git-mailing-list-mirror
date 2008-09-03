From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git commit -p? --loop?
Date: Wed, 3 Sep 2008 16:01:46 +0200
Message-ID: <bd6139dc0809030701y4a07c1a4secf08883235af9c0@mail.gmail.com>
References: <48BE4839.8080305@gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ittay Dror" <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 16:03:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaswq-0003Fk-J3
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 16:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbYICOBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 10:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755540AbYICOBt
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 10:01:49 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:36079 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491AbYICOBs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 10:01:48 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1623758yxm.1
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JLTJr3Wwqs9nGLBZqVN7381ZjcrhnpwFK9Vk87uYxUc=;
        b=upIP6oOP+ISJ3uQqeTiG+/X/YTuAhajtiZ0/gDURRzVmsdsYfRrGRPbEmOtR2Ua/9Z
         +EII1ua7VErx+UqqqYCmMqdpq+psKD0eD46bDFjb6TiaLskHmNS0bhPz1sWdKrdtBO21
         LP7697Mx1Ye2zx2I+Eqf+i2IfO+LXt1xv1YhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=eE3vFTZjoGP37yttaaDN2kRoL5lXnNLRiIjypd5mFUpQLsqlXDK3iLnQZZg0mL3YHE
         O+coSgPAnIT4hdOMU08FyNgCdluatuYipYjF4olXitfsHL2gagjf33cCzHp/E+sYYD/O
         vtqvVomx3ItMjmX+T5ma0Bs2rvVHc7NiNx2EY=
Received: by 10.142.135.16 with SMTP id i16mr3046513wfd.165.1220450506172;
        Wed, 03 Sep 2008 07:01:46 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Wed, 3 Sep 2008 07:01:46 -0700 (PDT)
In-Reply-To: <48BE4839.8080305@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94796>

On Wed, Sep 3, 2008 at 10:18, Ittay Dror <ittay.dror@gmail.com> wrote:
> I find that many times I make changes to some files that should be part of
> different commits. What I do then is run 'git add -p' and 'git commit'
> several times until I commit all hunks. Does it make sense to anyone to add
> -p option following a '-a' and '--loop' option (that will run until user
> requests to end or nothing to commit)?

I wonder if "git commit --interactive" would not suit your needs?

-- 
Cheers,

Sverre Rabbelier
