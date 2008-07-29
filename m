From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: SSL + mod_dav + Git
Date: Tue, 29 Jul 2008 13:32:44 -0400
Message-ID: <BLU0-SMTP26525E587622EEECC5C06CAE820@phx.gbl>
References: <a7b96a640807290453l582c3f11w6a0f0c841063f07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Chris Hart" <chris@christopherhart.ca>
X-From: git-owner@vger.kernel.org Tue Jul 29 19:36:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNt6N-0004z5-7V
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 19:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbYG2ReK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 13:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752608AbYG2ReJ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 13:34:09 -0400
Received: from blu0-omc3-s5.blu0.hotmail.com ([65.55.116.80]:15928 "EHLO
	blu0-omc3-s5.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752495AbYG2ReI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 13:34:08 -0400
Received: from BLU0-SMTP26 ([65.55.116.73]) by blu0-omc3-s5.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 29 Jul 2008 10:34:06 -0700
X-Originating-IP: [74.14.67.222]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.14.67.222]) by BLU0-SMTP26.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 29 Jul 2008 10:34:05 -0700
Received: from bud.attic.local ([10.10.10.20])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1KNu0x-0004Sb-8y; Tue, 29 Jul 2008 14:33:39 -0400
In-Reply-To: <a7b96a640807290453l582c3f11w6a0f0c841063f07@mail.gmail.com>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; x86_64-pc-linux-gnu)
X-OriginalArrivalTime: 29 Jul 2008 17:34:05.0803 (UTC) FILETIME=[4CA5EBB0:01C8F1A1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90660>

On Tue, 29 Jul 2008 07:53:08 -0400
"Chris Hart" <chris@christopherhart.ca> wrote:

> However, once authenticated to the .git folder (cadaver through
> https), basic commands give strange errors or 404s. Ls throws "Listing
> collection `/.git/': failed:
> Could not read status line: Secure connection truncated" and cd
> /to/some/legitimate/directory throws "Could not access /.git/dir/ (not
> WebDAV-enabled?):
> 404 Not Found." Oddly tab-completion for cd suggests the contents of
> the directory (although I'm cadaver-ing from localhost). Same results
> remotely in a browser: authenticates successfully and gives 404s.

Hi Chris,

Unfortunately this won't be overly helpful, but what you're describing
is not a problem with Git.  There appears to be some problem with
your Apache setup.  If nobody on the list here offers a solution, you might
want to try the apache mailing list or #apache.

Sean
