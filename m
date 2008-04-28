From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: git doesn't finds the parent of a commit
Date: Mon, 28 Apr 2008 14:14:34 +0000 (UTC)
Message-ID: <slrng1bmua.25r.joerg@alea.gnuu.de>
References: <slrng019fg.nd8.joerg@alea.gnuu.de>
 <20080413094131.GA9437@xp.machine.xx> <slrng0v8h8.ujv.joerg@alea.gnuu.de>
 <200804240801.13674.chriscool@tuxfamily.org>
 <20080424060857.GX29771@spearce.org> <20080427104704.GA11784@alea.gnuu.de>
 <20080427173731.GA9523@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 18:48:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqWW9-0001PC-UN
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 18:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936102AbYD1QrH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 12:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936061AbYD1QrG
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 12:47:06 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1424 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935979AbYD1QrB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 12:47:01 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id B6B81488067; Mon, 28 Apr 2008 18:46:59 +0200 (CEST)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>)
	id 1JqU7m-0004GM-L9
	for git@vger.kernel.org; Mon, 28 Apr 2008 16:14:34 +0200
Path: not-for-mail
Newsgroups: local.mailinglist.git
X-Trace: alea.gnuu.de 1209392074 16388 192.168.0.5 (28 Apr 2008 14:14:34 GMT)
X-Complaints-To: usenet@alea.gnuu.de
User-Agent: slrn/pre0.9.9-102 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80561>

Hallo,

"Stephen R. van den Berg" <srb@cuci.nl> wrote:
> J?rg Sommer wrote:
>>% git rev-parse b63e99500137c913bd801a2f22b6cf88c63b95c5~1
>>b63e99500137c913bd801a2f22b6cf88c63b95c5~1
>>fatal: ambiguous argument 'b63e99500137c913bd801a2f22b6cf88c63b95c5~1=
': unknown revision or path not in the working tree.
>>Use '--' to separate paths from revisions
>
>>Can someone tell me what I'm doing wrong?
>
> I've had similar symptoms when I had circular references in the
> repository.

No, this was not my problem. But I found the reason with bisect:
=2Egit/shallow. I've started with a shallow clone, but forgot it. Is it
possible that git warns about this or ignores the shallow entry if the
parent of the commit is available?

Bye, J=C3=B6rg.
--=20
Dein Gesicht wird dir geschenkt. L=C3=A4cheln musst du selber! (Inga He=
rmann)
