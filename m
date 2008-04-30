From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use perl instead of tac
Date: Wed, 30 Apr 2008 11:25:38 -0400
Message-ID: <5374CF8E-3E6E-480B-A23B-13BE85C7ABCF@silverinsanity.com>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <slrng1be8l.25r.joerg@alea.gnuu.de> <86k5iib0g9.fsf@blue.stonehenge.com> <slrng1bqhb.25r.joerg@alea.gnuu.de> <04EB077D-CB35-4253-A9EA-2085890C3639@silverinsanity.com> <20080430090206.GA21826@alea.gnuu.de>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Wed Apr 30 17:26:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrECU-0004Ww-Fv
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 17:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbYD3PZm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Apr 2008 11:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754873AbYD3PZl
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 11:25:41 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38830 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbYD3PZl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Apr 2008 11:25:41 -0400
Received: from [192.168.1.7] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 1C91A1FFD6C5;
	Wed, 30 Apr 2008 15:25:36 +0000 (UTC)
In-Reply-To: <20080430090206.GA21826@alea.gnuu.de>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80840>


On Apr 30, 2008, at 5:02 AM, J=F6rg Sommer wrote:

>> I also dislike the large lists this is carrying around in shell
>> variables.  If I'm reading it correctly, the tag list could be =20
>> replaced
>> by invocations of "git describe --exact-match".
>
> Yes. How to get all tags of a commit?
>
> % git tag foo v1.5.5
> % git describe --exact-match 9d831805195ba40b62f632acc6bb6e53d3
> warning: tag 'v1.5.5' is really 'foo' here
> v1.5.5

I wish I could be clever and say I pointed this out as an obviously =20
wrong answer or similar.  But, no, I simply didn't think of that.  The =
=20
long list may be required, despite my concerns about it..  :-(

Those concerns being: overrunning the length of a shell variable, the =20
speed of constructing and searching the list, over-complexity of the =20
code.  But, of course, if there isn't another way to do it right then =20
the list stays.

~~ Brian