From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Global .git directory
Date: Wed, 28 Apr 2010 08:22:10 +0200
Message-ID: <4BD7D412.5020603@dbservice.com>
References: <alpine.LFD.2.00.1004270705280.15197@bbs.intern>  <201004271159.34071.trast@student.ethz.ch>  <alpine.LFD.2.00.1004272144470.11216@bbs.intern> <s2y40aa078e1004271326u3fbbd46au30f187bc3ca9c8c8@mail.gmail.com> <alpine.LFD.2.00.1004280710380.27548@bbs.intern>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: Gerhard Wiesinger <lists@wiesinger.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 08:25:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O70i1-0002ZO-SO
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 08:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab0D1GXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 02:23:22 -0400
Received: from office.neopsis.com ([78.46.209.98]:52143 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426Ab0D1GXU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 02:23:20 -0400
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Wed, 28 Apr 2010 08:22:10 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <alpine.LFD.2.00.1004280710380.27548@bbs.intern>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145972>

On 4/28/10 7:33 AM, Gerhard Wiesinger wrote:
> BTW: The tutorial on http://git-scm.com/ is IHMO wrong:
> git --version
> git version 1.6.2.5
> git commit -m 'Explain what I changed'
> =>
> git commit -a -m 'Explain what I changed'
> => Otherwise changed files are not committed, only added ones.
> => Therefore that are 2 commit ...

If you mean the snippets right on the front page, it assumes that you 
add all edited files.

> BTW2:
> Why is it necessary to do:
> # Displays only changed files
> git diff
> # Displays only added files
> git diff --cached
>
> I would like to have a full diff of my changes:
> git diff -a
> (or better "git diff -a" should be the default behaviour, I think that's
> very confusing for new users)

What are 'your' changes? Between HEAD and the working tree (aka. git 
diff HEAD)?

tom
