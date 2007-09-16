From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn error when cloning apache repo
Date: Sun, 16 Sep 2007 23:46:49 +1200
Message-ID: <46ED17A9.2010603@vilain.net>
References: <20070915230833.GA8525@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: jingxue@digizenstudio.com
X-From: git-owner@vger.kernel.org Sun Sep 16 13:52:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWsfl-0002uo-2g
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 13:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbXIPLqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 07:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbXIPLqF
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 07:46:05 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:52891 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbXIPLqE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 07:46:04 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id F1F4520C2CA; Sun, 16 Sep 2007 23:45:57 +1200 (NZST)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 21E1221CFB4;
	Sun, 16 Sep 2007 23:45:53 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <20070915230833.GA8525@falcon.digizenstudio.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58313>

Jing Xue wrote:
> $ git svn clone https://svn.apache.org/repos/asf/incubator/ivy/core/ ivy-core -T trunk -b branches -t tags
> Initialized empty Git repository in .git/
> Using higher level of URL: https://svn.apache.org/repos/asf/incubator/ivy/core => https://svn.apache.org/repos/asf
>   

I'm fairly sure this is where it went wrong. Try editing .git/config and
putting your original URL in the source URL, and re-try the fetch.

Sam.
