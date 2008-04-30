From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use perl instead of tac
Date: Wed, 30 Apr 2008 12:12:45 -0400
Message-ID: <728C10C4-D51E-4FDD-BD15-B99882E10500@silverinsanity.com>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <slrng1be8l.25r.joerg@alea.gnuu.de> <86k5iib0g9.fsf@blue.stonehenge.com> <slrng1bqhb.25r.joerg@alea.gnuu.de> <04EB077D-CB35-4253-A9EA-2085890C3639@silverinsanity.com> <20080430090206.GA21826@alea.gnuu.de> <20080430093950.GA16806@alea.gnuu.de>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Wed Apr 30 18:13:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrEwH-0000dU-Dl
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 18:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbYD3QMs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Apr 2008 12:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755102AbYD3QMs
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 12:12:48 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48007 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755072AbYD3QMr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Apr 2008 12:12:47 -0400
Received: from [192.168.1.7] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 7F72C1FFD6C5;
	Wed, 30 Apr 2008 16:12:42 +0000 (UTC)
In-Reply-To: <20080430093950.GA16806@alea.gnuu.de>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80843>


On Apr 30, 2008, at 5:39 AM, J=F6rg Sommer wrote:

> =85 but I found the problem. I don't know how to pass the list from o=
ne
> subshell to the other.
>
> % { echo pick; echo merge; a=3D12 } | { echo +$a+; while read line; d=
o =20
> echo $line; done; }
> ++
> pick
> merge
>
> The only idea I have is a file. Do you have a better idea?
>
> % { echo pick; echo merge; a=3D12 } >/tmp/tmp; \
>  { echo +$a+; while read line; do echo $line; done; } < /tmp/tmp
> +12+
> pick
> merge

No, I don't.  But I think the resulting code will be easier to read, =20
even with the file.

~~ Brian