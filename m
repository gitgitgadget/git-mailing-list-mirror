From: cho <tobutaz@gmail.com>
Subject: Re: [BUG] git-svn not following svn moves
Date: Fri, 19 Oct 2007 08:30:51 +0000 (UTC)
Message-ID: <pan.2007.10.19.08.30.47@gmail.com>
References: <ff7fhg$2eu$1@ger.gmane.org>
	<20071018121328.GA5358@xp.machine.xx> <ff7m2j$2eu$2@ger.gmane.org>
	<4717D85C.9050805@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 10:32:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IinH4-0000tc-9T
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 10:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758657AbXJSIbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Oct 2007 04:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756823AbXJSIbJ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 04:31:09 -0400
Received: from main.gmane.org ([80.91.229.2]:39341 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756693AbXJSIbH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 04:31:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IinG2-0002HV-DR
	for git@vger.kernel.org; Fri, 19 Oct 2007 08:31:02 +0000
Received: from dhcp26-237.enst.fr ([137.194.26.237])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 08:31:02 +0000
Received: from tobutaz by dhcp26-237.enst.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 08:31:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp26-237.enst.fr
User-Agent: Pan/0.129 (Benson & Hedges Moscow Gold)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61674>

Le Fri, 19 Oct 2007 11:04:12 +1300, Sam Vilain a =C3=A9crit=C2=A0:

> cho wrote:
>> svn ci -m 'Add README.'
# forgot this
svn up

>> So the testcase basically involves moving the trunk. git-svn gets ve=
ry
>> confused and keeps a mixture of the old and new trunk.
>=20
> Were you using --follow-parent or not?

It's the same, with --follow-parent and with --no-follow-parent .
