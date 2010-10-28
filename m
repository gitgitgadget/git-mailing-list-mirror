From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: fix zsh check under bash with 'set -u'
Date: Thu, 28 Oct 2010 15:51:54 +0200
Message-ID: <20101028135154.GC1877@neumann>
References: <1288228101-23000-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 15:57:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBSyf-0006Lw-D9
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 15:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933425Ab0J1N47 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Oct 2010 09:56:59 -0400
Received: from francis.fzi.de ([141.21.7.5]:55095 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933407Ab0J1N45 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 09:56:57 -0400
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Oct 2010 09:56:57 EDT
Received: from localhost6.localdomain6 ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 28 Oct 2010 15:51:54 +0200
Content-Disposition: inline
In-Reply-To: <1288228101-23000-1-git-send-email-lodatom@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 28 Oct 2010 13:51:54.0833 (UTC) FILETIME=[47EA1410:01CB76A7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160177>

Hi Mark,


On Wed, Oct 27, 2010 at 09:08:21PM -0400, Mark Lodato wrote:
> Commit 06f44c3 (completion: make compatible with zsh) broke bash
> compatibility with 'set -u': a warning was generated when checking
> $ZSH_VERSION.  The solution is to supply a default value, using
> ${ZSH_VERSION-}.  Thanks to SZEDER G=E1bor for the fix.
>=20
> Signed-off-by: Mark Lodato <lodatom@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Thanks.  It works with bash and set -u, so if it works with zsh as
well, then I'm for it.


While you are around, could you please have a look at this thread?

http://thread.gmane.org/gmane.comp.version-control.git/160103/focus=3D1=
60135


Thanks,
G=E1bor
