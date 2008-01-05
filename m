From: JM Ibanez <jm@orangeandbronze.com>
Subject: Re: [PATCH] git-stash: add new 'drop' subcommand
Date: Sat, 05 Jan 2008 17:26:20 +0800
Organization: Orange & Bronze Software Labs, Ltd. Co.
Message-ID: <871w8woc77.fsf@adler.orangeandbronze.com>
References: <1199495198-26270-1-git-send-email-casey@nrlssc.navy.mil>
	<477EDDD4.5060509@nrlssc.navy.mil>
	<20080105035118.GB26892@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 05 10:27:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB5J3-0008W0-Fy
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 10:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbYAEJ0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 04:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbYAEJ0a
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 04:26:30 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:4257 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbYAEJ03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 04:26:29 -0500
Received: by wa-out-1112.google.com with SMTP id v27so11041187wah.23
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 01:26:28 -0800 (PST)
Received: by 10.114.110.1 with SMTP id i1mr17669460wac.112.1199525188602;
        Sat, 05 Jan 2008 01:26:28 -0800 (PST)
Received: from adler.orangeandbronze.com ( [58.69.81.96])
        by mx.google.com with ESMTPS id v25sm30604348wah.14.2008.01.05.01.26.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2008 01:26:28 -0800 (PST)
Jabber-ID: jmibanez@gmail.com
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAMFBMVEUBAQEPDw8aGhoiIiIy
 MjJGRkZaWlp0dHScnJy+vr7R0dHb29vn5+fx8fH29vb///+JzcfYAAAAAWJLR0QAiAUdSAAAAAlw
 SFlzAAAewgAAHsIBbtB1PgAAAi5JREFUOMul1E9o01AYAPAvUQ87JV+3gcemrYi32q7oQRC7gtWD
 OLs6jx5svQhDCk0GggeHTaWgt/ZF5gRlkHZePCg0lTE8SWvnUXHU3QRxyYYryrCpr4PlT81OeyE5
 fD/y5b0v73vQP2DA4aBcWvMEQjJvPKAiF66nhSsrw9CNFnOIo3PyMKRj6cmoEJt/sOiGrhBHFpnx
 qdScG64FAODEWCJ9ddoFOyhQGJ3wx6eCj51wOoDAABNmghHfrAP+BC4gD8AzvI8Nn3HAr0xUQJoL
 WIbng+dtmB58AXiajd7MfQu6ftgfNCFrvbENdpwC4j5sWXFm73HMSrVqxfdmMG7Be2BxIpGYDIIw
 mPSYPSuYEUVRKmTjg2ViyIYtpSITeuUEnkdfzFGSWr1aJwoppwLI+C46QFWVOlluatrbCJ5MOqCp
 1bTyrUsfO8bn1MK3NRt8Txsv8Wi+pOumpLUcAMebD7NK651h/LintlZsyEaUQkjStI7595XaWrQg
 BDhyF2Ck1NNN42tz1gIBjswMinGj0zfM9RZn/yiAyzcp3NH7Rr/93YZtZM69pmV6plMxNhzrSLEL
 XxCZtkHjq5wDfkvt9Rd4qm2YfZNzbp/eB13/ebth0Ew9N6ib+uYSrYhufnJv0eTyUvpRodrobHBu
 2CGiRHJniw0YboOKmE1hUnzODcNuRVJIPgP/txohspoPcx49SHfDPOfRnLtyUfZ79nmt+oTzhCKB
 A04GONwh8w9J0EXBeLkUcQAAAABJRU5ErkJggg==
In-Reply-To: <20080105035118.GB26892@coredump.intra.peff.net> (Jeff King's message of "Fri\, 4 Jan 2008 22\:51\:18 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69657>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 04, 2008 at 07:31:00PM -0600, Brandon Casey wrote:
>
>> Thus far I haven't been a big user of git stash, but I plan to
>> use it more and I expect to use 'drop' more often than
>> 'clear'. I expect in the common case there will be a single
>
> There was some discussion of a sensible name, but I don't recall seeing
> a resolution on this: why not "clear stash@{0}" to clear one, and
> "clear" to clear all? Otherwise, I foresee "git stash clear stash@{0}"
> followed by "oops, I just deleted all of my stashes."

I actually got hit by this. I didn't know that stash clear affected all
stashes and lost quite a bit of work that way (I use stash to store
various test database configs for a tree I work with, and so lost all of
them when trying to remove one particular stash).

> I guess you get "git stash drop" as a synonym for "git stash drop
> stash@{0}" this way, but it just seems mean to users to make them
> remember which of "drop" and "clear" does what they want.

I have to agree with this.

-- 
JM Ibanez
Software Architect
Orange & Bronze Software Labs, Ltd. Co.

jm@orangeandbronze.com
http://software.orangeandbronze.com/
