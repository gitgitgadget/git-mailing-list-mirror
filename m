From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: visualizing Git's Git repo
Date: Wed, 28 May 2008 01:39:16 -0700 (PDT)
Message-ID: <m37ide3jtf.fsf@localhost.localdomain>
References: <CA563F5A-5E12-42F7-BDFD-04FE3A882028@reverberate.org>
	<alpine.LFD.1.10.0805271957430.2958@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Haberman <joshua@reverberate.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 28 10:40:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1HCe-0005p7-Ut
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 10:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbYE1IjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 04:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbYE1IjV
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 04:39:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:33577 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbYE1IjU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 04:39:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1727039fgg.17
        for <git@vger.kernel.org>; Wed, 28 May 2008 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=Lx4efZyO9fhF5juqX6vwwquOOkoy/6g935kjNtWMYm4=;
        b=Q5jyVeYk2Ww3DNlM2wn6dSH6eU9e2wO5nYGV0VYb1UIvgt+iIAhEp1KKHx/KLm15Rve5hU6adhKC38T1uru38XrOytXBfQx7AT6WeAV0htiVYqN6tB2qS4e+gyj5h7xGvIwv0bWty6I6r431h3GYOcfnOwdiVsnLEcVIJ2SyUQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=ChjMe8b52j+ChmOTE8xAabJv0h/2ePxEC33QmKuwygzIyxtBR8bIg1aAAt7klvOIL4LcoqXYPnfAz79YlnLtromcKjvOyQ9WpYmPeceXGr9g38KPrup9NsM4ET7uIUQ6VH/lbp7bmF37vR9wmv3fiuRSM4Pw1iRvCXg64bikXD0=
Received: by 10.86.49.3 with SMTP id w3mr1392891fgw.4.1211963958689;
        Wed, 28 May 2008 01:39:18 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.245])
        by mx.google.com with ESMTPS id 4sm14110223fgg.6.2008.05.28.01.39.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 May 2008 01:39:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4S8cTbb032493;
	Wed, 28 May 2008 10:38:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4S8c5IP032489;
	Wed, 28 May 2008 10:38:05 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.1.10.0805271957430.2958@woody.linux-foundation.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83078>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 26 May 2008, Joshua Haberman wrote:
> >
> > 2. as a project, why don't you rebase when merging long-running branches into
> > master?
> 
> For the kernel, there's been a lot of discussion about why I prefer people 
> to rebase vs merge (or often - *avoiding* merges entirely), see the kernel 
> mailing list, and search for merging. There was a thread (subject: 
> "[alsa-devel] HG -> GIT migration") about a week ago where I tried to 
> explain my opinions about about some of this.

You can read summary of this (I think) discussion at KernelTrap:
  http://kerneltrap.org/Linux/Git_Management

-- 
Jakub Narebski
Poland
ShadeHawk on #git
