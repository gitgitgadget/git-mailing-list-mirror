From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/4] t0024, t5000: use test_lazy_prereq for UNZIP
Date: Sun, 06 Jan 2013 22:59:16 +0100
Message-ID: <50E9F3B4.2080103@lsrfire.ath.cx>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org> <50E9B82D.50005@lsrfire.ath.cx> <50E9B90C.2060200@lsrfire.ath.cx> <20130106180621.GA16494@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 22:59:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TryFn-0006rE-Bv
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 22:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114Ab3AFV7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 16:59:20 -0500
Received: from india601.server4you.de ([85.25.151.105]:37119 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab3AFV7T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 16:59:19 -0500
Received: from [192.168.2.105] (p579BE5C2.dip.t-dialin.net [87.155.229.194])
	by india601.server4you.de (Postfix) with ESMTPSA id 8C982193;
	Sun,  6 Jan 2013 22:59:17 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130106180621.GA16494@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212848>

Am 06.01.2013 19:06, schrieb Matt Kraai:
> On Sun, Jan 06, 2013 at 06:49:00PM +0100, Ren=E9 Scharfe wrote:
>> This change makes the code smaller and we can put it at the top of
>> the script, its rightful place as setup code.
>
> Would it be better to add the setting of GIT_UNZIP and
> test_lazy_prereq to test-lib.sh so they aren't duplicated in both
> t0024-crlf-archive.sh and t5000-tar-tree.sh, something like the
> following (modulo UNZIP/GIT_UNZIP)?

We could do that in a follow-up patch, but I'm not sure it's worth it=20
for the two use cases.

Ren=E9
