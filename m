From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2 3/5] git-submodule.sh: Add Custom argument input support
 to git submodule recurse subcommand
Date: Sun, 18 May 2008 15:27:50 +0200
Message-ID: <200805181527.50983.johan@herland.net>
References: <1209978582-5785-1-git-send-email-imyousuf@gmail.com>
 <1209978582-5785-3-git-send-email-imyousuf@gmail.com>
 <7v7idzxhwp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, imyousuf@gmail.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 18 15:30:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxixu-0005SO-TM
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 15:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbYERN32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 09:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753081AbYERN32
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 09:29:28 -0400
Received: from smtp.getmail.no ([84.208.20.33]:52370 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbYERN31 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 09:29:27 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K1200H09G4RCI00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 18 May 2008 15:29:15 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K1200FSEG2F0H10@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 18 May 2008 15:27:51 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K1200BB9G2F92J0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 18 May 2008 15:27:51 +0200 (CEST)
In-reply-to: <7v7idzxhwp.fsf@gitster.siamese.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82384>

On Tuesday 13 May 2008, Junio C Hamano wrote:
> If we want a useful and flexible "recurse", perhaps the only thing we need
> to do is a command that lists a submodule directory path, one path at a
> time, in optionally different traversal order and depth cutoff, so that
> the user can feed it to xargs and do whatever they want to run in there.

Yes! As more and more porcelains on top of the git submodule plumbing is
created, this is definitely something that is (or will be) sorely needed.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
