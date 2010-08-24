From: Jared Hance <jaredhance@gmail.com>
Subject: Re: coding process
Date: Tue, 24 Aug 2010 13:28:00 -0400
Message-ID: <20100824172800.GA4347@localhost.localdomain>
References: <AANLkTi=Aei+-nbNFqY4CNjx5E+nNaOSp7-j+ruuK4kMN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 24 19:28:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnxIH-00024u-7v
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 19:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130Ab0HXR2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 13:28:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47677 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081Ab0HXR2J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 13:28:09 -0400
Received: by vws3 with SMTP id 3so668248vws.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HAyZ1nkQuSSuiPZT79VNs3lBAK2JSaqJzlG+qtM5SR8=;
        b=RaqCpi4DG/Xj4tHkCtdnGcSx7ZOTs/la/hieAskh/EHJaexqfmpXtbPH3oXsGS6OAa
         4fy4PspoODHaz4cqK9DQiTWzdBPMrGNJoVO2wGI30K4XZPvMHIAwCnFu4yYzzVggBjhT
         PZ3jHDb2C3wDYeH1yR8HxPlSmJzkI0/ow1slw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CbhKYtCDo4+cuMDctc1WecFBXmRLeqbR4K7jrm889W5WiJFFVRBYckvf4vMZQNwo7X
         ERKy3JIrpX/Nahbs7zRw/VnYR3YTFbFX3/lmJBdBA797UirRnXbq+cg6J6QWqbmE2yEi
         TuZtxH/W0lQlAZNO6LGBr8YuQZsEFbc4KdFwU=
Received: by 10.220.161.203 with SMTP id s11mr4353221vcx.195.1282670888276;
        Tue, 24 Aug 2010 10:28:08 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-213-29.cinci.res.rr.com [174.101.213.29])
        by mx.google.com with ESMTPS id b8sm163224vci.45.2010.08.24.10.28.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 10:28:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=Aei+-nbNFqY4CNjx5E+nNaOSp7-j+ruuK4kMN@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154326>

On Tue, Aug 24, 2010 at 09:31:21AM -0600, Wes James wrote:
> I am working with git and I'm wondering if coding like the following
> is a good way to manage code:
> 
> create code then commit
> when a good set up code is ready push to master
> create a branch
> create code then commit
> when code is good, merge and push to master
> go back to create branch
> 
> Anyone else have a procedure they go through when managing code?
> 
> thx,
> 
> -wes

>From what you say, it sounds like you are using topic branches, which
are always a good way to manage code. You might want to consider using
release branches (like how git.git has "master", "next", and "maint").

I'm not sure what you mean by "push to master". You don't push to a
branch. You push to a repository. I guess you mean pushing to the
"official" or "blessed" repository?

Also, sending patches to an email before merging to master is a
good idea to get code review.
