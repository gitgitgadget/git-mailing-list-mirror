From: Roberto <mrgreiner@gmail.com>
Subject: Local copy of the repository files
Date: Mon, 07 Feb 2011 16:46:38 -0200
Message-ID: <4D503E0D.5050105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 07 19:46:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmW6q-0000oA-4h
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 19:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565Ab1BGSqm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 13:46:42 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33070 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab1BGSql (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 13:46:41 -0500
Received: by ywo7 with SMTP id 7so1574975ywo.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 10:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=mxVeI9cp+2m6tWmV+qQKdCdn8CRRQZ92i3PddBbIuVg=;
        b=K1+Aw0AcBEzz4CiwmNbU3E/SzxtKMMi8IwjVLW2i82RRYlgnvLkzr4+9DZLfuyI4qX
         FgCUJsVI0b6htdrIEAOcKmCW4MRE7SiDv5GHm/m+pUaiaBd5P8aA/35QEv2zffP/mnUL
         KNE90JG0OysJ+xSPzcYQMlbwBxgyMhNKrrFXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=hQJn8oZE3KE40BWaY3QrXIDlq9CjsruBO4SNaarO00DRcJESDx7iLNCEhIO6Z2hdZ+
         YgbUwyr8DO7/3u4lNEi6XSQEDgB5It16ngSAq1teOBvqoFMKZNdWwJanxSJxOAI6zDLl
         q58ksBV1WbXlrIIsDmWZo3aU1tEwgCXh4WEKU=
Received: by 10.90.116.1 with SMTP id o1mr19981523agc.127.1297104400965;
        Mon, 07 Feb 2011 10:46:40 -0800 (PST)
Received: from [200.145.9.21] ([187.75.228.86])
        by mx.google.com with ESMTPS id c7sm5944724ana.17.2011.02.07.10.46.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 10:46:40 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166269>

Hi,

I'm trying to make my git repository automatically make a local copy o =
f=20
the repository files, but the appropriate command (or commands) is=20
eluding me. Could somebody give me a hint (or point to the appropriate=20
document) as of how to make it work?

In more details, what I need:

When one of our developers does commit/push his work to the=20
server/repository, I need the files to be automatically copied/updated=20
to a plain local folder (something like file://var/www/), so they are=20
viewable through a web browser. Most of those files are php. I don't=20
need an additional repository accessible with WebDAV, HTTP, or somethin=
g=20
alike. Just a copy of the working files, viewable if someone opens a=20
browser and types the URL of our server.

I did configure a "remote" server pointing to that folder (using  git=20
remote add test file:///var/www/), and 'git fetch test' does give me th=
e=20
following output:
 From file:///var/www
    203a9c7..b47fab5  master     -> test/master

So probably it=B4s working correctly. But a "git remote push" is not=20
updating that folder. Also, I believe that probably I'm supposed to use=
=20
a hook (probably post-update), but can't find out what exactly I should=
=20
add in there. Would appreciate any ideas here.

Note: I'm using Debian 5.0-64bits, git 1.5.6.5 (from the apt repository=
).

Thanks,

Roberto

--=20
   -----------------------------------------------------
                 Marcos Roberto Greiner

    Os otimistas acham que estamos no melhor dos mundos
     Os pessimistas tem medo de que isto seja verdade
                                   James Branch Cabell
   -----------------------------------------------------
