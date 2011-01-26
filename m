From: Alan Sargent <alsarg72@gmail.com>
Subject: fatal: protocol error: bad line length character: GET <<<<<
Date: Wed, 26 Jan 2011 12:53:11 +0800
Message-ID: <AANLkTimDbHdOwkPu6qihdgJFY0bS0XTVatLCriCmM1nX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 26 05:53:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhxNz-0005gs-KF
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 05:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520Ab1AZExe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jan 2011 23:53:34 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60817 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1AZExd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jan 2011 23:53:33 -0500
Received: by bwz15 with SMTP id 15so862136bwz.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 20:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=sM23vSOuI++sJNRuWN6l2vYz572g20DqtkHqkgE2GRU=;
        b=eOWjVcIDMwnRJ6Ch3DKt08I3AWwpxw0lruzfSLwDblZRnPNrhqwR3j2AmWgwYuUnxn
         umyX/I9e4Atsx6FgMhoG0kQFVIlAO04N7yuC5TFIi4fGgdFzZayAAdRdTBIVBz5/4caD
         whAcDTUodirAPfyroDm2oDPM/v14A2mSSitFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        b=rRS9rxSd+G/g5aWJlekjr3P0JCpPZwP3t8CyRimvPW+fd5quYObyu+ioq1eENI+Lku
         YpmB7sEPD23zrNLXhDDRgALbtzw6mVPltH45EVJNdYJjN8Li5+uVYu02uRcnRuX8zNtI
         NVpYRqTj9SCPnacS9EuNmwY8tKik5oFpHcyNE=
Received: by 10.204.71.141 with SMTP id h13mr5989860bkj.180.1296017612063;
 Tue, 25 Jan 2011 20:53:32 -0800 (PST)
Received: by 10.204.100.205 with HTTP; Tue, 25 Jan 2011 20:53:11 -0800 (PST)
X-Google-Sender-Auth: 8VtaJhWuFs20x2XGG2-UEPnyqng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165500>

Hello,

The "fatal: protocol error: bad line length character" seems fairly
common, but in the archive and the faq there isn't reference to this
particular instances - GET.

alan@toaster:~$ git init myrepo
Initialized empty Git repository in /home/nev/myrepo/.git/
alan@toaster:~$ cd myrepo
alan@toaster:~/myrepo$ git daemon
fatal: protocol error: bad line length character: GET=A0=A0<< just hitt=
ing
=465 in the browser
fatal: protocol error: bad line length character: GET
browser showing=A0Error 101 (net::ERR_CONNECTION_RESET): Unknown error.
fatal: protocol error: bad line length character: GET
fatal: protocol error: bad line length character: GET
fatal: protocol error: bad line length character: GET
fatal: protocol error: bad line length character: GET
fatal: protocol error: bad line length character: GET

This is on Ubuntu, git installed fresh or built it from latest stable
source. Same on a repo that has stuff in it.

Anyone know why?

Cheers.
