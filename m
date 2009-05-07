From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH/RFC] daemon.c: replace inet_ntop with getnameinfo
Date: Thu, 7 May 2009 09:45:48 -0400
Message-ID: <89EC8961-0122-4616-A497-9204F52B8807@silverinsanity.com>
References: <4A02D288.6040804@googlemail.com> <4A02D70B.6090305@op5.se> <EC96A79E-4D4E-467A-A10F-D905FE02E508@gmail.com> <m3tz3xm3zt.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Benjamin Kramer <benny.kra@googlemail.com>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, jdl@jdl.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 15:46:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M23vG-0007Ak-Pr
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 15:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbZEGNpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 09:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbZEGNpx
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 09:45:53 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:39508 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbZEGNpx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 09:45:53 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 8C8B61FFC15A; Thu,  7 May 2009 13:45:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.5.44] (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 957131FFC142;
	Thu,  7 May 2009 13:45:47 +0000 (UTC)
In-Reply-To: <m3tz3xm3zt.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118478>


On May 7, 2009, at 9:34 AM, Jakub Narebski wrote:

> BTW. this is not only MS Windows that have problems with ':' in paths
> (because of it being drive letter separator), but also IIRC MacOS X,
> where ':' and not '/' is directory separator.

Just FYI:

: was the directory separator in Mac OS 1-9.  OS X uses / like most  
sane people.  Finder will stop you from creating files or directories  
with : in the name, but the following works just fine from Terminal.app:

$ uname -a
Darwin Laptop.local 9.6.0 Darwin Kernel Version 9.6.0: Mon Nov 24  
17:37:00 PST 2008; root:xnu-1228.9.59~1/RELEASE_I386 i386
$ touch test:test
$ ls test*
test:test
$ rm test:test
$

~~ Brian
