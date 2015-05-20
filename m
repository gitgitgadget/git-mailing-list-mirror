From: Faheem Mitha <faheem@faheem.info>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Thu, 21 May 2015 00:43:17 +0530 (IST)
Message-ID: <alpine.DEB.2.11.1505210040570.9343@orwell.homelinux.org>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org> <vpq382rkvzf.fsf@anie.imag.fr> <d21002e0fa92b03c3d417c8996328563@www.dscho.org> <CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com> <alpine.DEB.2.11.1505202341170.9343@orwell.homelinux.org>
 <CAGZ79kb9xUZfa9923rrUP1x0T2=KzczmmNyYi5zD30mWKJ81KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 20 21:14:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9RW-0005qw-Op
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbbETTOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 15:14:11 -0400
Received: from rs145.luxsci.com ([64.49.212.113]:53123 "EHLO rs145.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbbETTOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 15:14:09 -0400
Received: from orwell.homelinux.org (triband-mum-59.183.37.231.mtnl.net.in [59.183.37.231])
	(authenticated bits=0)
	by rs145.luxsci.com (8.14.4/8.14.9) with ESMTP id t4KJE1ZY024187
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
	Wed, 20 May 2015 15:14:04 -0400
Received: from faheem (helo=localhost)
	by orwell.homelinux.org with local-esmtp (Exim 4.84)
	(envelope-from <faheem@faheem.info>)
	id 1Yv9Qm-0004Bf-0c; Thu, 21 May 2015 00:43:28 +0530
X-X-Sender: faheem@orwell.homelinux.org
In-Reply-To: <CAGZ79kb9xUZfa9923rrUP1x0T2=KzczmmNyYi5zD30mWKJ81KQ@mail.gmail.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
X-Lux-Comment: Message t4KJE1ZY024187 sent by user #87163
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269494>


On Wed, 20 May 2015, Stefan Beller wrote:

> On Wed, May 20, 2015 at 11:24 AM, Faheem Mitha <faheem@faheem.info> wrote:

>> So, is the repos corrupt or not? Also, I don't understand why you say

>>     There is no file 28/0c... however.

>> Why would you expect there to be? I don't see it mentioned in that list.

> Each object is stored at .git/objects/<xz>/<tail> with <xz> being the 
> first 2 characters of the sha1 and the tail the remaining 38 characters 
> of the sha1. I did not draw a conclusion yet, as I needed to run for a 
> meeting.

> So the object you're looking for is not there (stating this as a fact). 
> But why would you expect it to be there? At the time of sending the 
> previous email I tried to do a reverse search "Give me all objects, 
> which reference objectX" but did not succeed yet.

Ok. See my reply to Matthieu Moy for context. I make have been taking too 
much for granted before posting to this list. Maybe I should have asked 
here first.

As I wrote to him, I can reconstruct the original setup if anyone thinks 
it is worthwhile trying to investigate further.

                                                    Regards, Faheem Mitha
