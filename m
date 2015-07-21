From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v8 0/7] ref backend preamble
Date: Tue, 21 Jul 2015 07:02:43 -0700
Message-ID: <55AE5103.7020907@alum.mit.edu>
References: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	j6t@kdbg.org
X-From: git-owner@vger.kernel.org Tue Jul 21 16:02:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHY8C-0006NS-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 16:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbbGUOCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 10:02:48 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55163 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755037AbbGUOCr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2015 10:02:47 -0400
X-AuditID: 1207440d-f79136d00000402c-86-55ae510506cf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id AB.53.16428.5015EA55; Tue, 21 Jul 2015 10:02:45 -0400 (EDT)
Received: from [172.20.208.234] ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6LE2iEq008251
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 21 Jul 2015 10:02:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1GUNXBdq8O64tsX8TScYLbqudDNZ
	PJl7l9mB2ePhqy52jwXP77N7fN4kF8AcxW2TlFhSFpyZnqdvl8CdcW99G0vBKvaKBztvsTcw
	fmLtYuTgkBAwkZjb59fFyAlkiklcuLeerYuRi0NI4DKjxOYNe5ghnE1MEr0zpzOCVPEKaEvc
	PvadGaSZRUBV4tMNsGY2AV2JRT3NTCBhUYEgidcvcyGqBSVOznzCAmKLCPhJbOuaAzZFWMBA
	Yu7hc2wgtpCAh8SxtX+YQGxOAU+JdZemM4PYzAJ6Ejuu/2KFsOUlmrfOZp7AyD8LydhZSMpm
	ISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMkQHl3MP5fJ3OIUYCD
	UYmHt6JlbagQa2JZcWXuIUZJDiYlUV59o3WhQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4v9gD
	5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErwr/IEaBYtS01Mr0jJz
	ShDSTBycIMO5pESKU/NSUosSS0sy4kHRGF8MjEeQFA/Q3p0g7bzFBYm5QFGI1lOMuhwLftxe
	yyTEkpeflyolzlsKUiQAUpRRmge3ApaOXjGKA30szHsGpIoHmMrgJr0CWsIEtOTWrDUgS0oS
	EVJSDYy8HX0sOyJU3Lc6lEz4u/vm40MeP/+ZxM24fj1Taomhuf9XsReeLG+PfPey+pLbv2RB
	z/mH37qOMRRdfNX/TOzbMd7lqn5BB28d8WeQ7fOfo71/y7sJLLu2NjQu9LL+IBHU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274379>

On 07/09/2015 03:50 PM, David Turner wrote:
> The current state of the discussion on alternate ref backends is that
> we're going to continue to store pseudorefs (e.g. CHERRY_PICK_HEAD) as
> files in $GIT_DIR.  So this re-roll of the refs backend preamble
> doesn't do anything to pseudorefs.  It just does reflog stuff.
> 
> In addition, this version removes the over-aggressive die() on reflog
> update failure from v7.  It adds the REF_FORCE_CREATE_REFLOG flag, as
> Michael Haggerty suggested.  And it fixes commit message or two, as
> suggested.  I believe this addresses all comments I've seen on v7.
> 
> This addresses Johannes Sixt's concerns too, by removing the offending
> code.

I just reviewed the whole patch series. Aside from the minor points that
I commented on, it all looks good to me.

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
