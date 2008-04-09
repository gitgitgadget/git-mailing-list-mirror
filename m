From: Bryan Donlan <bdonlan@fushizen.net>
Subject: Re: [PATCH 7/8] Use test_set_editor in t9001-send-email.sh
Date: Wed, 9 Apr 2008 10:16:16 -0400
Message-ID: <20080409141616.GB24402@shion.is.fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net> <1207704604-30393-1-git-send-email-bdonlan@fushizen.net> <1207704604-30393-2-git-send-email-bdonlan@fushizen.net> <1207704604-30393-3-git-send-email-bdonlan@fushizen.net> <1207704604-30393-4-git-send-email-bdonlan@fushizen.net> <1207704604-30393-5-git-send-email-bdonlan@fushizen.net> <1207704604-30393-6-git-send-email-bdonlan@fushizen.net> <1207704604-30393-7-git-send-email-bdonlan@fushizen.net> <47FC69CB.1080400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 16:33:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjbN1-0006YM-L4
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 16:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563AbYDIOcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 10:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754186AbYDIOcZ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 10:32:25 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:40506 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbYDIOcY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 10:32:24 -0400
Received: from hillmannl2.umeres.maine.edu ([130.111.243.252] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1Jjb60-0001EN-5u; Wed, 09 Apr 2008 14:16:16 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1Jjb60-0006PT-Eg; Wed, 09 Apr 2008 10:16:16 -0400
Content-Disposition: inline
In-Reply-To: <47FC69CB.1080400@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79108>

On Wed, Apr 09, 2008 at 09:01:31AM +0200, Johannes Sixt wrote:
> Bryan Donlan schrieb:
> > diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> > index 030f66c..0a65785 100755
> > --- a/t/t9001-send-email.sh
> > +++ b/t/t9001-send-email.sh
> > @@ -144,10 +144,7 @@ test_expect_success 'setup fake editor' '
> >  	chmod +x fake-editor
> >  '
> >  
> > -FAKE_EDITOR="$(pwd)/fake-editor"
> > -export FAKE_EDITOR
> > -GIT_EDITOR='"$FAKE_EDITOR"'
> > -export GIT_EDITOR
> > +test_set_editor "$(pwd)/fake-editor"
> >  
> >  test_expect_success '--compose works' '
> >  	clean_fake_sendmail &&
> 
> I'd squash this into 5/8 or 8/8. Dunno.

I split it out as it's not really related to the goals of 5/8 or 8/8,
but is rather pure elimination of code duplication. However if it's
considered better to squash it into 5/8 I'd be happy to do so.

Thanks,

Bryan
