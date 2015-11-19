From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Local git repository url
Date: Thu, 19 Nov 2015 14:06:45 +0300
Message-ID: <20151119140645.7f6c856efc66bd88160fd0c1@domain007.com>
References: <7EF33D3D8E1EA14DB720C3BF1B7A24A80F36F32D@PLYEXM02.customer.edfenergy.net>
	<7EF33D3D8E1EA14DB720C3BF1B7A24A80F36F357@PLYEXM02.customer.edfenergy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>
To: "Vambara, JayaPrakash (Infosys)" <JayaPrakash.Vambara@edfenergy.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 12:06:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzN3I-0003jw-Jw
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 12:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758167AbbKSLGw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Nov 2015 06:06:52 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:36449 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbbKSLGv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 06:06:51 -0500
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id tAJB6jat021423;
	Thu, 19 Nov 2015 14:06:46 +0300
In-Reply-To: <7EF33D3D8E1EA14DB720C3BF1B7A24A80F36F357@PLYEXM02.customer.edfenergy.net>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281474>

On Thu, 19 Nov 2015 10:48:51 +0000
"Vambara, JayaPrakash (Infosys)" <JayaPrakash.Vambara@edfenergy.com>
wrote:

> I am trying to setup a local git repository and manage it from local
> Jenkins set-up. So, both Jenkins and git are on my local desktop.
>=20
> However, I am trying to give the Repository URL but with no luck.
>=20
> My repository is in D drive in location D:\Git-Try
>=20
> I tried to configure this Repository URL as ---=C2=A0file:///d/Git-Tr=
y
> =C2=A0also file:///D:\Git-Try , but was not successful.
>=20
> Can you please let me know what should be the Repository URL.
>=20
> I have created the db in above location, pushed few files and
> commited them as well.

Try D:/Git-test first.

Otherwise it might heavily depend on how Jenkins interprets those URLs
and whether it even uses stock Git to access the repository (and not
something else like JGit).

To first rule out an issue with Jenkins you might just try cloning that
Git repo (local to local -- Git is fine with it).  Once you figure out
an URL which works for native Git (I assume you're talking about Git
for Windows), you can try to stick it to Jenkins and see it it works.
