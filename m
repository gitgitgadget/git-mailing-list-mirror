From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Add title attribute with unshortened value for table cells
Date: Tue, 20 Jun 2006 11:48:19 +0200
Organization: At home
Message-ID: <e78g90$40u$1@sea.gmane.org>
References: <200606201012.31684.jnareb@gmail.com> <7vd5d4chmg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jun 20 11:48:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FscqV-0007bp-34
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 11:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWFTJs2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 05:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWFTJs2
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 05:48:28 -0400
Received: from main.gmane.org ([80.91.229.2]:24499 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932537AbWFTJs2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 05:48:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FscqO-0007aR-15
	for git@vger.kernel.org; Tue, 20 Jun 2006 11:48:25 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 11:48:24 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 11:48:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22187>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Doesn't work well with values outside us-ascii, but that might be
>> considered web browser bug (misfeature), not a bug in gitweb.
> 
> That's sad.
> 
> Are you sure about it?

Now I see I was wrong.

> What does start_td({-title=>"blah"}) produce? <td title="blah">?
> If so, is http://members.cox.net/junkio/t.html close to what you
> are trying to achieve here?

Yes, that is what I tried to achieve. Using CGI to set attributes
was to quote characters which cannot be in double quited attribute values,
i.e. change '"' to '&#34;' or '&quot;'. I don't know what start_td did with
\"o character (Perl v5.8.6, CGI::VERSION=3.05).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
