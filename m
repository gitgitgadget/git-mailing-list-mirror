From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: What's cooking in git.git (Dec 2012, #04; Sun, 16)
Date: Tue, 18 Dec 2012 09:28:05 +0100
Message-ID: <kap9eo$j5c$1@ger.gmane.org>
References: <20121217213730.GA17212@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 09:28:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TksXY-0006r7-Ez
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 09:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423Ab2LRI2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 03:28:22 -0500
Received: from plane.gmane.org ([80.91.229.3]:53191 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754237Ab2LRI2W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 03:28:22 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TksXQ-0006lS-Fr
	for git@vger.kernel.org; Tue, 18 Dec 2012 09:28:32 +0100
Received: from dsdf-4db52f94.pool.mediaways.net ([77.181.47.148])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Dec 2012 09:28:32 +0100
Received: from jojo by dsdf-4db52f94.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Dec 2012 09:28:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db52f94.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211738>

Matt Kraai wrote:
> Junio C Hamano wrote:
>> It could turn out that we may be able to get rid of sys/param.h
>> altogether, but one step at a time.  Inputs from people on minority
>> platforms are very much appreciated---does your platform build fine
>> when the inclusion of the file is removed from git-compat-util.h?
> 
> QNX builds fine when sys/param.h is not included.

HP-NonStop build fine too without it.

Bye, Jojo
