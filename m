From: =?koi8-r?Q?=E1=CC=C5=CB=D3=C5=CA_=E5=C7=CF=D2=CF=D7?= 
	<alekseyandni@mail.ru>
Subject: =?koi8-r?Q?Re[4]=3A_git_via_http_problem?=
Date: Tue, 26 Oct 2010 11:40:14 +0400
Message-ID: <E1PAe8k-0007Gf-00.alekseyandni-mail-ru@f165.mail.ru>
References: <E1PAMqx-0004No-00.alekseyandni-mail-ru@f241.mail.ru> <loom.20101025T123323-510@post.gmane.org> <AANLkTin95znfHbPwCs25-2CFdf6upQpkgR1+uM+Sp9u@mail.gmail.com>
Reply-To: =?koi8-r?Q?=E1=CC=C5=CB=D3=C5=CA_=E5=C7=CF=D2=CF=D7?= 
	  <alekseyandni@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 26 09:41:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAe9V-0006TG-Ev
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 09:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab0JZHky convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Oct 2010 03:40:54 -0400
Received: from f165.mail.ru ([217.69.128.117]:41736 "EHLO f165.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007Ab0JZHkx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 03:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Message-Id:Content-Transfer-Encoding:Content-Type:Reply-To:In-Reply-To:References:Date:Mime-Version:Subject:Cc:To:From; bh=H2gWTFf0OjADwIe6qCs+99nIsbNDtgyF9ZPtOtheQq4=;
	b=T0ARwVsoYuiH/fIpTGyMAXeQNlZjez1i9jlxOOpxt8Sr3Qeya1nEiV+vfQdtBJS2hV1iu+GxUVXxOEad9PU2k3iwIhh2SY+P1+bLxcXbJWDDtwEfrqPCmJNilW80bJ6D;
Received: from mail by f165.mail.ru with local 
	id 1PAe8k-0007Gf-00; Tue, 26 Oct 2010 11:40:14 +0400
Received: from [77.241.246.226] by win.mail.ru with HTTP;
	Tue, 26 Oct 2010 11:40:14 +0400
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [77.241.246.226]
In-Reply-To: <AANLkTin95znfHbPwCs25-2CFdf6upQpkgR1+uM+Sp9u@mail.gmail.com>
X-Spam: Not detected
X-Mras: Ok
X-MR-Warn: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159983>


I installed git-core git/1.7.1 from Squeeze branch compilled for lenny.
Now when i type  git push upload master

it request password twice (I entered right password test and test)
Password:=20
Password:=20

and then shows:
=46etching remote heads...
  refs/
  refs/heads/
  refs/tags/
updating 'refs/heads/master'
  from 0000000000000000000000000000000000000000
  to   aa36be4c3e46e619f73faa0cea071688cb380d25
    sending 183322 objects
LOCK HTTP error 412
Unable to refresh lock for http://test@localhost/linter.git/info/refs
LOCK HTTP error 412
Unable to refresh lock for http://test@localhost/linter.git/info/refs
LOCK HTTP error 412
Unable to refresh lock for http://test@localhost/linter.git/refs/heads/=
master
LOCK HTTP error 412
Unable to refresh lock for http://test@localhost/linter.git/info/refs
LOCK HTTP error 412
Unable to refresh lock for http://test@localhost/linter.git/refs/heads/=
master
UNLOCK HTTP error 400
LOCK HTTP error 412
Unable to refresh lock for http://test@localhost/linter.git/info/refs
Updating remote server info
UNLOCK HTTP error 400
fatal: git-http-push failed
=20
What is the problem can be?



Mon, 25 Oct 2010 22:20:05 +0800 =D0=C9=D3=D8=CD=CF =CF=D4 Tay Ray Chuan=
 <rctay89@gmail.com>:

> Hi,
> 2010/10/25 =E1=CC=C5=CB=D3=C5=CA =E5=C7=CF=D2=CF=D7 <alekseyandni@mai=
l.ru>:
> > I'm using git-core 1:1.5.6.5-3+lenny3.2
> > I can see list of files using cadaver:
> Probably a problem with git. Could you try updating your git installa=
tion?
> --=20
> Cheers,
> Ray Chuan
