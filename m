From: "Daniel U. Thibault" <d.u.thibault-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org>
Subject: Errors in man git
Date: Wed, 08 Sep 2010 10:36:53 -0400
Organization: Centre =?ISO-8859-1?Q?d=27=E9tudes_tr=E8s_=E9tranges?=
Message-ID: <BLU0-SMTP666507C6D3E37A50B92431BB720@phx.gbl>
Reply-To: D.U.Thibault-qnhUSoYa74pBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-From: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Wed Sep 08 16:36:54 2010
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glm-linux-man-1dZseelyfdZg9hUCZPvPmw@public.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>)
	id 1OtLle-0004e3-FT
	for glm-linux-man-1dZseelyfdZg9hUCZPvPmw@public.gmane.org; Wed, 08 Sep 2010 16:36:54 +0200
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S1755242Ab0IHOgx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glm-linux-man@m.gmane.org>); Wed, 8 Sep 2010 10:36:53 -0400
Received: from blu0-omc4-s4.blu0.hotmail.com ([65.55.111.143]:1157 "EHLO
	blu0-omc4-s4.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752552Ab0IHOgw (ORCPT
	<rfc822;linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>); Wed, 8 Sep 2010 10:36:52 -0400
Received: from BLU0-SMTP66 ([65.55.111.135]) by blu0-omc4-s4.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 8 Sep 2010 07:36:52 -0700
X-Originating-IP: [70.50.3.194]
X-Originating-Email: [d.u.thibault-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org]
Received: from [192.168.2.18] ([70.50.3.194]) by BLU0-SMTP66.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 8 Sep 2010 07:36:51 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; fr; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
X-OriginalArrivalTime: 08 Sep 2010 14:36:51.0739 (UTC) FILETIME=[46BDC6B0:01CB4F63]
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
List-ID: <linux-man.vger.kernel.org>
X-Mailing-List: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155788>


     There are no indications in the "man git" pages as to how to repor=
t=20
errors, so I'm following the instructions I googled at=20
http://www.kernel.org/doc/man-pages/reporting_bugs.html (adding=20
git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org to the mailing list as it seems appropriate).

    The "man git" pages give the syntax (SYNOPSIS) as:

##########
git [--version] [--exec-path[=3DGIT_EXEC_PATH]] [--html-path]
            [-p|--paginate|--no-pager] [--no-replace-objects]
            [--bare] [--git-dir=3DGIT_DIR] [--work-tree=3DGIT_WORK_TREE=
]
            [--help] COMMAND [ARGS]
##########

    Hence "git COMMAND" should work once the appropriate value is=20
substituted for COMMAND.  The COMMANDs are later documented (GIT=20
COMMANDS) as long lists of "porcelain" and "plumbing" COMMANDs. =20
However, *none* of the COMMANDs given actually work.  For instance, one=
=20
(porcelain) COMMAND is "git-gui" but typing "git git-gui" in a command=20
shell results in the message:

##########
git: 'git-gui' is not a git command. See 'git --help'.
##########

    The actual COMMAND (documented under "man git-gui") is "gui".

    Now, if the intent of the COMMAND lists is to send the user off to=20
the other man-pages, that is fine but ought to be clearly indicated by =
a=20
preamble of some sort.  Maybe the man pages should read something like:

##########
GIT COMMANDS
        We divide git into high level ("porcelain") commands and low le=
vel
        ("plumbing") commands.

        The actual COMMAND strings are documented under the individual
        man pages listed in what follows.  For instance, the COMMAND fo=
r
        "adding file contents to the index" is given by the git-add man=
=20
pages.
##########

Daniel U. Thibault
a.k.a. Urhixidur
a.k.a. Seigneur Boh=E9mond de Nic=E9e
URL: <http://www.bigfoot.com/~D.U.Thibault>
--
To unsubscribe from this list: send the line "unsubscribe linux-man" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
