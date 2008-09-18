From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2 4/4] diff.c: convert builtin funcname patterns to
 non-GNU extended regex syntax
Date: Fri, 19 Sep 2008 01:40:15 +0200
Message-ID: <200809190140.15489.johan@herland.net>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org>
 <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Sep 19 01:41:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgT7o-0005kz-PE
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 01:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007AbYIRXkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 19:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754613AbYIRXkS
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 19:40:18 -0400
Received: from smtp.getmail.no ([84.208.20.33]:63265 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754883AbYIRXkS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 19:40:18 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K7F0060D0F4HI00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 19 Sep 2008 01:40:16 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7F00APS0F3SE50@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 19 Sep 2008 01:40:15 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7F00ICQ0F3ATG0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 19 Sep 2008 01:40:15 +0200 (CEST)
In-reply-to: <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96254>

On Friday 19 September 2008, Brandon Casey wrote:
> The 'non-GNU' part of this basic RE to extended RE conversion means '\\s'
> was converted to ' '.

Shouldn't that be '[ \t]' instead? At least I would like that for the HTML 
pattern.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
