From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 12:41:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704101239170.27318@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> 
 <200704101828.37453.Josef.Weidendorfer@gmx.de> 
 <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
 <200704102004.08329.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 05:50:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbMhN-0007bm-1G
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 22:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030517AbXDJUMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 16:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbXDJUMN
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 16:12:13 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:38513 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1030517AbXDJUMM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 16:12:12 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 10 Apr 2007 13:12:11 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 10 Apr 2007 13:12:07 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <200704102004.08329.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44176>

On Tue, 10 Apr 2007, Andy Parkins wrote:

> On Tuesday 2007, April 10, Linus Torvalds wrote:
>
>> (But there's nothing that says that the ".gitmodules" file couldn't
>> just use the same parser as the git config file, so I don't really
>> strongly care either way. I just think it would be nice to be able to
>> say
>>
>> 	[module "kdelibs"]
>> 		dir = kdelibs
>> 		url = git://git.kde.org/kdelibs
>> 		description = "Basic KDE libraries module"
>>
>> 	[module "base"]
>> 		alias = "kdelibs", "kdebase", "kdenetwork"
>>
>> or whatever. You get the idea..)
>
> Would it be nicer if .gitmodules were line-based to aid in merging?

this is very similar to the problem I asked about with merging config files a 
couple weeks ago. the answer then was that when we get .gitattributes we should 
be able to specify content specific merge programs that could deal with this 
sort of thing on a per-file basis. That sounds like the answer to your concern 
as well, rather then makeing things order dependant and otherwise harder to read 
to make it able to be merged with the current tools (which assume line-based 
order-dependant content)

David Lang
