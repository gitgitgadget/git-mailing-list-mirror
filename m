From: Herman van Rink <rink@initfour.nl>
Subject: Re: [DOCBUG] git subtree synopsis needs updating
Date: Sat, 20 Oct 2012 21:40:03 +0200
Organization: Initfour websolutions
Message-ID: <5082FE13.2000003@initfour.nl>
References: <20121019152158.4297707b@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Sat Oct 20 21:40:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPeuE-0003lE-98
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 21:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030Ab2JTTkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 15:40:07 -0400
Received: from hosted-by.initfour.nl ([83.137.144.7]:60489 "EHLO
	mail.initfour.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab2JTTkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 15:40:06 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Oct 2012 15:40:06 EDT
Received: from [192.168.65.204] (hosted-by.initfour.nl [83.137.144.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: helmo@INITFOUR.NL)
	by mail.initfour.nl (Postfix) with ESMTPSA id 5497E9FC6E5;
	Sat, 20 Oct 2012 21:40:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <20121019152158.4297707b@chalon.bertin.fr>
X-Enigmail-Version: 1.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208093>

On 10/19/2012 03:21 PM, Yann Dirson wrote:
> As the examples in git-subtree.txt show, the synopsis in the same file should
> surely get a patch along the lines of:
>
> -'git subtree' add   -P <prefix> <commit>
> +'git subtree' add   -P <prefix> <repository> <commit>
>
> Failure to specify the repository (by just specifying a local commit) fails with
> the cryptic:
>
>  warning: read-tree: emptying the index with no arguments is deprecated; use --empty
>  fatal: just how do you expect me to merge 0 trees?
>
>
> Furthermore, the doc paragraph for add, aside from mentionning <repository>, also
> mentions a <refspec> which the synopsis does not show either.
>
>
> As a sidenote it someone wants to do some maintainance, using "." as repository when
> the branch to subtree-add is already locally available does not work well either
> (fails with "could not find ref myremote/myhead").
>

The version of subtree in contrib is rather out-dated unfortunately.

I've collected a bunch of patches in
https://github.com/helmo/git/tree/subtree-updates

The documentation issue is also fixed in there.

-- 

Met vriendelijke groet / Regards,

Herman van Rink
Initfour websolutions
