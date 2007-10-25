From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Thu, 25 Oct 2007 12:39:06 +0200
Message-ID: <6AE2F79A-24EF-4F00-9D3E-742A47865FD1@zib.de>
References: <Pine.LNX.4.64.0710212308540.25221@racer.site>  <471C9B13.9080603@op5.se> <Pine.LNX.4.64.0710221445170.25221@racer.site>  <471CB443.9070606@op5.se> <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>  <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de>  <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de>  <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <8fe92b430710241648j609d4d00x121836001a69d1e6@mail.gmail.com> <472048EB.1000707@op5.se> <Pine.LNX.4.64.0710251106110.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Jakub Narebski <jnareb@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:38:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il06B-0002EL-G7
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 12:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820AbXJYKhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 06:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756798AbXJYKhq
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 06:37:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:62953 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755290AbXJYKhq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 06:37:46 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9PAbcwQ002884;
	Thu, 25 Oct 2007 12:37:38 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9PAbbC3010774
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 25 Oct 2007 12:37:37 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710251106110.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62307>


On Oct 25, 2007, at 12:07 PM, Johannes Schindelin wrote:

> Hi,
>
> On Thu, 25 Oct 2007, Andreas Ericsson wrote:
>
>> Jakub Narebski wrote:
>>> On 10/24/07, Andreas Ericsson <ae@op5.se> wrote:
>>>
>>>> git pull. Not git push. git pull operates on one working branch  
>>>> at a
>>>> time (by default), whereas git push uploads and fast-forwards all
>>>> the common branches (by default). I want git pull to work like git
>>>> push.
>>>
>>> git push is opposite (almost) to git fetch, not to git pull.
>>
>> Not to an end user that has no idea or desire to learn about git  
>> remotes
>> or anything else.
>
> At some point you _have_ to expect your users to learn something.   
> In the
> git documentation, we never pretend that pull is anything else than  
> "fetch
> + merge".
>
> So this assumption of your end user is a lack of training, really.

I typically describe in detail every step they need to get
there work done. I expect that a few, simple commands that can
be used per copy & paste should solve 90% of the cases.

Some users will learn more, some will refuse to learn
more. Users from the second group will typically consult a
more experienced user if they hit a problem. At at that point
they are forced to learn.

I don't expect that all users know all details and the users
expect that their daily workflow is well supported with a
few commands.

	Steffen
