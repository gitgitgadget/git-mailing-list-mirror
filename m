From: Mitch Tishmack <mitcht.git@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 24 Jan 2008 12:52:44 -0600
Message-ID: <8C467B3C-6C5C-46A2-BB0B-BE689F7D5CAC@gmail.com>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org> <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org> <76718490801231218i53c19e22lda34f2eec88627f8@mail.gmail.com> <1DC841ED-634F-412C-9560-F37E4172A4CD@sb.org> <76718490801231421l7b6552f8sec13f570360198b@mail.gmail.com> <4F906435-A186-4E98-8865-F185D75F14D4@sb.org> <76718490801231517h6d57e5bfkc19d394d38ad19db@mail.gmail.com> <DE7B2DE6-03B1-4781-92C7-096E591369A1@sb.org> <7vk5lzc3yr.fsf@gitster.siamese.dyndns.org> <46a038f90801232037t76e103edt1585d49b2ed19862@mail.gmail.com> <C3E61435-AAF8-4F30-ACD6-B083165B5441@sb.org> <DADD259A-504E-4D98-9C26-5CD9B35B59C1@zib.de>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Jay Soffian" <jaysoffian@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Theodore Tso" <tytso@mit.edu>, "Mike Hommey" <mh@glandium.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Jan 24 19:54:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI7D8-0004rR-7w
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 19:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbYAXSxb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 13:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbYAXSxb
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 13:53:31 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:20717 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbYAXSxa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2008 13:53:30 -0500
Received: by wx-out-0506.google.com with SMTP id h31so233947wxd.4
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 10:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=R4Zg+4ZFfQdjHfsKGW4lIzn1RX+HLs54/6x78ogtB6w=;
        b=c9hB+c7Ffn2/1vTUvyiRusl3E6jhFh5JLhRyV3rk48lQeukWRXLLGoLsZkvV+e3hN019fA9BNF3ES4s23j3aJzIBvm504A/qX0vdHSzRWwq+EhXUl+9a5NIV5NEbVtHs0l7Wl7pgkUb7SrvQ3w2P9a5AraACrAZJqSsENnAgtX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=egtWXZeJbTruTxZxGz3egOS8pNjvigyMZdWdGJkqIi8rfQitpn1/yunQMA045i57OPx+sBymcRjfvZl1Fv24glf+WvNPY3ABDDhNM3H6ckn8y+bGQJ/n9cvff59U4A5o2qvEaA9A2KXDy23mRZ0MxeUKS+OFVc01SZuo/MolxjI=
Received: by 10.70.52.8 with SMTP id z8mr633620wxz.78.1201200808797;
        Thu, 24 Jan 2008 10:53:28 -0800 (PST)
Received: from ?192.168.3.124? ( [71.216.112.176])
        by mx.google.com with ESMTPS id h7sm2168714wxd.10.2008.01.24.10.53.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Jan 2008 10:53:27 -0800 (PST)
In-Reply-To: <DADD259A-504E-4D98-9C26-5CD9B35B59C1@zib.de>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71649>

Apologies Steffen, I grabbed your CamelCase test and did a search/=20
replace, wasn't sure what to call it though... But I am on lunch and =20
wanted to be useful. Rip it apart all you want.

=46ails on hfs* on OSX, works on ufs. I will bother with zfs when it ca=
n =20
be used again.

On UFS:
$ /bin/sh ./t0060-normalization.sh
*   ok 1: setup
*   ok 2: rename (silent normalization)
*   ok 3: merge (silent normalization)
* passed all 3 test(s)


On HFS:
$ /bin/sh t0060-normalization.sh
*   ok 1: setup
* FAIL 2: rename (silent normalization)
=09
=09
	 git mv =E4 =E4 &&
	 git commit -m "rename"
=09
=09
* FAIL 3: merge (silent normalization)
=09
=09
	 git reset --hard initial &&
	 git merge topic
=09
=09
* failed 2 among 3 test(s)

The test case, it uses perl, assuming only 5.6.1+ will work with this:
diff --git a/t/t0060-normalization.sh b/t/t0060-normalization.sh
new file mode 100755
index 0000000..e012c02
--- /dev/null
+++ b/t/t0060-normalization.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description=3D'Test for silent normalization issues'
+
+. ./test-lib.sh
+
+auml=3D`perl -CO -e 'print pack("U",0x00E4)'`
+aumlcdiar=3D`perl -CO -e 'print pack("U",0x0061).pack("U",0x0308)'`
+test_expect_success setup "
+  touch $aumlcdiar &&
+  git add $aumlcdiar &&
+  git commit -m \"initial\"
+  git tag initial &&
+  git checkout -b topic &&
+  git mv $aumlcdiar tmp &&
+  git mv tmp $auml &&
+  git commit -m \"rename\" &&
+  git checkout -f master
+
+"
+
+test_expect_success 'rename (silent normalization)' "
+
+ git mv $aumlcdiar $auml &&
+ git commit -m \"rename\"
+
+"
+
+test_expect_success 'merge (silent normalization)' '
+
+ git reset --hard initial &&
+ git merge topic
+
+'
+
+test_done
--=20
1.5.3




On Jan 24, 2008, at 12:39 AM, Steffen Prohaska wrote:

>
> On Jan 24, 2008, at 6:30 AM, Kevin Ballard wrote:
>
>> On Jan 23, 2008, at 11:37 PM, Martin Langhoff wrote:
>>
>>> Kevin, other people have already started posting nice nuggets of =20
>>> test
>>> cases. Where are *your* test cases? That would be a nice way to =20
>>> "have
>>> the last word" on this ;-)
>>
>>
>> I'm planning on devoting time this weekend to learning enough about =
=20
>> git to be able to start hacking. I'm just too busy during the week =20
>> to be able to devote the dedicated time necessary to this stuff. =20
>> Hopefully I'll actually be able to start producing stuff this =20
>> weekend.
>
> You do not need to learn much about git to post a test case.
> Only a few lines of shell code that demonstrate how git fails to
> handle a specific situation is needed.  To do this, knowledge
> about the internals of git does not necessary help.  It should be
> sufficient to know how to use git.
>
> You may start with a simple shell script and send it to the list.
> Though, a real patch would be the preferred way.  For this, you
> should have a quick look into the t/ subdirectory.  Just open any
> of the tNUMBER*.sh files.  It should be quite obvious how your
> sequence of shell commands could be cast into a git test script.
>
> 	Steffen
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
