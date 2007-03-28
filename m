From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn, remote tracking branch question
Date: Wed, 28 Mar 2007 08:24:17 -0700
Message-ID: <m23b3pqtlq.fsf@ziti.fhcrc.org>
References: <m2ps6usa9o.fsf@ziti.fhcrc.org> <20070327220015.GA16344@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 17:24:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWa0f-0005YQ-8y
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 17:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbXC1PYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 11:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbXC1PYV
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 11:24:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:40967 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbXC1PYV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 11:24:21 -0400
Received: by wr-out-0506.google.com with SMTP id 76so2440526wra
        for <git@vger.kernel.org>; Wed, 28 Mar 2007 08:24:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=rc0Tw+lUJ3wSlFXl/YwiSDfxlw2iRjnVEOeRb6ud1BYhsauiQBnUghvvo1RATzz2PHWEtLOD5yF1DV3ZOcpGb5xmvZYz3idSKKTkFQnczL90o4BEGTBsCp1nuzK/QaSHqoNf8pCwUhxgu1z58Q1NZfeYvx4klzLLfZhkpGfsD+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=Fx2+KVYATToifa+uqr06LnGuHjvPRwvyizyQuYywU2KFlzW59g8aA4TkomV3ylhp1HLop+Hj/BPqMixNuLGsE2j0sGAdEoZ3WR2MsYLVu3yLK3Bc7QveDPfgbqOxs66qYucUpdb6OM6B5DboO5i2wFKMAC9rZFg0qKDtCXVD4CQ=
Received: by 10.114.56.1 with SMTP id e1mr3777764waa.1175095459377;
        Wed, 28 Mar 2007 08:24:19 -0700 (PDT)
Received: from ziti.fhcrc.org ( [67.171.24.140])
        by mx.google.com with ESMTP id m28sm4765605poh.2007.03.28.08.24.18;
        Wed, 28 Mar 2007 08:24:18 -0700 (PDT)
In-Reply-To: <20070327220015.GA16344@untitled> (Eric Wong's message of "Tue, 27 Mar 2007 15:00:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43376>

Eric Wong <normalperson@yhbt.net> writes:
> 'git svn rebase' should be capable auto-discovering the remote ref that
> you last branched from.  I'm not sure if the '2.5' that's common in the
> remote ref and your local branch would cause ambiguity, however...
>
> I'll look into this more when/if I have time tonight.

ok.  In the meantime, I renamed my branch to avoid any potential name
conflict and it seems to be working automagically as you described.
That's really useful, thanks.

+ seth

-- 
Seth Falcon
