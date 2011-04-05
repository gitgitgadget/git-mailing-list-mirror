From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Tue, 5 Apr 2011 14:09:40 -0700
Message-ID: <20110405210940.GA19412@dcvr.yhbt.net>
References: <4D9B310A.9020203@mit.edu> <1302034509-8842-1-git-send-email-asedeno@mit.edu> <4D9B7A9E.6040902@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, James Y Knight <jknight@itasoftware.com>,
	Junio C Hamano <gitster@pobox.com>
To: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 05 23:09:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7DVa-0000Gq-Oz
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 23:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593Ab1DEVJm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 17:09:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48451 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739Ab1DEVJl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 17:09:41 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A1601F863;
	Tue,  5 Apr 2011 21:09:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4D9B7A9E.6040902@mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170914>

"\"Alejandro R. Sede=C3=B1o\"" <asedeno@mit.edu> wrote:
> Trying to use an unsupported feature: Source and dest appear not to b=
e in
> the same repository (src: 'http://asedeno/svn/trunk'; dst:
> 'file:///tmp/svn/repo/branches/nb1') at /tmp/git/libexec/git-core/git=
-svn
> line 770

This may be a new warning/error in newer versions of Subversion itself.
Maybe it's better to always use the same URL for all read/writes

--=20
Eric Wong
