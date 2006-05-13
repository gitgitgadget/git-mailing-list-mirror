From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [RFC] qgit with tabs
Date: Sat, 13 May 2006 12:44:35 +0200
Message-ID: <e5bfff550605130344n75e3e55eq533c49fc2a4f5483@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat May 13 12:44:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ferbz-0008F2-70
	for gcvg-git@gmane.org; Sat, 13 May 2006 12:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWEMKog (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 06:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWEMKog
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 06:44:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:44135 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932323AbWEMKof convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 May 2006 06:44:35 -0400
Received: by wr-out-0506.google.com with SMTP id i32so523534wra
        for <git@vger.kernel.org>; Sat, 13 May 2006 03:44:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qiQ53DdcAbiNvkYIxgFI6VO6tIkusF7C3IfJv7onFUjPse4cUv6jmyjNtprmeqEVskom/FSaExttyy9bjSfeqXGInEYSmNHbzBTunrF9ifbH47tVeUm1oJBp1BfeuWoV1XfM2N7r0QURKwTOMJy3iPtYT/0y5zMZz6AF70nhDMM=
Received: by 10.64.88.11 with SMTP id l11mr416986qbb;
        Sat, 13 May 2006 03:44:35 -0700 (PDT)
Received: by 10.64.131.11 with HTTP; Sat, 13 May 2006 03:44:35 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19930>

Hi all,

   I have pushed some patches that add tabs to qgit UI.

I don't expect a new release any time soon, but I am interested to
hear comments, especially on the usability front, so to be able to
steer new development in advance.

With new UI I found myself more and more using keyboard bindings
instead of mouse:

- r, p, f to switch to revisions list, patch and file views respectively

- t to toggle tree view

- s to toggle split view (very useful IMHO)


NOTE:
Due to some repacking on a dumb host probably you need to re-clone:

git clone http://digilander.libero.it/mcostalba/scm/qgit.git
cd qgit
autoreconf -i
./configure
make
make install-strip


          Marco
