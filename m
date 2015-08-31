From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Date: Mon, 31 Aug 2015 09:03:51 +0000
Message-ID: <1441011831.3349.150.camel@transmode.se>
References: <1440157010.1759.83.camel@transmode.se>
	 <1440157845.1759.85.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 31 11:04:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWL0T-0004O6-2x
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 11:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbbHaJD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 05:03:57 -0400
Received: from smtp.transmode.se ([31.15.61.139]:55322 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbbHaJD4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2015 05:03:56 -0400
Received: from exch1.transmode.se (exch1.transmode.se [192.168.201.16])
	by smtp.transmode.se (Postfix) with ESMTP id 6846011870D2
	for <git@vger.kernel.org>; Mon, 31 Aug 2015 11:03:52 +0200 (CEST)
Received: from exch1.transmode.se (192.168.201.16) by exch1.transmode.se
 (192.168.201.16) with Microsoft SMTP Server (TLS) id 15.0.1076.9; Mon, 31 Aug
 2015 11:03:52 +0200
Received: from exch1.transmode.se ([fe80::bd49:a412:5dc4:aadd]) by
 exch1.transmode.se ([fe80::bd49:a412:5dc4:aadd%17]) with mapi id
 15.00.1076.000; Mon, 31 Aug 2015 11:03:52 +0200
Thread-Topic: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Thread-Index: AQHQ3AWr4MUVkjVcJE+EJNOGRY0lNp4WNaeAgA+Ir4A=
In-Reply-To: <1440157845.1759.85.camel@transmode.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.16.4 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.200.4]
Content-ID: <C1DB703212A2ED44A27F36579F0EC9BF@transmode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276858>

On Fri, 2015-08-21 at 13:50 +0200, Joakim Tjernlund wrote:
> On Fri, 2015-08-21 at 13:36 +0200, Joakim Tjernlund wrote:
> > I cannot push:
> > # > git push origin
> > Login for jocke@git.transmode.se
> > Password: 
> > Counting objects: 7, done.
> > Delta compression using up to 4 threads.
> > Compressing objects: 100% (7/7), done.
> > Writing objects: 100% (7/7), 13.73 KiB | 0 bytes/s, done.
> > Total 7 (delta 4), reused 0 (delta 0)
> > fatal: Unable to create temporary file '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission 
> > denied
> > fatal: The remote end hung up unexpectedly
> > fatal: The remote end hung up unexpectedly
> > cu-km022 tmv3-target-overlay # ls -l
> > total 0
> > drwxr-xr-x 1 root root  72 Aug 19 17:59 ./
> > drwxr-xr-x 1 root root  38 Aug 19 17:59 ../
> > drwxr-xr-x 1 root root 216 Aug 21 13:07 .git/
> > drwxr-xr-x 1 root root  22 Aug 19 17:59 metadata/
> > drwxr-xr-x 1 root root  58 Aug 19 18:27 profiles/
> > drwxr-xr-x 1 root root  74 Aug 19 17:59 sys-apps/
> > drwxr-xr-x 1 root root  42 Aug 19 17:59 sys-libs/
> > 
> > On server I have:
> > # >ls -la
> > total 24
> > dr-xr-sr-x   6 apache tm-3000  123 Jun 10 15:25 .
> > drwxr-xr-x  36 root   root    4096 Jun 25 11:11 ..
> > -r--r--r--   1 root   tm-3000  263 Jun 10 15:18 config
> > -r--r--r--   1 apache tm-3000   73 Jun 10 15:18 description
> > -rw-r--r--   1 root   tm-3000    0 Jun 10 15:25 git-daemon-export-ok
> > -r--r--r--   1 apache tm-3000   23 Jun 10 15:18 HEAD
> > drwxr-sr-x   2 root   tm-3000 4096 Jun 10 15:18 hooks
> > drwxrwsr-x   2 apache tm-3000   20 Jun 10 15:18 info
> > drwxrwsr-x 135 apache tm-3000 4096 Aug 20 19:07 objects
> > drwxrwsr-x   4 apache tm-3000   29 Jun 10 15:18 refs
> > 
> > 
> > I suspect this is because no one is allowed to write the repos top dir.
> > It would be much better if git allowed a tmp dir inside the repo and used that 
> > for push etc.
> > Meanwhile, is there some workaround I can use?
> 
> This error seems to only affect shallow clones.
> Forgot, git version 2.4.6

Ping?

 Jocke
