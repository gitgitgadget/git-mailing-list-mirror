From: david@lang.hm
Subject: Re: how to recover a repository
Date: Fri, 17 Dec 2010 14:30:37 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1012171430270.18272@asgard.lang.hm>
References: <alpine.DEB.2.00.1012162024020.22269@asgard.lang.hm> <20101217044530.GA8590@burratino> <alpine.DEB.2.00.1012171218450.18272@asgard.lang.hm> <20101217212201.GC11511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 17 23:30:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTip8-0001lU-1M
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 23:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133Ab0LQWap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 17:30:45 -0500
Received: from mail.lang.hm ([64.81.33.126]:60841 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755796Ab0LQWao (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 17:30:44 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id oBHMUbHJ032728;
	Fri, 17 Dec 2010 14:30:37 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20101217212201.GC11511@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163896>

thanks, that appears to have worked.

David Lang

On Fri, 17 Dec 2010, Jeff King wrote:

> Date: Fri, 17 Dec 2010 16:22:02 -0500
> From: Jeff King <peff@peff.net>
> To: david@lang.hm
> Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
> Subject: Re: how to recover a repository
> 
> On Fri, Dec 17, 2010 at 12:20:56PM -0800, david@lang.hm wrote:
>
>>> 3. git update-ref HEAD refs/heads/(branch you were on)
>>
>> I was on the default branch but if I do 'git update-ref HEAD
>> refs/heads/master' I get an error 'not a valid SHA1'
>
> That should be "git symbolic-ref HEAD refs/heads/master".
>
> -Peff
>
