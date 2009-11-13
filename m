From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: Warning while cloning remote repository
Date: Fri, 13 Nov 2009 20:34:07 +0100
Message-ID: <hdkcbm$24q$1@ger.gmane.org>
References: <117260.55181.qm@web94705.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 20:34:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N91uv-0004tn-VQ
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 20:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756928AbZKMTef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 14:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbZKMTee
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 14:34:34 -0500
Received: from lo.gmane.org ([80.91.229.12]:53705 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756435AbZKMTee (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 14:34:34 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N91un-0004pR-Ll
	for git@vger.kernel.org; Fri, 13 Nov 2009 20:34:37 +0100
Received: from dsl-083-247-086-199.solcon.nl ([83.247.86.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 20:34:37 +0100
Received: from johanthart by dsl-083-247-086-199.solcon.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 20:34:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-083-247-086-199.solcon.nl
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <117260.55181.qm@web94705.mail.in2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132841>

Shameem Ahamed schreef:
> Hi,
> 
> I ran in to a warning message while cloning a remote repository.
> 
> The message is 
> 
> warning: remote HEAD refers to nonexistent ref, unable to checkout.
> 
> After the cloning i couldn't see any remote files. The .git folder is created successfully.
> 
try
git checkout -t origin/master

on the clone.. Maybe its a workaround?
