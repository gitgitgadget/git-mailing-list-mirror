From: Geert Bosch <bosch@adacore.com>
Subject: Re: Mercurial's only true "plugin" extension: inotify... and can it be done in Git?
Date: Mon, 10 Mar 2008 15:22:03 -0400
Message-ID: <3838F28A-DB0C-4678-BA57-3344E2225889@adacore.com>
References: <200803091459.21354.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 20:49:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYo0Q-0007k0-0F
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 20:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYCJTtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 15:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752574AbYCJTtJ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 15:49:09 -0400
Received: from rock.gnat.com ([205.232.38.15]:40889 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbYCJTtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 15:49:09 -0400
X-Greylist: delayed 1614 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Mar 2008 15:49:08 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 21F5B2AAB40;
	Mon, 10 Mar 2008 15:22:14 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qtzh4JKlwvcT; Mon, 10 Mar 2008 15:22:14 -0400 (EDT)
Received: from potomac.gnat.com (potomac.gnat.com [205.232.38.124])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id 082EB2AAC1E;
	Mon, 10 Mar 2008 15:22:14 -0400 (EDT)
In-Reply-To: <200803091459.21354.jnareb@gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76753>


On Mar 9, 2008, at 09:59, Jakub Narebski wrote:

> This extension[3][4] optimises "hg status" command by asking file
> notification daemon about changed files instead of doing stat. I'm not
> sure how useful this extension is: inotify is Linux specific, and  
> Linux
> has fast stat... nevertheless this is one example where extension
> (plug-in) framework shows that it can do more than good scriptability.

FWIW, OS X 10.5 has a similar functionality, called "fsevents",
as well as a much slower stat.

   -Geert
