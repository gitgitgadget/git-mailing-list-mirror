From: rajesh boyapati <boyapatisrajesh@gmail.com>
Subject: Fwd: Git-web error
Date: Fri, 27 Jan 2012 10:15:01 -0800 (PST)
Message-ID: <61c866a5-31a0-4994-ae29-2086f18e707b@o9g2000yqa.googlegroups.com>
References: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 19:24:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqqT2-0001oj-0K
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 19:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357Ab2A0SYD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 13:24:03 -0500
Received: from mail-gx0-f184.google.com ([209.85.161.184]:52115 "EHLO
	mail-gx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab2A0SYB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 13:24:01 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jan 2012 13:24:01 EST
Received: by ggnk3 with SMTP id k3so441445ggn.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 10:24:00 -0800 (PST)
Received: by 10.236.123.12 with SMTP id u12mr713749yhh.19.1327688101305; Fri,
 27 Jan 2012 10:15:01 -0800 (PST)
Received: by o9g2000yqa.googlegroups.com with HTTP; Fri, 27 Jan 2012 10:15:01
 -0800 (PST)
In-Reply-To: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com>
User-Agent: G2/1.0
X-Google-Web-Client: true
X-Google-Header-Order: HUALESRCNKF
X-HTTP-UserAgent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1,gzip(gfe)
X-Google-IP: 192.94.92.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189228>




---------- Forwarded message ----------
=46rom: rajesh boyapati <boyapatisraj...@gmail.com>
Date: Jan 25, 7:10=A0pm
Subject: Git-web error
To: Repo and Gerrit Discussion


Hi,

We integrated git-web to our gerrit Code-review.
I installed gitweb using the command:
$ sudo apt-get install gitweb
Then I configured gitweb to our gerrit using the command:
$ git config --file $SITE_PATH/etc/gerrit.config gitweb.cgi /usr/lib/
cgi-bin/gitweb.cgi
Now the gitweb is added to gerrit.config and in gerrit config file, it
looks like
[gitweb]
=A0 =A0 =A0 =A0 cgi =3D /usr/lib/cgi-bin/gitweb.cgi
Then, restarted gerrit server.

When I go to one of the projects in gerrit through gitweb and when I
click "summary", I am getting the below error.
If I click other tabs(log, shortlog, commit, tree,etc) after clicking
"summary", I am getting following error in error-log.
If I click other tabs(log, shortlog, commit, tree,etc) before clicking
"summary", everything works fine.

Error:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2012-01-25 18:50:32,334] ERROR
com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: [Wed Jan 25
18:50:32 2012] gitweb.cgi: Use of uninitialized value $head in string
eq at /usr/lib/cgi-bin/gitweb.cgi line 4720.
[2012-01-25 18:50:35,658] ERROR
com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: [Wed Jan 25
18:50:35 2012] gitweb.cgi: Use of uninitialized value $commit_id in
open at /usr/lib/cgi-bin/gitweb.cgi line 2817.
[2012-01-25 18:50:35,660] ERROR
com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad
revision ''
[2012-01-25 18:50:39,209] ERROR
com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: [Wed Jan 25
18:50:39 2012] gitweb.cgi: Use of uninitialized value $commit_id in
open at /usr/lib/cgi-bin/gitweb.cgi line 2817.
[2012-01-25 18:50:39,210] ERROR
com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad
revision ''
[2012-01-25 18:50:40,656] ERROR
com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad
revision 'HEAD'
[2012-01-25 18:53:17,097] ERROR
com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad
revision 'HEAD'
[2012-01-25 18:53:17,113] ERROR
com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: [Wed Jan 25
18:53:17 2012] gitweb.cgi: Use of uninitialized value $head in string
eq at /usr/lib/cgi-bin/gitweb.cgi line 4720.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Can any one help me on how to resolve this issue?.

Thanks,
Rajesh.
