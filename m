From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Teach git-merge to pass -X<option> to the backend strategy module
Date: Sun, 29 Jun 2008 12:32:36 +0200
Organization: At home
Message-ID: <g47oc3$q1l$1@ger.gmane.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7v8x0992hy.fsf@gitster.siamese.dyndns.org> <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org> <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.
 org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vwsk8d3q5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 29 12:34:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCuEc-0000mg-43
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 12:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbYF2Kcp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 06:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbYF2Kcp
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 06:32:45 -0400
Received: from main.gmane.org ([80.91.229.2]:39573 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966AbYF2Kcp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 06:32:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KCuD5-00070k-O0
	for git@vger.kernel.org; Sun, 29 Jun 2008 10:32:43 +0000
Received: from abvq210.neoplus.adsl.tpnet.pl ([83.8.214.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 10:32:43 +0000
Received: from jnareb by abvq210.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 10:32:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvq210.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86792>

Junio C Hamano wrote:

> diff --git a/git-merge.sh b/git-merge.sh
> index 39b5cd9..d475852 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -17,6 +17,7 @@ commit =A0 =A0 =A0 =A0 =A0 =A0 =A0 perform a commit=
 if the merge succeeds (default)
> =A0ff =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 allow fast forward (default=
)
> =A0s,strategy=3D =A0 =A0 =A0 =A0 =A0merge strategy to use
> =A0m,message=3D =A0 =A0 =A0 =A0 =A0 message to be used for the merge =
commit (if any)
> +X=3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pass merge strategy specifi=
c options
> =A0"

You have updated usage for git-merge, but didn't update manpages
(Documentation).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
