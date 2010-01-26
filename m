From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv11 12/20] Builtin-ify git-notes
Date: Tue, 26 Jan 2010 03:09:15 +0100
Message-ID: <201001260309.15363.johan@herland.net>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
 <1263762277-31419-13-git-send-email-johan@herland.net>
 <780e0a6b1001211028t35a19e2la6bb92f8ba94a689@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 03:09:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZart-0007wZ-Ud
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 03:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab0AZCJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 21:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487Ab0AZCJT
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 21:09:19 -0500
Received: from smtp.getmail.no ([84.208.15.66]:58362 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751396Ab0AZCJS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 21:09:18 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWU00E680NGA010@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Jan 2010 03:09:16 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWU00IC90NF6120@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Jan 2010 03:09:16 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.26.15719
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <780e0a6b1001211028t35a19e2la6bb92f8ba94a689@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138022>

On Thursday 21 January 2010, Stephen Boyd wrote:
> On Sun, Jan 17, 2010 at 1:04 PM, Johan Herland <johan@herland.net> wrote:
> > +
> > +               if (launch_editor(path, buf, NULL)) {
> > +                       fprintf(stderr, "Please supply the note
> > contents using" +                               " either -m or -F
> > option.\n"); +                       exit(1);
> 
> die()?

Yes, thanks. Will be part of the next iteration.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
