From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 17:35:21 +0200
Message-ID: <4FE09C39.50702@elegosoft.com>
References: <4FE091FB.7020202@desrt.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ryan Lortie <desrt@desrt.ca>
X-From: git-owner@vger.kernel.org Tue Jun 19 17:37:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh0Uj-0002DT-Fw
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 17:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab2FSPhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 11:37:19 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:52480 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792Ab2FSPhT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 11:37:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 44512DE799;
	Tue, 19 Jun 2012 17:37:18 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o2QLSJrNCWIb; Tue, 19 Jun 2012 17:37:18 +0200 (CEST)
Received: from [10.10.10.250] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 1BB19DE789;
	Tue, 19 Jun 2012 17:37:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120616 Thunderbird/13.0.1
In-Reply-To: <4FE091FB.7020202@desrt.ca>
X-Enigmail-Version: 1.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200207>

On 06/19/2012 04:51 PM, Ryan Lortie wrote:
> So feature request: 'git branch' should not allow creating a local 
> branch that has the same name as a branch that already exists on 
> 'origin' (or any remote?) without some sort of --force flag.  It could 
> instead helpfully say:
> 
>    """
> 
>      The branch you are trying to create already exists on the origin.
>      Are you sure you don't want to checkout this branch using
>      'git checkout gtk-3-4'
> 
>   """
> 
> or something like that.
> 
> Thoughts?

This very much violates the distributed nature of Git. Everything
is allowed, because it's *my* repository.
