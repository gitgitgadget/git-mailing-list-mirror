From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git gc --auto: defer on battery
Date: Mon, 31 Mar 2008 13:31:54 -0500
Message-ID: <47F12E1A.1020602@nrlssc.navy.mil>
References: <20080330231408.GR11666@genesis> <47F11036.1000809@nrlssc.navy.mil> <20080331173801.GD10018@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 20:33:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgOou-0002RL-JO
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 20:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbYCaScp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 14:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754416AbYCaSco
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 14:32:44 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55397 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbYCaSco (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 14:32:44 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2VIVtRM017834;
	Mon, 31 Mar 2008 13:31:55 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 31 Mar 2008 13:31:55 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <20080331173801.GD10018@genesis.frugalware.org>
X-OriginalArrivalTime: 31 Mar 2008 18:31:55.0143 (UTC) FILETIME=[7EF73170:01C8935D]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15820001
X-TM-AS-Result: : Yes--11.503000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY3My03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDE2MC03MDM3ODgtNzAwNzU2LTcwNDQyNS03?=
	=?us-ascii?B?MDc3ODgtNzAwMTk0LTcwNTEwMi03MDkxODUtNzAxMjk4LTE0ODAz?=
	=?us-ascii?B?OS0xNDgwNTEtMjAwNDI=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78596>

Miklos Vajna wrote:
> On Mon, Mar 31, 2008 at 11:24:22AM -0500, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> Miklos Vajna wrote:
>>> This patch modifies git gc --auto so that it will not always repack when
>>> a user is on battery.
>>>
>>> It introduces the new gc.deferonbattery configuration variable,
>> Shouldn't the config option have 'auto' in the name? Or in some way convey
>> that this is _only_ about deferring automatic gc'ing?
> 
> That makes sense. Though this patch isn't OK, see my other patch series
> in this thread (the pre-auto-gc hook has no config name).

Ah, yes I didn't look closely at the revised series.

-brandon
