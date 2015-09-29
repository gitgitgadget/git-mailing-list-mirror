From: Christophe COEVOET <stof@notk.org>
Subject: Gitk cannot start in the latest version when using --all
Date: Tue, 29 Sep 2015 15:40:55 +0200
Message-ID: <560A94E7.9090506@notk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 15:48:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgvGA-0006XU-O8
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 15:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756399AbbI2Nry convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Sep 2015 09:47:54 -0400
Received: from nautica.notk.org ([91.121.71.147]:40969 "EHLO nautica.notk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756373AbbI2Nru (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 09:47:50 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2015 09:47:50 EDT
Received: from [192.168.1.4] (jav75-3-78-192-133-84.fbxo.proxad.net [78.192.133.84])
	by nautica.notk.org (Postfix) with ESMTPSA id 43681C009
	for <git@vger.kernel.org>; Tue, 29 Sep 2015 15:40:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278820>

Hi,

I'm installing git and gitk from the Ubuntu PPA maintained by the Git=20
team. I received the Git 2.6 update today.
Since this update, I'm unable to launch gitk with --all. I'm receiving=20
the following error message:

Error in startup script: bad menu entry index "=C3=89diter la vue..."
     while executing
".bar.view entryconf [mca "Edit view..."] -state normal"
     invoked from within
"if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {=
}} {
     # create a view for the files/dirs specified on the command line
     se..."
     (file "/usr/bin/gitk" line 12442)

Launching gitk without the --all option works fine.
Launching gitk with the --branches option or the --tags option is also=20
broken

--=20
Christophe Coevoet
