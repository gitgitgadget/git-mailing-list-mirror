From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Show project README if available
Date: Tue, 10 Oct 2006 13:21:17 +0200
Organization: At home
Message-ID: <egfvlb$m2c$1@sea.gmane.org>
References: <20061010025627.19317.70511.stgit@rover> <7vejtg97qh.fsf@assigned-by-dhcp.cox.net> <7v7iz894ct.fsf@assigned-by-dhcp.cox.net> <20061010105521.GQ20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 10 13:22:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXFgH-0002rn-90
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 13:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933019AbWJJLVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 07:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933014AbWJJLVt
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 07:21:49 -0400
Received: from main.gmane.org ([80.91.229.2]:54194 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932979AbWJJLVs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 07:21:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXFfb-0002gy-U0
	for git@vger.kernel.org; Tue, 10 Oct 2006 13:21:11 +0200
Received: from host-81-190-27-91.torun.mm.pl ([81.190.27.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 13:21:11 +0200
Received: from jnareb by host-81-190-27-91.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 13:21:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-91.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28628>

Petr Baudis wrote:

> Dear diary, on Tue, Oct 10, 2006 at 06:33:54AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> Junio C Hamano <junkio@cox.net> writes:
>> 
>> > Petr Baudis <pasky@suse.cz> writes:
>> >
>> >> If the project includes a README file, show it in the summary page.
>> >...
>> > I wonder how this should relate to .git/description file,
>> > though.  In other words, it _might_ make sense to change where
>> > we show the contents of description right now to show the first
>> > line and take README from the same location.
> 
> In principle I like this idea. One problem is that description is not
> supposed to contain HTML and my README is (perhaps it should read
> README.html instead), and I really want README to. And if it's not
> plaintext, division of the first line and the rest does not work so
> well:

Perhaps we should assume $GIT_DIR/README to be text/plain (and useable
as motd), and $GIT_DIR/README.html as text/html, preffering the README.html.
The "problem" is if README.html is HTML _fragment_, or is it self contained
HTML (and we should use iframe, object, or strip it).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
