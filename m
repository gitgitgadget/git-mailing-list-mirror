From: Joachim Berdal Haga <jobh@broadpark.no>
Subject: Re: [PATCH] git clean: Don't automatically remove directories when
 run within subdirectory
Date: Tue, 15 Apr 2008 16:46:13 +0200
Message-ID: <4804BFB5.8030605@broadpark.no>
References: <85fxtvj6y8.fsf_-_@lupus.strangled.net> <1208130578-24748-1-git-send-email-shawn.bohrer@gmail.com> <7v8wzgaoqy.fsf@gitster.siamese.dyndns.org> <20080414170643.GA10548@mediacenter> <48039FE5.5060309@broadpark.no> <20080415034417.GA2882@lintop> <48044C33.20006@broadpark.no> <20080415142601.GB10548@mediacenter>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joachim Berdal Haga <cjbhaga@broadpark.no>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 17:48:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlmwx-0008Ev-TG
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 17:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765295AbYDOPS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 11:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765194AbYDOPS2
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 11:18:28 -0400
Received: from mail-forward.uio.no ([129.240.10.42]:59981 "EHLO
	mail-forward.uio.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759950AbYDOPS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 11:18:27 -0400
X-Greylist: delayed 1939 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Apr 2008 11:18:27 EDT
Received: from mail-mx4.uio.no ([129.240.10.45])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <jobh@broadpark.no>)
	id 1JlmQ8-0007uI-IW; Tue, 15 Apr 2008 16:46:04 +0200
Received: from vizius.simula.no ([129.240.228.35])
	by mail-mx4.uio.no with esmtp (Exim 4.67)
	(envelope-from <jobh@broadpark.no>)
	id 1JlmQ8-0003cl-Be; Tue, 15 Apr 2008 16:46:04 +0200
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <20080415142601.GB10548@mediacenter>
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 3500C181C2AF61A4549DAACFBD67963DDE096F33
X-UiO-SR-test: 7D23AA9754295B0F5D98D1367EF2D0E51AD446CE
X-UiO-SPAM-Test: remote_host: 129.240.228.35 spam_score: -49 maxlevel 200 minaction 2 bait 0 mail/h: 1 total 179 max/h 13 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79604>

Shawn Bohrer wrote:
> On Tue, Apr 15, 2008 at 08:33:23AM +0200, Joachim Berdal Haga wrote:
>> like "Would not remove dir/ (-d not given)". But I also think that the
>> difference between "dir" and "dir/" is very (too?) subtle in this case and
>> therefore should require explicit approval/action from the user.
> 
> Yeah, I don't know how I feel about this.  I do think that the behavior
> with my current patch is technically correct, but you may be right that
> a trailing slash is subtle.  In most cases I use my shell's tab
> completion witch adds the trailing slash, and only remove it when
> needed.  Additionally, I could argue that by default we require explicit
> action to clean files by requiring -n or -f so hopefully users try -n
> first (I do).

I guess part of the story is that I dislike the -f requirement, because I see it 
as a case of "training users to use -f without thinking" (it's required for 
normal operation). But that's another story, and now that I've raised my points 
I'm quite happy to leave the final decision to you.

Cheers,
-j.
