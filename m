From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: Merge, rebase and whitespace fixes
Date: Tue, 30 Jun 2009 11:03:01 +0200
Message-ID: <4A49D4C5.8090700@dawes.za.net>
References: <cb7bb73a0906291218m3ba43109s35cad87efc5161a7@mail.gmail.com>	 <4A493287.20106@dawes.za.net> <cb7bb73a0906300037w6b61cae0jeecd2f97b1095b17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Robert Fitzsimons <robfitz@273k.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 11:03:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLZFd-0003Yz-Rz
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 11:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbZF3JDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 05:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbZF3JDJ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 05:03:09 -0400
Received: from caiajhbdccac.dreamhost.com ([208.97.132.202]:55994 "EHLO
	homiemail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750937AbZF3JDI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2009 05:03:08 -0400
X-Greylist: delayed 41536 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2009 05:03:08 EDT
Received: from artemis.local (dsl-246-34-245.telkomadsl.co.za [41.246.34.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a6.g.dreamhost.com (Postfix) with ESMTP id 2F8ED1427D;
	Tue, 30 Jun 2009 02:03:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Macintosh/20090605)
In-Reply-To: <cb7bb73a0906300037w6b61cae0jeecd2f97b1095b17@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122501>

Giuseppe Bilotta wrote:
> On Mon, Jun 29, 2009 at 11:30 PM, Rogan Dawes<lists@dawes.za.net> wrote:
>> Giuseppe Bilotta wrote:
>>> Hello all,
>>>
>>> recently a tree I've been working on received some thorough whitespace
>>> adjustments (changing indents from spaces to tabs). This results in
>>> annoying conflicts when running merges or rebases with my local
>>> branches. I tried googling around but I couldn't find any helpful
>>> hints on how to make git cope with this. Any suggestions?
>>>
>> Do the same thing to your own tree?
> 
> I tried doing the whitespace cleanup on top of the last patch, but the
> merge still conflicted.
> 
> The interesting thing is that there's patchset from Robert Fitzsimons
> that goes back to August 2005 (!) that does a couple of git apply
> cleanups and in particular adds the --ignore-whitespace option that I
> would need ...
> 
> http://permalink.gmane.org/gmane.comp.version-control.git/7876
> 
> but the patch apparently never made it into mainline ...
> 

One thing I have done in the past when trying to merge two diverged
trees was to format each commit in each tree to a common standard.

One of the ways in which the trees had diverged was whitespace
(non-meaningful) changes, so I used the Eclipse formatter as part of a
"git filter-branch" script to make sure that I was ony looking at
meaningful changes between the trees at each point. This significantly
simplified the process.

Rogan
