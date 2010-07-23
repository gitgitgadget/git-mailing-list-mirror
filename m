From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Secondary --exec-path?
Date: Fri, 23 Jul 2010 16:47:55 +0200
Message-ID: <4C49AB9B.6060206@dbservice.com>
References: <i2c3hn$odi$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Joel C. Salomon" <joelcsalomon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 16:48:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcJXn-0007iV-NC
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 16:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509Ab0GWOsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 10:48:04 -0400
Received: from office.neopsis.com ([78.46.209.98]:35708 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755948Ab0GWOsB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 10:48:01 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.081,BAYES_00: -1.665,TOTAL_SCORE: -1.584,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Fri, 23 Jul 2010 16:47:56 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <i2c3hn$odi$1@dough.gmane.org>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151536>

On 7/23/10 2:56 PM, Joel C. Salomon wrote:
> I just downloaded git-subtree, and the installation instructions have me
> copying the executable file to `git --exec-path`, i.e., to
> /usr/lib/git-core.
> 
> I'm looking through the documentation for a possible second location for
> these scripts, perhaps somewhere in /usr/local, or in /home/me -- is
> there such a path?  I'd rather not step on my distro's toes if I can
> help it.

Put the git-substree script into any path you want (such as $HOME/bin)
and then add that to your $PATH. Or simply drop it to /usr/bin.

tom
