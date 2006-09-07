From: David Lang <dlang@digitalinsight.com>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 6 Sep 2006 17:06:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0609061705160.4398@qynat.qvtvafvgr.pbz>
References: <44FF41F4.1090906@gmail.com>  <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
  <44FF5C27.2040300@gmail.com>  <Pine.LNX.4.64.0609061651500.27779@g5.osdl.org>
 <9e4733910609061710x4fb48d86o58b9c5ec8e527135@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>,
	A Large Angry SCM <gitzilla@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 02:14:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL7XO-0003aw-VA
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 02:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWIGAOb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 20:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbWIGAOb
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 20:14:31 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:43180 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1161015AbWIGAOa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 20:14:30 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Wed, 6 Sep 2006 17:14:30 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Wed, 06 Sep 2006 17:14:24 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609061710x4fb48d86o58b9c5ec8e527135@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26575>

On Wed, 6 Sep 2006, Jon Smirl wrote:

> On 9/6/06, Linus Torvalds <torvalds@osdl.org> wrote:
>> Is there any way to get zlib to just generate a suggested dictionary from
>> a given set of input?
>
> No, I asked the author. Apparently it is a hard problem, there have
> been research papers written about it.
>
> Shawn has a Perl script that makes a guess at a dictionary. That
> scripts gets 4-7% improvement. The number one thing that ended up in
> the Mozilla dictionary was the five different license versions that
> had each been copied into 50,000 files over time.

for the mozilla project it may make sense to feed all these license files from 
all over as one string to git, as an exception to your normal process of going 
file by file. if you can do this then the delta functionality should reduce 
these files to practicaly nothing.

David Lang
