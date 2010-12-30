From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: custom diff - text file diary entries
Date: Thu, 30 Dec 2010 14:47:27 +0100
Message-ID: <AANLkTinzKdQbMt+4uod05aAWfeK5xJ_JBhQhDaMFsLzy@mail.gmail.com>
References: <AANLkTimPTYEWr0qQwYM4jmJSLcrLRt27GC0nTVgVzHK2@mail.gmail.com>
 <4D1C7979.9050400@op5.se> <AANLkTinAJ=Dzn6u7Xu=dqkzm+tiB2M_nGE2=EzRDnPEa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Zenaan Harkness <zen@freedbms.net>
X-From: git-owner@vger.kernel.org Thu Dec 30 14:47:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYIrD-0002mM-HQ
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 14:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab0L3Nrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 08:47:49 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49184 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab0L3Nrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 08:47:48 -0500
Received: by qyk12 with SMTP id 12so12342204qyk.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 05:47:47 -0800 (PST)
Received: by 10.229.83.198 with SMTP id g6mr14514689qcl.157.1293716867481;
 Thu, 30 Dec 2010 05:47:47 -0800 (PST)
Received: by 10.229.215.129 with HTTP; Thu, 30 Dec 2010 05:47:27 -0800 (PST)
In-Reply-To: <AANLkTinAJ=Dzn6u7Xu=dqkzm+tiB2M_nGE2=EzRDnPEa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164359>

On Thu, Dec 30, 2010 at 1:36 PM, Zenaan Harkness <zen@freedbms.net> wrote:
> On Thu, Dec 30, 2010 at 23:22, Andreas Ericsson <ae@op5.se> wrote:
>> On 12/30/2010 12:33 PM, Zenaan Harkness wrote:
>>> Problem:
>>> Separate text file diary entries, committed in separate repos,
>>> cause merge clash when pushed to central repo,
>>> since git thinks the two entries are a single conflicting entry
>>> (since they begin at the same location in the same file).
>>>
>>> What we need is two diary entries automatically detected and inserted
>>> into the one file, one above the other (ordering is not so important).
> ...
>> If you really, really want to use git for this, you could create your
>> own custom merge driver. How to do so is reasonably well documented in
>> examples and man-pages. You'll want to sneak a peak at the attributes
>> page.
>
> "custom merge driver .. attributes page"

Maybe you are interested also in these ChangeLog merge driver for git:

https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#git-merge-changelog

HTH,
Santi
