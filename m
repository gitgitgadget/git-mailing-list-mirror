From: Johan Herland <johan@herland.net>
Subject: Re: Relative submodule URLs vs. clone URL DWIMming
Date: Sun, 31 Aug 2008 01:23:47 +0200
Message-ID: <200808310123.48018.johan@herland.net>
References: <200808271400.54302.johan@herland.net>
 <200808290101.20048.johan@herland.net>
 <7vhc92f8ay.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 31 01:30:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZZtQ-0002e1-ME
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 01:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbYH3XYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 19:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754624AbYH3XYI
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 19:24:08 -0400
Received: from smtp.getmail.no ([84.208.20.33]:53076 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754555AbYH3XYH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 19:24:07 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K6F0080BT04VN00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 31 Aug 2008 01:24:04 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K6F00J4ESZOAB90@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 31 Aug 2008 01:23:48 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K6F00699SZORC40@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 31 Aug 2008 01:23:48 +0200 (CEST)
In-reply-to: <7vhc92f8ay.fsf@gitster.siamese.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94444>

On Sunday 31 August 2008, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> I personally feel that cases that involve cloning from non-bare
> repositories (and in addition, DWIMmed repositories), with or without
> nested submodules, are not worth supporting.

Ok. I guess that's fair. Such a decision should definitely be documented 
appropriately in the submodule documentation, though.

I guess this also means you don't plan to do anything about the difference 
in origin URLs produced by "git clone" for the following two cases:

$ git clone /repo/foo bar
$ grep -B1 url bar/.git/config
[remote "origin"]
        url = /repo/foo/.git

vs.

$ git clone file:///repo/foo bar
$ grep -B1 url bar/.git/config
[remote "origin"]
        file:///home/johan/git/foo


Hmm?

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
