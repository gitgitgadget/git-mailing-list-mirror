From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Question about removing changes from the index
Date: Fri, 6 Feb 2009 14:14:17 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngoohdp.rak.sitaramc@sitaramc.homelinux.net>
References: <a1e915350902060557m5a67eba0q819c2ba2a0a49c21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 15:16:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVRUq-0008TL-Mc
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbZBFOO3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 09:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753297AbZBFOO3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:14:29 -0500
Received: from main.gmane.org ([80.91.229.2]:55415 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbZBFOO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:14:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LVRTQ-0000pg-3J
	for git@vger.kernel.org; Fri, 06 Feb 2009 14:14:28 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 14:14:28 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 14:14:28 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108713>

On 2009-02-06, Gustav H=E5llberg <gustav@gmail.com> wrote:
> I'm wondering if there's anyone who can recommend a smart way to
> "reset" the index entry for individual files to the contents of HEAD,
> in effect, removing any previous change between HEAD and the index
> (for those files).

err.. 'git reset HEAD -- file'?  The man page says "The
second form with paths is used to revert selected paths in
the index from a given commit, without moving HEAD."
