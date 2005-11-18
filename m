From: John Benes <smartcat99s@gmail.com>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 22:01:27 -0600
Message-ID: <437D5217.2050606@gmail.com>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk> <b0943d9e0511160311k725526d8v@mail.gmail.com> <7vr79g8mys.fsf@assigned-by-dhcp.cox.net> <7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com> <7vy83ny450.fsf@assigned-by-dhcp.cox.net> <81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com> <7vwtj7wn7n.fsf@assigned-by-dhcp.cox.net> <437D2D14.5080205@gmail.com> <Pine.LNX.4.63.0511180345450.6359@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 18 05:03:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcxRd-0008MK-LM
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 05:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVKREBp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 23:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVKREBp
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 23:01:45 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:44563 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932457AbVKREBo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 23:01:44 -0500
Received: by zproxy.gmail.com with SMTP id 13so100906nzn
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 20:01:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=NnyunSnEv8jBtjgj5/vAmrLbiix8XKcNNgPaQKyu++n/xEkjdnz+Rhq8EDjobxufrbluRcqoXrnultVbHItp3tFjgwZNydM01f6JM4ULBMyFfoxcL3MFcwQDj1u7mRxCx11NAyr6LOs3BAOQ2Wuk1NQ09lvCZ5Q8fyYOOCNOSzI=
Received: by 10.36.178.18 with SMTP id a18mr8345985nzf;
        Thu, 17 Nov 2005 20:01:44 -0800 (PST)
Received: from ?192.168.0.198? ( [68.96.128.241])
        by mx.gmail.com with ESMTP id 15sm389463nzp.2005.11.17.20.01.41;
        Thu, 17 Nov 2005 20:01:44 -0800 (PST)
User-Agent: Thunderbird 1.5 (Windows/20051117)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0511180345450.6359@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12192>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Johannes Schindelin wrote:
> BTW, it would be more helpful if you do not just tell *what* test fails, 
> but *how*. For example, try to run "git-whatchanged -p" and send just 
> the first page of the output (both stdout and stderr). I bet it says it 
> has a problem fixing up mmap() after fork().

I ran "git-whatchanged -p" with the previously mentioned master build
installed in /usr/bin.  Below is a copy of the command session.

Stdout was redirected to test2.txt, which is located at:
http://www.penguinlounge.1and2.org/videos/test2.txt.bz2

Twinkie@squirrel ~/git
$ git-whatchanged -p > ../test2.txt

Twinkie@squirrel ~/git
$ cd ..

Twinkie@squirrel ~
$ ls -la test2.txt
- -rw-r--r--  1 Twinkie None 9338905 Nov 17 21:23 test2.txt


nothing was displayed on stderr.


The make test error was shown on linux too. [1]
It reports as:
Twinkie@squirrel ~/git/t/trash
$ git-apply --check --allow-binary-replacement BF.diff
fatal: patch with only garbage at line 30

could it be an outdated diff? (2.8.7)

[1] Re: "make test" fails with current HEAD @ 9:23PM CST by A Large
Angry SCM

Anything else you want me to bash this Cygwin install against?

- --
John Benes
GPG Fingerprint: D519 25DB BB5C 38FC 9D02  02E7 596D BC50 F880 27FA
"It is not only the living who are killed in war." - Isaac Asimov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBQ31SF2F0oWcU9kCNAQKLUxAAtqOpSCsGSnNz+q9x8gzqaqjCK+mjjUkJ
YJFalTEeNO9/alp3mPGb4kXwhMahyugGqHZzr2Lp5JC0gDSsn5vqF2sxYtB9yvAg
1lg33awy5AI1LkIcbeiCvjkBI83UvIjOYLEs1YcIXKRDYJkcbo6yBN4uqkDZKAoS
O8L3q2r2/mCJQYlANy1ruhT0Al5xPwTFNv6JqIkm8PWsPE+es6ZwyFBXKi62CHu5
AWsc2nHDhPIx5YS1h7CIIQjiRh2qkf807IvXKZtY++o7yoHn49Rtu87VblZhkuH5
UHOSE0gDbT37MbIg6hoZc20kBZIq1s+6e+/FhrFAUrmnny9t7fPaU35gJmPPA63W
KajRKOwChmO6V5scTfgimxxzN4Jlnd+AM8FdxTWCfz6s4FLnnzukwX5T4PbWw6Kg
if8fekhKkPYCLQtAa8Q6Xe5GIZJ5ghVRfAnZWhc4p8OJj6gacwGCk/QX0Rxu6z3r
BF9e7RCyytwDw2Lw87NJFc7AYp4V4uINOAMMxPK0eidHOkkVVzu3eaoB8OIVzh5Q
oAwo+gPpd/PgFldJJu4i9e8bD8/J7cwZ0vpMkRDig9P1ZqFCj9t2+bAVzOgJPb80
4YG/UR4VwVuKyYDeLhCHNLYJBssNXCCkN4+UKuLcNsk6+pXzniPVAc2Wda5BMIj2
LV5oMRUCpKQ=
=NFuc
-----END PGP SIGNATURE-----
