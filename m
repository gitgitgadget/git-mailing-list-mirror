From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2nd try] Make git-fmt-merge-msg a builtin
Date: Tue, 4 Jul 2006 09:50:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607040948170.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607031717540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwtaunwj1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 09:50:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxfgA-0005A2-V8
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 09:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWGDHuk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 03:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWGDHuk
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 03:50:40 -0400
Received: from mail.gmx.net ([213.165.64.21]:58339 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751197AbWGDHuj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 03:50:39 -0400
Received: (qmail invoked by alias); 04 Jul 2006 07:50:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 04 Jul 2006 09:50:38 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtaunwj1.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23265>

Hi,

On Mon, 3 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> >
> > ---
> > 	This retires git-fmt-merge-msg.perl, since it passes all the
> > 	tests, but removes the Perl version not now.
> 
> There is no point not removing the script if you update git.c
> and Makefile to point at the new one.

I should have put PATH/RFC. I did not want to remove the script right 
away, so people could compare outputs (like Martin did with 
git-format-patch).

> We do not have a test specific for fmt-merge-msg, so it
> obviously passes all the tests ;-).  A new one is attached.

Well, t4013 showed me two output bugs, but it evidently did not check for 
merge.summary.

> I think we should extend boolean to accept 'yes' and 'no',

In that case, could we have "YesPlease", "oui", "si" and "da", too? ;-)

Ciao,
Dscho
