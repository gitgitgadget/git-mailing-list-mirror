From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git gc --auto: defer on battery
Date: Mon, 31 Mar 2008 11:24:22 -0500
Message-ID: <47F11036.1000809@nrlssc.navy.mil>
References: <20080330231408.GR11666@genesis>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 18:26:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgMpm-00056e-2V
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 18:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbYCaQY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 12:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753461AbYCaQY6
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 12:24:58 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55131 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641AbYCaQY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 12:24:57 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2VGONhg015640;
	Mon, 31 Mar 2008 11:24:23 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 31 Mar 2008 11:24:23 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <20080330231408.GR11666@genesis>
X-OriginalArrivalTime: 31 Mar 2008 16:24:23.0063 (UTC) FILETIME=[ADF87270:01C8934B]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15820001
X-TM-AS-Result: : Yes--8.422000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY3My03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMzc4OC03MDA3NTYtNzA0NDI1LTcwNzc4OC03?=
	=?us-ascii?B?MDAxOTQtNzA1MTAyLTE0ODAzOS0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78590>

Miklos Vajna wrote:
> This patch modifies git gc --auto so that it will not always repack when
> a user is on battery.
> 
> It introduces the new gc.deferonbattery configuration variable,

Shouldn't the config option have 'auto' in the name? Or in some way convey
that this is _only_ about deferring automatic gc'ing?

-brandon
