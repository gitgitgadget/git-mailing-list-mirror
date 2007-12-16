From: Luke Diamand <luke@vidanti.com>
Subject: Re: One of my commits is missing
Date: Sun, 16 Dec 2007 09:11:31 +0000
Message-ID: <4764EBC3.4090800@vidanti.com>
References: <47645232.7050502@vidanti.com> <cmu-lmtpd-1776-1197757787-0@salieri>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 10:12:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3pXo-0006ee-Gf
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 10:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665AbXLPJLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 04:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756076AbXLPJLr
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 04:11:47 -0500
Received: from c2bthomr13.btconnect.com ([213.123.20.131]:11006 "EHLO
	c2bthomr13.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbXLPJLq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 04:11:46 -0500
Received: from salieri.ballroom.vidanti.com 
	by c2bthomr13.btconnect.com
	with ESMTP id DQX61387;
	Sun, 16 Dec 2007 09:11:37 GMT
Received: from [10.9.0.18]
	by salieri.ballroom.vidanti.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <luke@vidanti.com>)
	id 1J3pX5-0000JA-9X; Sun, 16 Dec 2007 09:11:35 +0000
User-Agent: Icedove 1.5.0.14pre (X11/20071018)
In-Reply-To: <cmu-lmtpd-1776-1197757787-0@salieri>
X-Junkmail-Status: score=10/50, host=c2bthomr13.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0204.4764EAA0.0192,ss=1,fgs=0,
	ip=0.0.0.0,
	so=2006-12-09 10:45:40,
	dmn=5.4.3/2007-11-16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68450>

Thanks! That found it.

Shawn O. Pearce wrote:
> Luke Diamand <luke@vidanti.com> wrote:
>> My last commit seems to have vanished, and I wonder if anyone knows 
>> where it might have gone.
> ...
>> Looking through my history I don't see any signs of errant git-reset's 
>> so I'm baffled.
> 
> 
> I'm baffled too.  Have a look at your HEAD reflog and see if you
> can find it there (`git log -g`) as if you actually did in fact
> create it with git-commit it should appear in that reflog for at
> least the next 90 days (by default config anyway).
> 
