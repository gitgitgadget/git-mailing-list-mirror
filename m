From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Gitk cannot start in the latest version when using --all
Date: Tue, 29 Sep 2015 16:49:51 +0300
Message-ID: <20150929164951.cd5dea4ab0e866e4a0b74d6f@domain007.com>
References: <560A94E7.9090506@notk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Christophe COEVOET <stof@notk.org>
X-From: git-owner@vger.kernel.org Tue Sep 29 15:50:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgvIF-00007P-MF
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 15:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbbI2NuB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Sep 2015 09:50:01 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:59809 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965245AbbI2Nt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 09:49:57 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t8TDnpxA005443;
	Tue, 29 Sep 2015 16:49:52 +0300
In-Reply-To: <560A94E7.9090506@notk.org>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278821>

On Tue, 29 Sep 2015 15:40:55 +0200
Christophe COEVOET <stof@notk.org> wrote:

> I'm installing git and gitk from the Ubuntu PPA maintained by the Git=
=20
> team. I received the Git 2.6 update today.
> Since this update, I'm unable to launch gitk with --all. I'm
> receiving the following error message:
>=20
> Error in startup script: bad menu entry index "=C3=89diter la vue..."
>      while executing
> ".bar.view entryconf [mca "Edit view..."] -state normal"
>      invoked from within
> "if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne
> {}} {
>      # create a view for the files/dirs specified on the command line
>      se..."
>      (file "/usr/bin/gitk" line 12442)
>=20
> Launching gitk without the --all option works fine.
> Launching gitk with the --branches option or the --tags option is
> also broken

Does it start if you run it via

$ LANG=3DC gitk --all

or

$ LANG=3Den_US.UTF-8 gitk --all

?
