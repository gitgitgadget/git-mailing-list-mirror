From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: Git vs svn. Is ... possible ?
Date: Fri, 28 Mar 2008 14:36:25 +0100
Message-ID: <47ECF459.2040500@users.sourceforge.net>
References: <20080328132438.GA32646@blackspire>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Rafa? Mu?y?o <galtgendo@o2.pl>
X-From: git-owner@vger.kernel.org Fri Mar 28 14:45:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfEtx-0005ub-Hq
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 14:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbYC1NpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Mar 2008 09:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbYC1NpG
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 09:45:06 -0400
Received: from dorado.et.put.poznan.pl ([150.254.11.146]:62570 "EHLO
	dorado.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbYC1NpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 09:45:05 -0400
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by dorado.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m2SDe2q8008423;
	Fri, 28 Mar 2008 14:40:03 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.87] (pc1087.et.put.poznan.pl [150.254.11.87])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m2SDaTm29954;
	Fri, 28 Mar 2008 14:36:29 +0100 (MET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080229)
In-Reply-To: <20080328132438.GA32646@blackspire>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.4.1.325704, Antispam-Engine: 2.6.0.325393, Antispam-Data: 2008.3.28.61931
X-PMX-Spam: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_1100_1199 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78409>

Hi Rafa=C5=82,

* Rafa? Mu?y?o [28 III 2008 14:24]:
> Well, the actual question is:
> In svn I can do a remote diff (diff between two remote revisions) wit=
hout
> having to do a checkout, is this possible for git ?

The question makes no sense to me. Git by design is a distributed SCM=20
tool, so there is no such thing like "remote revisions". You can have=20
tracking branches (clones) of some remote repositories, but all the=20
commits on such branches are also stored locally. So you have full=20
access to them, even without a permanent connection to such remote=20
repositories.

And answering to the second part of your question: Yes, you can do "git=
=20
diff" operation between any of the commits in the repository you are=20
working with. No need to checkout before. You can perform "git diff"=20
even on a bare repository without the working three.

Please refer to "man git-diff" for more info.

BR,
/Adam


PS. The encoding you used for your message is not playing well with the=
=20
Polish accented characters in your name ;)

--=20
=2E:.  Adam Piatyszek (ediap)  .:.....................................:=
=2E
=2E:.  ediap@users.sourceforge.net  .:................................:=
=2E
