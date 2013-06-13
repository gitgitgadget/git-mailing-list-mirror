From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH 2/3] Move copy_note_for_rewrite + friends from builtin/notes.c to notes-utils.c
Date: Thu, 13 Jun 2013 08:45:21 +0200
Message-ID: <20130613064521.GA21707@inner.h.apk.li>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org> <1370995981-1553-1-git-send-email-johan@herland.net> <1370995981-1553-3-git-send-email-johan@herland.net> <CAMP44s2pUW_+w6B_R-A=vxOg1Ay6iLmc4MQsA_sfDF+GP-XsWw@mail.gmail.com> <CALKQrgfxrKz5bB=AAmL1ZtBFRK2Bx6TrRd1AsMEVv8bTAH0KCg@mail.gmail.com> <CAMP44s3KAeDPo1Cw8eFsU=A6H7oUGmf+eLAMvGV+R2_hPXHLbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, gitster@pobox.com,
	git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	artagnon@gmail.com, john@keeping.me.uk, vfr@lyx.org, peff@peff.net,
	torvalds@linux-foundation.org, Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 08:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un1Hu-0002cC-QI
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 08:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495Ab3FMGpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 02:45:34 -0400
Received: from continuum.iocl.org ([217.140.74.2]:59302 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab3FMGpe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 02:45:34 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r5D6jLR22016;
	Thu, 13 Jun 2013 08:45:21 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s3KAeDPo1Cw8eFsU=A6H7oUGmf+eLAMvGV+R2_hPXHLbw@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227700>

On Wed, 12 Jun 2013 13:28:05 +0000, Felipe Contreras wrote:
...
> And you are
> doing that with the express purpose of annoying.

Where did 'assume good faith' go to today?

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
