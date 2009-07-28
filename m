From: david@lang.hm
Subject: Re: From P4 to Git
Date: Tue, 28 Jul 2009 13:32:27 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0907281331270.28013@asgard.lang.hm>
References: <85ljm84lat.fsf@oqube.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Arnaud Bailly <abailly@oqube.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 22:34:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVtNC-00006p-2C
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 22:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbZG1Ucj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 16:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbZG1Ucj
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 16:32:39 -0400
Received: from mail.lang.hm ([64.81.33.126]:42211 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbZG1Uci (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 16:32:38 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n6SKWRNK007039;
	Tue, 28 Jul 2009 13:32:27 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <85ljm84lat.fsf@oqube.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124272>

On Tue, 28 Jul 2009, Arnaud Bailly wrote:

> Hello,
> I am investigating the use of Git in a setting where we:
> 1. branches a lot
> 2. have a very large codebase
>
> Given Git is developed to handle these 2 issues, I suspect it would be a
> very good choice, but I need to gather some experiments feedback and
> hard figures on how Git performs (storage use, necessary
> bandwidth/resources, maintainance of repositories, cleanup & gc...).
>
> For the experiment part, I am started working on it but would be
> interested in other people's experiences.
>
> For the figures part, I think I read somewhere there exists some
> statistics on Git usage for Linux kernel. Is this correct ? If true,
> where could I find them ?
>
> Thanks in advance for answering my (maybe pointless) questions and for
> producing such a nice piece of software.

the one thing that I have seen P4 reported as handling better than git is 
the case where the repository is very large. this is typically not caused 
by lots of lines of code, but by checking in lots of binary blobs to the 
repository.

David Lang
