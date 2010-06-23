From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Newbie question: how can I list added files?
Date: Wed, 23 Jun 2010 21:55:32 +0200
Message-ID: <4C2266B4.2060404@dbservice.com>
References: <AANLkTinxOE5xcP_V-PvoZGlfsxtcCafoYKy_PuBZnQnQ@mail.gmail.com> 	<7vzkylejbf.fsf@alter.siamese.dyndns.org> <AANLkTikE2ylLXk5XxNGvcvol6R-puSTzPurdLcNMYaZJ@mail.gmail.com> 	<20100623183050.GA20842@coredump.intra.peff.net> <AANLkTin-MEBUYheTkFbeKIBj5peVV-sPa7hZSg-wMgBi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT List <git@vger.kernel.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 22:29:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORWZH-0004Nz-1K
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 22:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178Ab0FWU3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 16:29:00 -0400
Received: from office.neopsis.com ([78.46.209.98]:48111 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab0FWU27 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 16:28:59 -0400
X-Greylist: delayed 1991 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jun 2010 16:28:59 EDT
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.164,BAYES_00: -1.665,TOTAL_SCORE: -1.501,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Wed, 23 Jun 2010 21:55:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTin-MEBUYheTkFbeKIBj5peVV-sPa7hZSg-wMgBi@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149547>

On 6/23/10 9:15 PM, Bruce Korb wrote:
> P.S. Is it really so rare that someone would want this info that it should
> wind up being so obscure?  I now have a new alias:
> 
>    alias git-ls-staged="git diff --cached --name-only"

Did you know git has a builtin support for aliases?
  $ git config --global alias.ls-staged "diff --cached --name-only"

tom
