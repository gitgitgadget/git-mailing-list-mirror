From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Two minor tweaks on git-gui where textboxes weren't vertically centered with their labels and buttons
Date: Thu, 22 May 2008 18:57:30 -0400
Message-ID: <20080522225730.GQ29038@spearce.org>
References: <412a1d9a0805172218v7c0a920es8a48129014051a35@mail.gmail.com> <20080519040746.GA29038@spearce.org> <412a1d9a0805182234i18e2da4ckf428b2c134e174d1@mail.gmail.com> <alpine.DEB.1.00.0805191127200.30431@racer> <7vej7w6syo.fsf@gitster.siamese.dyndns.org> <20080522121107.GK29038@spearce.org> <7v4p8qw7to.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Twiinz <twiinz@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 00:58:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzJjw-0006HC-Qv
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 00:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585AbYEVW5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 18:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754349AbYEVW5g
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 18:57:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53271 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311AbYEVW5f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 18:57:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JzJir-0003As-Ut; Thu, 22 May 2008 18:57:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 728C820FBAE; Thu, 22 May 2008 18:57:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v4p8qw7to.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82667>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > In this case it is a very trivial patch.
> 
> Yeah, I realized that I should have added that after sending the message.
> I'd rather not to see a patch without S-o-b than with a S-o-b with a
> phoney name, though.

Like this one?

  commit 2b36b146fa892a0a326eb2e35a39c9daf58fbe5e
  Author: A Large Angry SCM <gitzilla@gmail.com>
  Date:   Sat May 10 16:52:51 2008 -0400

    git-repack: re-enable parsing of -n command line option
    
    In commit 5715d0b (Migrate git-repack.sh to use git-rev-parse --parseopt,
    2007-11-04), parsing of the '-n' command line option was accidentally lost
    when git-repack.sh was migrated to use git-rev-parse --parseopt. This adds
    it back.
    
    Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

;-)

Are we starting to make a submission policy that all contributions
need to have a non-phony looking name for the author line and
SBO?  We have not done so in the past, and we do not have the
infrastructure like The Eclipse Foundation has to require all
contributors to execute a (possibly enforceable) legal agreement
stating their contribution can be distributed under the GPLv2.

-- 
Shawn.
