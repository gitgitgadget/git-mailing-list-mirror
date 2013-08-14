From: XinLingchao <douglarek@outlook.com>
Subject: About *git clone --depth=n* puzzle
Date: Wed, 14 Aug 2013 16:20:33 +0800
Message-ID: <BAY169-W472B90AB796C71E8D0D038B4450@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "junchunx.guan@gmail.com" <junchunx.guan@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 14 10:26:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9WPp-0004Yo-0i
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 10:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759465Ab3HNI0o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Aug 2013 04:26:44 -0400
Received: from bay0-omc3-s17.bay0.hotmail.com ([65.54.190.155]:25343 "EHLO
	bay0-omc3-s17.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756769Ab3HNI0m convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 04:26:42 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2013 04:26:42 EDT
Received: from BAY169-W47 ([65.54.190.189]) by bay0-omc3-s17.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 14 Aug 2013 01:20:33 -0700
X-TMN: [6eAfLLQRP2imc/6ec29y+/gUvil+ossV]
X-Originating-Email: [douglarek@outlook.com]
Importance: Normal
X-OriginalArrivalTime: 14 Aug 2013 08:20:33.0887 (UTC) FILETIME=[25B536F0:01CE98C7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232271>

Hi Guys,

I think I have got some trouble when I use `git clone --depth=3Dn` comm=
and. Take a real repo for example:


`git clone https://github.com/douglarek/vimrc.git --depth=3D1`


then I use `git log`:
=A0=20
```=A0=20
=A0=A0=A0 commit d04ca09ecc723739123fae11ad56784eb0c9b36a
=A0=A0=A0 Author: Lingchao Xin <douglarek@outlook.com>
=A0=A0=A0 Date:=A0=A0 Fri Jun 7 09:39:22 2013 +0800

=A0=A0=A0=A0=A0=A0=A0 Update vnudle to master branch, add wm shortcut, =
pylint optimization

=A0=A0=A0 commit c66d827dc212f6ae8aab6b5c44631564bcbe2acd
=A0=A0=A0 Author: icocoa <lingchax@outlook.com>
=A0=A0=A0 Date:=A0=A0 Tue Mar 12 01:36:34 2013 -0700

=A0=A0=A0=A0=A0=A0=A0 Merge pull request #1 from douglarek/master

=A0=A0=A0=A0=A0=A0=A0 Add markdown, flake8, pylint plugin

```
=A0=A0=A0 but when I clone it with `file://`:

=A0=A0=A0 git clone https://github.com/douglarek/vimrc.git
=A0=A0=A0 git clone file://vimrc.git --depth=3D1 vimrc1

=A0=A0=A0 I got this log:
```
=A0=A0=A0 commit d04ca09ecc723739123fae11ad56784eb0c9b36a
Author: Lingchao Xin <douglarek@outlook.com>
Date:=A0=A0 Fri Jun 7 09:39:22 2013 +0800

=A0=A0=A0 Update vnudle to master branch, add wm shortcut, pylint optim=
ization
```

so the two results are not same, is it a bug? or it should be so?

My os is openSUSE 12.3 and git version 1.8.3.4; and myabe it occured in=
 git 1.8.1.4 +.


Thanks and Best regards

Lingchao Xin 		 	   		  