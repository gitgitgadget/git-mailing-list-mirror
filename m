From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: migrating to git: keep subversion revision numbers (as tags?)
Date: Sun, 31 Jan 2010 10:04:50 +0200
Message-ID: <20100131080450.GB30470@Knoppix>
References: <20100130230829.GA3544@comppasch2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "fkater@googlemail.com" <fkater@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 09:06:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbUpB-0007rc-01
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 09:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab0AaIEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 03:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499Ab0AaIEy
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 03:04:54 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:34832 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab0AaIEx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 03:04:53 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 495518C6CE;
	Sun, 31 Jan 2010 10:04:52 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A034664636F; Sun, 31 Jan 2010 10:04:52 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 2B176E51BD;
	Sun, 31 Jan 2010 10:04:50 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20100130230829.GA3544@comppasch2>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138534>

On Sun, Jan 31, 2010 at 12:08:29AM +0100, fkater@googlemail.com wrote:
> Hi,
> 
> I would like to completely migrate from subversion to git
> (and NOT have subversion enabled anymore). However, I need
> to be able to lookup the old subversion revision numbers
> later from the git repository. The default seems to be
> though, that they are replaced by git sha-1 keys.
> 
> It would be completely o.k. here to use git tags for all
> those subversion revision numbers (if possible), so, to
> create a tag for each subversion revision. However, I have
> neither seen any option in git nor found a script which does
> that upon cloning (converting) a subversion repo into a git
> repo.
> 
> Is there a way to do so?

Another way would be to have SVN version numbers in commit
message (--grep option works fine, if those version numbers have 
fixed format). 

The version numbers git-svn outputs are ugly, but filter-branch
can be pretty easily rewrite those into more pretty form,
something like

"This was SVN r123" or "SVN-version: r123".

(adjust to taste)

-Ilari
