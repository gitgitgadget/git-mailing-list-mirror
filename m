From: Ian Hilt <Ian.Hilt@gmx.com>
Subject: Re: how to list all files that will be comitted
Date: Wed, 25 Jun 2008 11:57:11 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806251154180.5755@sys-0.hiltweb.site>
References: <644094BE-2835-41EF-B1B4-615B8A4BD509@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 17:58:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBXNo-0005EJ-3F
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 17:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbYFYP5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 11:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbYFYP5J
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 11:57:09 -0400
Received: from mail.gmx.com ([74.208.5.67]:47353 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751628AbYFYP5J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 11:57:09 -0400
Received: (qmail invoked by alias); 25 Jun 2008 15:57:07 -0000
Received: from cpe-75-185-208-72.woh.res.rr.com (EHLO [192.168.1.1]) [75.185.208.72]
  by mail.gmx.com (mp-us004) with SMTP; 25 Jun 2008 11:57:07 -0400
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX18TCFAKDqMTxKtCtaEvAel4j4Ubj25SMKKDvZ+BcV
	5ZRXGeCxwaEu+I
In-Reply-To: <644094BE-2835-41EF-B1B4-615B8A4BD509@gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86292>

On Wed, 25 Jun 2008 at 11:31am -0400, Rhodes, Kate wrote:

> I know ls-files is the tool I need but I haven't been able to figure out what
> combination of options will give me the files that have been added to the
> index.
> 
> -Kate

Have you tried "git status" ?  It will output something similar to the
following:

# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   somefile
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#	modified:   anotherfile
#


-- 
Ian Hilt
Ian.Hilt (at) gmx.com
GnuPG key: 0x4AFC1EE3
