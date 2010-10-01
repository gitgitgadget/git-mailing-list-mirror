From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: cvs importing a forked project
Date: Fri, 01 Oct 2010 12:57:29 -0500
Message-ID: <Ci4laGuWQaUrmZdwH9nojZ77bfNScQVKlCGXCSR6hP816oyKCfkncQ@cipher.nrlssc.navy.mil>
References: <AANLkTimvaH4UYzmL9eS1Yq7WNaS+jPRfkajKPP=hjZWV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 19:57:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1jrV-00038G-0x
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 19:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab0JAR5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 13:57:32 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49087 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893Ab0JAR5b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 13:57:31 -0400
Received: by mail.nrlssc.navy.mil id o91HvTqA003194; Fri, 1 Oct 2010 12:57:29 -0500
In-Reply-To: <AANLkTimvaH4UYzmL9eS1Yq7WNaS+jPRfkajKPP=hjZWV@mail.gmail.com>
X-OriginalArrivalTime: 01 Oct 2010 17:57:29.0914 (UTC) FILETIME=[1D8DC1A0:01CB6192]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157770>

On 10/01/2010 12:38 PM, Eric Frederich wrote:
> Hello,
> 
> I have a project (several actually) where development was done in cvs
> for 10 years.  Then, about 5 years ago, a copy of the latest was made
> and development continued in a new project.
> Development in the old project stopped for the most part.
> 
> Is there any way where I can combine these two projects in git?
> Basically, take the newer project's first commit and make its parent
> the the last commit of the older project.
> Development was pretty linear.

You can do this very easily using grafts.

   https://git.wiki.kernel.org/index.php/GraftPoint

filter-branch can be used to rewrite the history and make the grafts
permanent.

-Brandon
