From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-shortlog hangs on bare repo without --bare option
Date: Wed, 27 Aug 2008 23:40:52 +0200
Message-ID: <48B5C9E4.4030807@lsrfire.ath.cx>
References: <20080827195233.GA2477@garry-thinkpad.arpnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Garry Dolley <gdolley@arpnetworks.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 23:42:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYSmJ-0007Il-Ez
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 23:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbYH0VlG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 17:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbYH0VlF
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 17:41:05 -0400
Received: from india601.server4you.de ([85.25.151.105]:35222 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbYH0VlE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 17:41:04 -0400
Received: from [10.0.1.200] (p57B7F6D3.dip.t-dialin.net [87.183.246.211])
	by india601.server4you.de (Postfix) with ESMTPSA id 256FE2F8043;
	Wed, 27 Aug 2008 23:41:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080827195233.GA2477@garry-thinkpad.arpnetworks.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93958>

Garry Dolley schrieb:
> I didn't see this happen with git 1.5.x, but if you do git-shortlog o=
n a bare=20
> repo, without specifying --bare, the command will seemingly hang inde=
finitely.

=46WIW, I tried git 1.5.0 and it hangs, too.  Which exact version did w=
ork
for you?  Could you, based on it, bisect the commit that introduced thi=
s
behaviour?

As a workaround, you can use "git log | git shortlog".

Ren=E9
