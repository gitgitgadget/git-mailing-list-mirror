From: Jakub Narebski <jnareb@gmail.com>
Subject: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Wed, 1 Aug 2007 02:16:59 +0200
Message-ID: <200708010216.59750.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 02:18:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG1ug-0002TP-6w
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 02:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761830AbXHAARm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 20:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761288AbXHAARi
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 20:17:38 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:31040 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760932AbXHAARF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 20:17:05 -0400
Received: by mu-out-0910.google.com with SMTP id i10so57783mue
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 17:17:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XHRdJzDgRPugAMgoku2Syc3GMuH/tTyMPWuaaj2agWeWayPZHuy0XetdDNZznjoepBVV8ALONGD4W84RZK28IK2q+Zuv59neSqBNxA2MaE5KWf6nmn9X+CSfRQR3+ucwI7Anvveyq+b4E81bcmMNAvGw2T8XdyRdS1MYMNRrj0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=A64lj9P53VnQvV9nXNJOjnoJTeyQsJk9DO65h0NAoQR2MxeQ6I3g3yKA9qGxxJ+gAEh8y12yKTUGd3jJh4KrokPFPeP0I8wHTTMlF7ToZJGJAFrbV59A4yfEzlfB/8KjVelGtXTmmvRv5c5beBAvyvjtN6+vTxkwjKeH1PHAhmg=
Received: by 10.86.71.1 with SMTP id t1mr101998fga.1185927422794;
        Tue, 31 Jul 2007 17:17:02 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id a37sm249286fkc.2007.07.31.17.17.01
        (version=SSLv3 cipher=OTHER);
        Tue, 31 Jul 2007 17:17:02 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54382>

I have lately added new Git speed benchmark, from Bryan Murdock blog.=20
The repository is bit untypical:

<quote> =20
  By performance, I mean that I used the UNIX time command to see how
  long various basic operations took. Performing the various basic
  operations gave me some insight into the usability of each as well.
  For this test I used a directory with 266 MB of files, 258 KB of whic=
h
  were text files, with the rest being image files. I know, kind of
  weird to version all those binary files, but that was the project I
  was interested in testing this out on. Your mileage may vary and all
  that. Here=E2=80=99s a table summarizing the real times reported by t=
ime(1):
</quote>

If I remember correctly there were some patches to git which tried to=20
better deal with large blobs. In this simple benchmark git was=20
outperformed by Mercurial and even Bazaar-NG a bit.

http://git.or.cz/gitwiki/GitBenchmarks#head-5657b8361895b5a02c0de39337c=
410e4d8dcdbce
http://bryan-murdock.blogspot.com/2007/03/cutting-edge-revision-control=
=2Ehtml
--=20
Jakub Narebski
Poland
