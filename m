From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: simplest git deamon?
Date: Mon, 12 Apr 2010 16:23:11 +0200
Message-ID: <4BC32CCF.5060303@dbservice.com>
References: <20100412164740.740050cb@pbmiha.malagasy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
X-From: git-owner@vger.kernel.org Mon Apr 12 16:54:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1L1S-0006ZO-1E
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 16:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab0DLOxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 10:53:42 -0400
Received: from office.neopsis.com ([78.46.209.98]:43822 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab0DLOxm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 10:53:42 -0400
X-Greylist: delayed 1809 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2010 10:53:41 EDT
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Mon, 12 Apr 2010 16:23:11 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100412164740.740050cb@pbmiha.malagasy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144738>

On 4/12/10 3:47 PM, Mihamina Rakotomandimby wrote:
> Manao ahoana, Hello, Bonjour,
>
> I would like to setup a git repository, on a Debian machine.
> I would like to access it only with git:// (no http://, no ssh://,...)
>
> How to implement read/write restriction when just wanting to use
> "git://" without dealing with SSH?

The git:// protocol is anonymous, not authenticated. If you want to 
allow read/write access to repositories while restricting access only to 
certain users, you'll have to use http:// or ssh:// (with the later 
strongly preferred). Try gitolite [1], it isn't that hard to set it up.

tom

[1] http://github.com/sitaramc/gitolite
