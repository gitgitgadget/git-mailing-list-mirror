From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 20/40] Windows: A rudimentary poll() emulation.
Date: Sat, 1 Mar 2008 20:24:23 +0100
Message-ID: <200803012024.23286.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <200802282149.36748.johannes.sixt@telecom.at> <200803011648.38296.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 20:25:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVXKW-0008OB-R9
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 20:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbYCATY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 14:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbYCATY0
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 14:24:26 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:46104 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbYCATY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 14:24:26 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id E37C513A33C;
	Sat,  1 Mar 2008 20:24:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A59FD609C0;
	Sat,  1 Mar 2008 20:24:23 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <200803011648.38296.robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75691>

On Saturday 01 March 2008 16:48, Robin Rosenberg wrote:
> Den Thursday 28 February 2008 21.49.36 skrev Johannes Sixt:
> > On Thursday 28 February 2008 10:36, Paolo Bonzini wrote:
> > > For the future, would it be better to first use WaitForMultipleObjects,
> > > and then use PeekNamedPipe to find which handles have data on it?
> > > That's how the mingw port of GNU Smalltalk does it.
> >
> > I tried but I failed. If you can show me code where
> > WaitForMultipleObjects works on handles that MSVCRT.DLL's open() created,
> > I'll gladly accept it!
>
> Have you checked _get_osfhandle? There's a warning though in the
> knowledgebase with number 99173, though. There's also another function that
> works the other way, _open_osfhandle.

Handwaving you are! This stuff is well-known. Show me code.

-- Hannes
