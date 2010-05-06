From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: merges and git log --stat
Date: Thu, 6 May 2010 22:36:39 +0200
Message-ID: <20100506203639.GV4599@neumann>
References: <20100506192616.GS4599@neumann>
	<7vsk64hjq4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 06 22:37:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA7oy-0007k3-50
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 22:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406Ab0EFUhR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 16:37:17 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:65315 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782Ab0EFUhP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 16:37:15 -0400
Received: from [127.0.1.1] (p5B130578.dip0.t-ipconnect.de [91.19.5.120])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0M6RTj-1NPJyd1yWp-00y2A0; Thu, 06 May 2010 22:36:41 +0200
Content-Disposition: inline
In-Reply-To: <7vsk64hjq4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1/1APcIv5RgZieyYqIYNFyEgIvTSeZNfL2VT4x
 hOBs6oI1b+2BbX2IP5RWjw3+8fW51dWOQEwdqttF7nZY6gHq+Y
 uIzVSYm8WIFBUASIT0nig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146495>

That was fast, thank you.

On Thu, May 06, 2010 at 01:13:23PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > I've just noticed that 'git log --stat' does not print the diffstat
> > for merge commits.  Is this intentional?
>=20
> It's very much designed so.  You cannot clearly define "diff from whi=
ch
> parent you would want to see".

I see.  Perhaps it would make sense to show the diffstat from the
point of view of the first parent, but maybe I'm biased by my current
use case.  Anyway, it seems that I can easily get what I need with a
bit of scripting, so it's not a major issue.

Best,
G=E1bor
