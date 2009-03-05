From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or  configured
Date: Thu, 5 Mar 2009 23:25:44 +0100
Message-ID: <200903052325.44648.markus.heidelberg@web.de>
References: <20090305221529.GA25871@pvv.org> <fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com> <200903052322.02098.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 23:26:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfM1k-0004Lh-Hl
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 23:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008AbZCEWZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 17:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbZCEWZT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 17:25:19 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:45927 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391AbZCEWZS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 17:25:18 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id BEAB1F8FA58A;
	Thu,  5 Mar 2009 23:25:16 +0100 (CET)
Received: from [89.59.104.0] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LfM0C-0006LY-00; Thu, 05 Mar 2009 23:25:16 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <200903052322.02098.markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX185c37m/jqZhvB5ull1mTTXmGVk938kP/wk7ocX
	hCFsYzVSx/eUNKJ38mWTW1UY48u86CcfpfVQ+k1ni5LPH8UqRd
	8Ba14c+7ReNV8P7NyQOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112353>

Markus Heidelberg, 05.03.2009:
> Sverre Rabbelier, 05.03.2009:
> > Heya,
> > 
> > On Thu, Mar 5, 2009 at 23:15, Finn Arne Gangstad <finnag@pvv.org> wrote:
> > > Previously, git push [remote] with no arguments would behave like
> > > "git push <remote> :" if no push refspecs were configured for the remote.
> > > It may be too easy for novice users to write "git push" or
> > > "git push origin" by accident, so git will now push nothing, and give an
> > > error message in such cases.
> > 
> > Config option please, I very much like the current behavior.
> 
> git push --nothing  ? :)

Oh, I confused "config option" with "command line argument"...

Markus
