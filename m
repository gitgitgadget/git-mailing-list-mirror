From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 16 Jan 2013 13:26:15 +0100
Message-ID: <kd669a$q15$1@ger.gmane.org>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com> <506AA51E.9010209@viscovery.net> <alpine.LNX.2.01.1301121927350.15558@nerf07.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 13:26:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvS4z-0007FD-4n
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 13:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880Ab3APM0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 07:26:32 -0500
Received: from plane.gmane.org ([80.91.229.3]:35923 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728Ab3APM0c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 07:26:32 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TvS4s-00071Q-Gu
	for git@vger.kernel.org; Wed, 16 Jan 2013 13:26:46 +0100
Received: from dsdf-4db500dd.pool.mediaways.net ([77.181.0.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 13:26:46 +0100
Received: from jojo by dsdf-4db500dd.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 13:26:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db500dd.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213749>

Jan Engelhardt wrote:
> On Tuesday 2012-10-02 10:26, Johannes Sixt wrote:
>>
>> Note that git commit -m A --allow-empty *DID* create a commit. Only,
>> that it received the same name (SHA1) as the commit you created
>> before it because it had the exact same contents (files, parents,
>> author, committer, and timestamps). Obviously, your script was
>> executed sufficiently fast that the two commits happend in the same
>> second.
>
> What about introducing nanosecond-granular timestamps into Git?

Not every platform (supported by git) does have a nanosecond clock 
resolution

Bye, Jojo 
