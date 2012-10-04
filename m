From: John Whitney <jjw@emsoftware.com>
Subject: Re: Bug report
Date: Thu, 04 Oct 2012 11:16:21 -0500
Message-ID: <506DB655.8020504@emsoftware.com>
References: <506D122E.2050404@emsoftware.com> <506DA992.7090904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:20:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtbD-00033L-HX
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757120Ab2JDQQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 12:16:26 -0400
Received: from mail.emsoftware.com ([76.75.201.49]:52187 "EHLO emsoftware.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757077Ab2JDQQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 12:16:25 -0400
Received: from Johns-MacBook-Pro.local (ppp-70-253-75-224.dsl.austtx.swbell.net [70.253.75.224])
	by emsoftware.com (Postfix) with ESMTP id 10E751AF5278;
	Thu,  4 Oct 2012 12:19:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <506DA992.7090904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206988>

Andrew,

Thanks for checking this on your machine.

This problem occurs on Mac, Windows, and Linux, and
with multiple versions of git. Note that in my script a CR
is appended to test.txt. On the Mac, you can generate this
in Terminal by pressing Ctrl-V Ctrl-M. Or, alternatively,
just download and run the script like this: "sh git_failure.sh"

    ---John


On 10/4/12 10:21 AM, Andrew Wong wrote:
> On 10/04/2012 12:35 AM, John Whitney wrote:
>> I just ran into a problem that I'm pretty sure is a bug in git. Just 
>> read and run this (fairly trivial) shell script to replicate.
> I tried your steps on a Mac, but I wasn't able to produce the issue. 
> Perhaps I don't have the right CRLF configs to trigger the issue. I've 
> tried it on v1.7.9.6, which came with Xcode, and v1.7.7. What git 
> version are you using? And, if any, what are your configs for 
> "core.eol", "core.safecrlf", and "core.autocrlf" ?
>
> What Phil said also makes sense though.
>


-- 
Great support for great users! Please visit http://emsoftware.com/support/ for our support policies, instructions and FAQs.
