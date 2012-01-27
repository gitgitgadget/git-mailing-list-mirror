From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fwd: Gitweb error
Date: Fri, 27 Jan 2012 13:39:58 -0800 (PST)
Message-ID: <m362fwesdw.fsf_-_@localhost.localdomain>
References: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com>
	<61c866a5-31a0-4994-ae29-2086f18e707b@o9g2000yqa.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: rajesh boyapati <boyapatisrajesh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 22:40:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqtWk-0004vG-S0
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 22:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321Ab2A0VkE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 16:40:04 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49578 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756312Ab2A0Vj7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 16:39:59 -0500
Received: by eekc14 with SMTP id c14so709954eek.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 13:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=QK1X9VI19+LwZherrgSPomtxoQIbP88hrUTIrs411yA=;
        b=hnoIVg2++KPfTTCPOEYlm6qppUMZc6dogGuBm/IpXeWglqGy2+XjIfpjIM7t9xp6LW
         QQB7RBd9Pn9lGDZaexkNB2wJwTWNYF0QmLH5w5k29X87eAhUhQcAHZMigrFZwOrKo7Vb
         W5qBeV+DbqsDBUps1Dzcrhg9E3GA3gwpVTQPw=
Received: by 10.14.33.218 with SMTP id q66mr369808eea.67.1327700398480;
        Fri, 27 Jan 2012 13:39:58 -0800 (PST)
Received: from localhost.localdomain (abvs200.neoplus.adsl.tpnet.pl. [83.8.216.200])
        by mx.google.com with ESMTPS id r2sm34522259eef.7.2012.01.27.13.39.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jan 2012 13:39:58 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q0RLeS2w029555;
	Fri, 27 Jan 2012 22:40:29 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q0RLeRVf029552;
	Fri, 27 Jan 2012 22:40:27 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <61c866a5-31a0-4994-ae29-2086f18e707b@o9g2000yqa.googlegroups.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189236>

rajesh boyapati <boyapatisrajesh@gmail.com> writes:

> We integrated git-web to our gerrit Code-review.
> I installed gitweb using the command:
> $ sudo apt-get install gitweb
> Then I configured gitweb to our gerrit using the command:
> $ git config --file $SITE_PATH/etc/gerrit.config gitweb.cgi /usr/lib/
> cgi-bin/gitweb.cgi
> Now the gitweb is added to gerrit.config and in gerrit config file, i=
t
> looks like
> [gitweb]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 cgi =3D /usr/lib/cgi-bin/gitweb.cgi
> Then, restarted gerrit server.

This combination of gitweb (which version?) and Gerrit can be hard to
debug, unfortunately.
=20
> When I go to one of the projects in gerrit through gitweb and when I
> click "summary", I am getting the below error.
> If I click other tabs(log, shortlog, commit, tree,etc) after clicking
> "summary", I am getting following error in error-log.
> If I click other tabs(log, shortlog, commit, tree,etc) before clickin=
g
> "summary", everything works fine.
>=20
> Error:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [2012-01-25 18:50:32,334] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: [Wed Jan 25
> 18:50:32 2012] gitweb.cgi: Use of uninitialized value $head in string
> eq at /usr/lib/cgi-bin/gitweb.cgi line 4720.

Could you show this line and about 3 lines of context in your
gitweb.cgi?

> [2012-01-25 18:50:35,658] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: [Wed Jan 25
> 18:50:35 2012] gitweb.cgi: Use of uninitialized value $commit_id in
> open at /usr/lib/cgi-bin/gitweb.cgi line 2817.

Same here.

> [2012-01-25 18:50:35,660] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad
> revision ''

It looks like gitweb incorrectly gets empty revision
parameter... strange.


--=20
Jakub Narebski
