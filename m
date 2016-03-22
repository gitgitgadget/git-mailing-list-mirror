From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: When does git check for branch-X being uptodate with origin/branch-X?
Date: Tue, 22 Mar 2016 17:51:15 -0000
Organization: OPDS
Message-ID: <F2B253E6836D4C948D85BADEAE2527C0@PhilipOakley>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com> <20160321202810.GD32071@sigill.intra.peff.net> <CA+39Oz4Atuv3N0QNj8o1SYgHzMUyES1QHUsWh-MdNiNr-xPM_w@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Thomas Adam" <thomas.adam22@gmail.com>,
	"Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 20:29:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiRzt-00078b-Sb
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 20:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbcCVT3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 15:29:41 -0400
Received: from smtp-d-3.talktalk.net ([78.144.6.131]:57598 "EHLO
	smtp-d-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbcCVT3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 15:29:40 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Mar 2016 15:29:40 EDT
Received: from PhilipOakley ([92.22.60.12])
	by smtp.talktalk.net with SMTP
	id iRrpaMRAcavFfiRrqaAGJX; Tue, 22 Mar 2016 19:21:27 +0000
X-Originating-IP: [92.22.60.12]
X-Spam: 0
X-Authority: v=2.1 cv=M9ntU3Es c=1 sm=1 tr=0 a=N5WQhPxwIJU6fDAmqiwHsA==:117
 a=N5WQhPxwIJU6fDAmqiwHsA==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=PKzvZo6CAAAA:8
 a=239XeQVkUE_0yZpubzAA:9 a=QEXdDO2ut3YA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfGNXAjzaSvRB0un8bgEveg+MG4IUczJaaibYRKWfHMl9Zy8c7C9MGWXpb9V4E/aF99rM4h8qokvpPZEUvMJ5hzbydlXY/OQ907lTBwR3eXJTkPOQrCGo
 9gqsrLg6R2m30OvKvGXzxHI7P8wjCsxQ6Zt/U7mxQyHb9J6PuuE2eD9F9PAxx9kB8GuyC2+CsSYrLfj7JUphdG0Xl3Ug0ihxm7ns1XeADXHOUz2MjmjAdJdq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289546>

From: "Thomas Adam" <thomas.adam22@gmail.com>
Sent: Monday, March 21, 2016 8:43 PM
> On 21 March 2016 at 20:28, Jeff King <peff@peff.net> wrote:
>> We never contact other repositories unless explicitly asked to by
>> fetch, pull, push, etc. If you want to have the most up-to-date value
>> without merging, you can just "git fetch" to update the tracking
>> branches.
>
> Thanks.  I understand how to use git-fetch, it's more a case of
> whether even printing that message is useful?  I appreciate it can
> only go on the cached value, but it is still misleading to print that
> in the case where the cache might not be up to date.  Of course,
> determining that is a different problem.
>
> -- Thomas Adam

This issue (that the tracking is passive, not 'active') may also be 
something for the 'Beginner mode' discussion.

The rtb (remote tracking branch) was something I'd noted earlier in the 
initial 'Beginner mode', discussion, $gmane/288727/focus=288812 (GSoC 
Introduction; 14 Mar '16, 22:08)

"The Git data model is very powerful and it does take a lot of 'unlearning'
of old expectations (which is very hard) before the capabilities of the git
model become well established in the users mind. For example, remote
tracking branches are not remote but local, and are a reverse polish
description (a local branch which keeps track of a remote's branch, from the
last time you looked).

Different people get different parts of the model in different orders and
different rates. Identifying the many issues (in model understanding) may be
a start for identifying which command/options should be targeted."

--
Philip 
