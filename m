From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 3] Copy description of build configuration variables to configure.ac
Date: Sun, 09 Jul 2006 18:47:43 +0200
Organization: At home
Message-ID: <e8rbuk$je5$1@sea.gmane.org>
References: <200607030156.50455.jnareb@gmail.com> <1152392835436-git-send-email-jnareb@gmail.com> <11523928361444-git-send-email-jnareb@gmail.com> <7virm7nq7h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jul 09 18:47:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzcRZ-0002GT-CH
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 18:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWGIQri (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 12:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWGIQri
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 12:47:38 -0400
Received: from main.gmane.org ([80.91.229.2]:37803 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751331AbWGIQrh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 12:47:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FzcRJ-0002F9-7I
	for git@vger.kernel.org; Sun, 09 Jul 2006 18:47:26 +0200
Received: from host-81-190-31-220.torun.mm.pl ([81.190.31.220])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 09 Jul 2006 18:47:25 +0200
Received: from jnareb by host-81-190-31-220.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 09 Jul 2006 18:47:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-220.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23559>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Copy description of build configuration variables from the commentary
>> in the top Makefile (from 'next' branch) to configure.ac, splitting
>> them into "autoconf" sections.
> 
> I do not see much point in this -- they will become out of sync.

> [...] I think you are better off making a list of
> supported and yet to be supported ones in the comment in
> configure.ac, and when you want to see if the list got stale
> over time, grep for '^# Define' from the Makefile and match them
> up.

This is kind of such a list. Also let me point out that this was in _first_
patch of the series, as a kind of TODO list.

Perhaps those which are done, and those which are not implemented should be
marked differently... 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
