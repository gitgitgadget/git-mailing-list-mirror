From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Git archive and trailing "/" in prefix
Date: Fri, 09 Oct 2009 14:49:47 +0200
Message-ID: <4ACF316B.5090807@lsrfire.ath.cx>
References: <loom.20091008T172303-658@post.gmane.org> <7v4oq9j1gs.fsf@alter.siamese.dyndns.org> <4ACE62B1.8070801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 14:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwEzI-0007kQ-Lh
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 14:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758686AbZJIMup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 08:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756398AbZJIMup
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 08:50:45 -0400
Received: from india601.server4you.de ([85.25.151.105]:47353 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422AbZJIMuo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 08:50:44 -0400
Received: from [10.0.1.101] (p57B7CC44.dip.t-dialin.net [87.183.204.68])
	by india601.server4you.de (Postfix) with ESMTPSA id 792832F806A;
	Fri,  9 Oct 2009 14:50:07 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4ACE62B1.8070801@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129798>

Sergio Callegari schrieb:
> I guess the bug in using --prefix on a worktree with subdirs without
> specifying a path is not specific to git archive, then.

The bug should be limited to archive; after my patch all calls to
read_tree_recursive() specify an empty base parameter (except in tree.c=
,
where the function itself lives).

Ren=E9
