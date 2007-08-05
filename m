From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: way to automatically add untracked files?
Date: Sun, 5 Aug 2007 22:04:41 +0200
Message-ID: <C3725674-7B33-4B2F-9386-704540D51C0E@zib.de>
References: <873ayymzc1.fsf@catnip.gol.com> <fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com> <20070805041320.GH9527@spearce.org> <200708051411.25238.johan@herland.net> <20070805161117.GE28263@thunk.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miles Bader <miles@gnu.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Aug 05 22:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHmMJ-0002EQ-5q
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 22:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760566AbXHEUFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 16:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756750AbXHEUFi
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 16:05:38 -0400
Received: from mailer.zib.de ([130.73.108.11]:51810 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758156AbXHEUFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 16:05:36 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l75K4x6T013657;
	Sun, 5 Aug 2007 22:05:04 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10786.pool.einsundeins.de [77.177.7.134])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l75K3n7H018735
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 5 Aug 2007 22:03:55 +0200 (MEST)
In-Reply-To: <20070805161117.GE28263@thunk.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55067>


On Aug 5, 2007, at 6:11 PM, Theodore Tso wrote:

> On Sun, Aug 05, 2007 at 02:11:24PM +0200, Johan Herland wrote:
>> $ hg addremove --help
>> hg addremove [OPTION]... [FILE]...
>>
>> add all new files, delete all missing files
>>
>>     Add all new files and remove all missing files from the  
>> repository.
>>
>>     New files are ignored if they match any of the patterns  
>> in .hgignore. As
>>     with add, these changes take effect at the next commit.
>>
>> Adding a git-addremove command should not be much work, and it  
>> would be a
>> lot friendlier to people whose workflow is more aligned with #2  
>> than #1.
>
> Not much work at all:
>
> # git config --system --add alias.addremove "git add . ; git add -u"

But how can I handle the [FILE]... from above?

	Steffen
