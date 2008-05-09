From: =?ISO-8859-1?Q?Florian_K=F6berle?= <FloriansKarten@web.de>
Subject: [egit / jgit] Implementation of a file tree iteration using ignore
 rules.
Date: Fri, 09 May 2008 15:20:08 +0200
Message-ID: <48244F88.8060109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: spearce@spearce.org, robin.rosenberg@dewire.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 15:21:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuSX9-0000EH-6M
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 15:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174AbYEINUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 09:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756354AbYEINUU
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 09:20:20 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:54123 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbYEINUT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 09:20:19 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id E8277DE7D696;
	Fri,  9 May 2008 15:20:16 +0200 (CEST)
Received: from [84.150.113.84] (helo=[192.168.1.50])
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JuSWG-0007Ta-00; Fri, 09 May 2008 15:20:16 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX1+ucAVfgyKj/b+ySRxeaHBbCFjZaLbsQ4HqbujE
	SElvj3rkS8+ITa8qtcbQXxu1sdMsB/wtubwCaQ/3e11FyGUgJb
	HSKeDTQiZvseIAXYwd7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81612>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

I like the idea of a Java implementation of git and would like to
contribute to the jgit/egit project.

In order to get familiar with the code I started to implement a command
like tool which works like git using the jgit library. I implemented
very simple versions of the commands "help", "init" and finally wanted
to implement the "add" command. However, I didn't find any tools to
determine the files which should be added.

So I implemented a factory which returns an Iterable<File> for the
iteration over all the files in a directory.

For an example see the unit test testRealisticExample() in the class
FileIterableFactoryForAddCommandTest:
http://repo.or.cz/w/egit/florian.git?a=blob;f=org.spearce.jgit.test/tst/org/spearce/jgit/lib/fileiteration/FileIterableFactoryForAddCommandTest.java;h=d3c78f4422c708f26ccb56434053bb711fa3116b;hb=669fd814d34e2f989b5f8eedbcb0d5bcf9743ce7

You can view the patches online at:
http://repo.or.cz/w/egit/florian.git?a=shortlog;h=refs/heads/mailinglist-patches-0

I signed all patches and formatted them with the code formatter as I
should. It's ok for me to put the patches under a dual license between a
3-clause BSD and the EPL[*3*]. Currently all files have a GPL 2 notice.
I hope that is ok.

If you want I will send the patches to the mailing list, but I don't
know any automated way to create all the emails. I am not even sure if I
will get them formatted correctly with Thunderbird 2. It would be cool
if you could tell me how to send patches via command line.

I hope you like my patches,
Florian Koeberle
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIJE+I59ca4mzhfxMRAqlwAKCSp57SkqvVsBpdt8o3jL6zNdn0kACfeLnZ
IHErO96fu2rdQcT+JpmroYU=
=E+vF
-----END PGP SIGNATURE-----
