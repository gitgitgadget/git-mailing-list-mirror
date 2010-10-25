From: =?koi8-r?Q?=E1=CC=C5=CB=D3=C5=CA_=E5=C7=CF=D2=CF=D7?= 
	<alekseyandni@mail.ru>
Subject: =?koi8-r?Q?Re[2]=3A_git_via_http_problem?=
Date: Mon, 25 Oct 2010 17:12:43 +0400
Message-ID: <E1PAMqx-0004No-00.alekseyandni-mail-ru@f241.mail.ru>
References: <loom.20101025T123323-510@post.gmane.org> <AANLkTiJ=geegYAXnHmNONw8UeocePTw2EMw4frMbQZA@mail.gmail.com>
Reply-To: =?koi8-r?Q?=E1=CC=C5=CB=D3=C5=CA_=E5=C7=CF=D2=CF=D7?= 
	  <alekseyandni@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 15:12:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAMr8-0007sk-Cx
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 15:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426Ab0JYNMr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Oct 2010 09:12:47 -0400
Received: from f241.mail.ru ([217.69.128.169]:46965 "EHLO f241.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab0JYNMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 09:12:47 -0400
X-Greylist: delayed 10178 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Oct 2010 09:12:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Message-Id:Content-Transfer-Encoding:Content-Type:Reply-To:In-Reply-To:References:Date:Mime-Version:Subject:Cc:To:From; bh=NZltPJkWOr6d9k6ujzBzQ345UqcE5RqELrEtb8Ib8l8=;
	b=QI/IQgXf2AAtOwgtRW/dtWYqR92Z2nyS8ZrK2gJBC270nqTiIUCnfH4OO04fY/eGsFOfFdkUTkhgjj6CRhB4Eh6GzVclbWOzgl4GQMRE/BijaFyOyyeyeyMVzOtoDXdU;
Received: from mail by f241.mail.ru with local 
	id 1PAMqx-0004No-00; Mon, 25 Oct 2010 17:12:43 +0400
Received: from [77.241.246.226] by win.mail.ru with HTTP;
	Mon, 25 Oct 2010 17:12:43 +0400
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [77.241.246.226]
In-Reply-To: <AANLkTiJ=geegYAXnHmNONw8UeocePTw2EMw4frMbQZA@mail.gmail.com>
X-Spam: Not detected
X-Mras: Ok
X-MR-Warn: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159949>


I'm using git-core 1:1.5.6.5-3+lenny3.2
I can see list of files using cadaver:=20
cadaver http://test@localhost/linter.git
Authentication required for localhost on server `localhost':
Username: test
Password:=20
dav:/linter.git/> ls
Listing collection `/linter.git/': succeeded.
Coll:   branches                               0  =EF=CB=D4 25 12:45
Coll:   hooks                                  0  =EF=CB=D4 25 12:45
Coll:   info                                   0  =EF=CB=D4 25 12:45
Coll:   objects                                0  =EF=CB=D4 25 12:45
Coll:   refs                                   0  =EF=CB=D4 25 12:45
        HEAD                                  23  =EF=CB=D4 25 12:45
        config                                66  =EF=CB=D4 25 12:45
        description                           58  =EF=CB=D4 25 12:45
dav:/linter.git/> quit
Connection to `localhost' closed.

In /etc/apache2/mods-enabled   I see @authn_file.load  with the text
 LoadModule authn_file_module /usr/lib/apache2/modules/mod_authn_file.s=
o


Mon, 25 Oct 2010 20:39:44 +0800 =D0=C9=D3=D8=CD=CF =CF=D4 Tay Ray Chuan=
 <rctay89@gmail.com>:

> Hi,
> On Mon, Oct 25, 2010 at 6:34 PM, Aleksey Egorov <alekseyandni@mail.ru=
> wrote:
> > If I change apache conf to
> > ? ? ?Alias /linter.git /var/www/linter.git
> > <Location /linter.git>
> > DAV On
> > AuthType Basic
> > Authname "localhost"
> > </Location>
> I noticed that you left out AuthUserFile here.
> Could it be that you didn't load mod_authn_file? (wild guess)
> Also, what version of git are you running? I'm guessing it's an
> authentication problem.
> --=20
> Cheers,
> Ray Chuan
