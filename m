From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Question about installing git from source
Date: Tue, 23 Dec 2014 14:55:06 +0600
Message-ID: <CANCZXo42SdM8hMdTFYgvD8D+RmXua1oJvB+FfTjjfR=yWqhmkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 23 09:55:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3LFO-0002q8-AB
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 09:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbaLWIzK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2014 03:55:10 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33388 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbaLWIzG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Dec 2014 03:55:06 -0500
Received: by mail-ob0-f171.google.com with SMTP id uz6so24479120obc.2
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 00:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=wQa0V9t/zS8vLZLadnLNNFWZKcMjc04izWEpO8E1fg4=;
        b=TW9mh65FL34hSpDpN9YodUYWmR2sinUKX/yZ0LAr5Y8y60eRXgNLFQaLebc4X+ODxK
         /y0CAg8Q4MWa477wHK0SJJBcc+a9XX2Atd0rqIkCZ8GnrF/jXFipkrBeqZJ5Yeoy0L0k
         ocl0kToAmdaiF4sTc1isn94Z4joY65J0kYTAiEEqcaPZCuUvuIHHpDsH5t1G4hihjOJw
         LYIR8XygqEZ4Pk16PcpUNc0/PqSlUBexBx23ruvgu0/ujEGssgvHnlKu23u3l1kMNOSf
         JuHSIm2cQHwYC6xByIE6ABXoJypi8/y0QoAJ1I33s/z7WtmL8Sux8jXqA6C0M1lbJwn8
         rHVQ==
X-Received: by 10.182.246.68 with SMTP id xu4mr15725964obc.59.1419324906218;
 Tue, 23 Dec 2014 00:55:06 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Tue, 23 Dec 2014 00:55:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261719>

Hello All,

Trying to install git from source, executing:

make configure
=2E/configure --prefix=3D/usr
make --prefix=3D/usr all
sudo make install DISTDIR=3D/usr

And getting following:

install -d -m 755 '/usr/usr/bin'
Copying scripts to /usr/bin
cp: omitting directory =E2=80=98autom4te.cache=E2=80=99
cp: omitting directory =E2=80=98bin-wrappers=E2=80=99
cp: omitting directory =E2=80=98block-sha1=E2=80=99
cp: omitting directory =E2=80=98builtin=E2=80=99
cp: omitting directory =E2=80=98compat=E2=80=99
cp: omitting directory =E2=80=98contrib=E2=80=99
cp: omitting directory =E2=80=98Documentation=E2=80=99
cp: omitting directory =E2=80=98ewah=E2=80=99
cp: omitting directory =E2=80=98git-gui=E2=80=99
cp: omitting directory =E2=80=98gitk-git=E2=80=99
cp: omitting directory =E2=80=98gitweb=E2=80=99
cp: omitting directory =E2=80=98mergetools=E2=80=99
cp: omitting directory =E2=80=98perl=E2=80=99
cp: omitting directory =E2=80=98po=E2=80=99
cp: omitting directory =E2=80=98ppc=E2=80=99
cp: omitting directory =E2=80=98t=E2=80=99
cp: omitting directory =E2=80=98templates=E2=80=99
cp: omitting directory =E2=80=98vcs-svn=E2=80=99
cp: omitting directory =E2=80=98xdiff=E2=80=99
Done

What's problem can be here?

Thank you.
