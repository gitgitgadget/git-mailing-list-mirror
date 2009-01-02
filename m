From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: git-difftool
Date: Fri, 2 Jan 2009 01:04:01 +0100
Message-ID: <200901020104.01522.markus.heidelberg@web.de>
References: <20081226013021.GA15414@gmail.com> <vpqhc4kz5zh.fsf@bauges.imag.fr> <46dff0320812312338i5a3ee0cem702a6b67ef76e48c@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"David Aguilar" <davvid@gmail.com>, git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 01:06:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIXXI-00005x-Hw
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 01:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbZABADt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 19:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbZABADt
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 19:03:49 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:42744 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbZABADt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 19:03:49 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 9437EF62917A;
	Fri,  2 Jan 2009 01:03:45 +0100 (CET)
Received: from [89.59.70.163] (helo=pluto)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LIXVy-0006uX-00; Fri, 02 Jan 2009 01:03:46 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <46dff0320812312338i5a3ee0cem702a6b67ef76e48c@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19VdzsWDoSSkLdtbD9O5uyiVZ8+3CFddncTUiMZ
	lst5/anJLOj+oxjcy5y4Pc+vdTGEQ2CvanpFJObrgJjxv2HWLT
	WVh/KTIluU0ygssV0jSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104346>

Ping Yin, 01.01.2009:
> On Thu, Jan 1, 2009 at 12:04 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> > David Aguilar <davvid@gmail.com> writes:
> >
> >> The usual use case for this script is when you have either
> >> staged or unstaged changes and you'd like to see the changes
> >> in a side-by-side diff viewer (e.g. xxdiff, tkdiff, etc).
> >>
> >>       git difftool [<filename>*]
> >
> > Is it not a complex way of saying
> >
> >        GIT_EXTERNAL_DIFF=xxdiff git diff
> 
> $ cat mydiff
> #!/bin/bash
> exec vimdiff $2 $5
> 
> then i run
> 
> $ GIT_EXTERNAL_DIFF=mydiff  git diff
> 
> but it gives me the error
> Vim: Warning: Output is not to a terminal

Just the warning and everything else works? For me the display is
totally screwed up and the commands don't really work because of the
pager. I have to add GIT_PAGER="" to get it working.

Markus
