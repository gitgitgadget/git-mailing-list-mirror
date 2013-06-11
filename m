From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: New feature discussion: git rebase --status
Date: Tue, 11 Jun 2013 14:35:29 +0200
Message-ID: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	<Matthieu.Moy@grenoble-inp.fr>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 11 14:35:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmNnT-000705-Ho
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 14:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252Ab3FKMfb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 08:35:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33224 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108Ab3FKMfb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 08:35:31 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5BCZSfb006836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Jun 2013 14:35:28 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5BCZT1S014510;
	Tue, 11 Jun 2013 14:35:29 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5BCZTSh026593;
	Tue, 11 Jun 2013 14:35:29 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5BCZT2o026592;
	Tue, 11 Jun 2013 14:35:29 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 11 Jun 2013 14:35:28 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227432>

(Got the idea from:
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#git_rebase_--s=
tatus)

When in the middle of a rebase, users can be easily confused about
what to do, or where they are in the rebase process.

All the information is available in .git/rebase-merge/, but I believe
it would be helpful to have a command (for example 'git rebase
--status') which would explicitely indicate the state of the process.

=46or instance, the output could look like:

$ git rebase --status
Rebasing my_last_commit onto base_commit
Already applied 2 patches:
	b170635... my_commit_message
	b170635... my_commit_message
Currently applying b170635... my_commit_message
2 patches left to apply:
	b170635... my_commit_message
	b170635... my_commit_message


Another nice thing could be to improve the output of 'git status' by
saying the number of patches left to apply.
As an example, it could say:
	You are currently rebasing (patch 3/5).

What do you think?
Does the name rebase --status seem appropriate?
Should the output be providing more/less information?

Thanks =3D]
--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02
