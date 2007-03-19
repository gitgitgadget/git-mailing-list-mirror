From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 12:36:09 -0700
Message-ID: <45FEE629.8030606@midwinter.com>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org> <45FED31B.8070307@midwinter.com> <alpine.LFD.0.83.0703191427140.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 20:36:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTNeP-0006b1-N7
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 20:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbXCSTgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 15:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbXCSTgJ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 15:36:09 -0400
Received: from tater.midwinter.com ([216.32.86.90]:49891 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752760AbXCSTgI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 15:36:08 -0400
Received: (qmail 7407 invoked from network); 19 Mar 2007 19:36:05 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.129?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 19 Mar 2007 19:36:05 -0000
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <alpine.LFD.0.83.0703191427140.18328@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42657>

Nicolas Pitre wrote:
> Well...  the fact that you _still_ use GIT even in the face of a 1% 
> probability that it might guess renames wrong (according to your own 
> numbers) should mean that you didn't felt switching to Mercurial was 
> worth the 100% guarantee for rename identification.
>   

Yes, that's right, for me that's the correct tradeoff. For the person 
who asked the original question, it may or may not be. He seemed a lot 
more worried about the situation than I am. In my environment renames 
are relatively rare events, but maybe in his they happen more often.

> And some will argue that explicit renames are susceptible to user error 
> misidentifying the rename too, certainly in the 1% figure of all renames 
> if not more.
>   

If you're using "git mv" instead of "mv" to do the rename, it is 
impossible to misidentify the rename since the rename and identification 
are happening in the same command with no additional inputs that could 
confuse anything. If you are talking about adding a new tool that can 
manually tag a rename after the fact, then I can't disagree with you 
except to say that the fact that no such command exists today means any 
estimate of user error rate is pure speculation.

Aside from that, the possibility of user error is an entirely different 
thing than the possibility of tool error -- if I misidentify a rename, I 
will blame myself, not the version control system, and rightly so. 
People are expected to make mistakes from time to time. But if my 
version control tool misidentifies a rename on my behalf, and there's 
nothing I can do about it because there's no way to influence the tool's 
concept of what got renamed to what, then I'm not going to consider it a 
failure of the tool, not a mistake on my part.

> So maybe, just maybe, at the end of the day getting renames right 100% 
> of the time instead of 99% is not such a big thing after all.
>   

For me personally, that is true -- but I'd still prefer that extra 1%.

-Steve
