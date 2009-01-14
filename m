From: skillzero@gmail.com
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Tue, 13 Jan 2009 23:33:23 -0800
Message-ID: <2729632a0901132333h6caf9facu871869abce5597c1@mail.gmail.com>
References: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com>
	 <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 08:34:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN0H1-0007vv-Kg
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 08:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687AbZANHd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 02:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756171AbZANHd0
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 02:33:26 -0500
Received: from rn-out-0910.google.com ([64.233.170.185]:18027 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759591AbZANHdY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 02:33:24 -0500
Received: by rn-out-0910.google.com with SMTP id k40so340710rnd.17
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 23:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mNmTW+TSC+/JadF/nJne3Ff5OX8tnR1R2Pd3O2CBinw=;
        b=aCtlqV8Lcpcspwnx9jKA07aR+u11Jlz9awLNgQJDOuE3Cx+rRjc2tLperoSjgLLGHM
         tr0SwbLgc1fdMBnGZ36vVBxc9AI2v+sbqeRj98FgT9JmOtBLZyC8Sp1T7SfPzeUjfV5p
         N6fkHfSfIr+xEGVUdkXMPdPUSrNwvg/I+gLv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SC99S0mL4CepWOlKXNb3SECwnJgzoz0V8LY9YbHgyuQIE1ajLWvbNjtuKUkb4/ITgm
         Y8vADEs2sDadHmDbaep9IFwMuF3hQPF4UQQTbaKJXFABALhyTOzP7HDjToc5GTE96bf8
         Vu5RQmJTyEuMsCSA67u58TJ9joqWTCyzyjmnA=
Received: by 10.65.240.13 with SMTP id s13mr21097371qbr.29.1231918403554;
        Tue, 13 Jan 2009 23:33:23 -0800 (PST)
Received: by 10.64.242.15 with HTTP; Tue, 13 Jan 2009 23:33:23 -0800 (PST)
In-Reply-To: <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105595>

I guess maybe a better question is how do people normally handle
situations like mine where I did some work on branch X and I later
realize I need only a portion of that work on branch Y? I'm not sure
how I can change my workflow to completely eliminate these situations.
For example, I often start a branch to add a new feature and I end up
fixing bug A on that branch. Then other people on my team decide they
need the fix for bug A immediately and can't wait for me to finish my
feature branch and do a full merge.

Is there some way I can change my workflow such that I can fix bug A
(maybe on a separate branch?) and somehow apply it to both both
branches in a way that won't result in duplicate commits?

Does this kind of thing ever happen with the Linux kernel or git
itself: somebody does a fix as part of their topic branch and the
Linux kernel or git master wants that particular fix now, but is not
ready for the full topic branch? Would they just suggest the fix be
separated into its own topic branch and that merged? If so, how would
that new topic branch merge into the original topic branch without
resulting in a duplicate commit when it's later merged into master?
