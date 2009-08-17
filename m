From: Ali Polatel <polatel@gmail.com>
Subject: git clone http://git.savannah.gnu.org/cgit/xboard.git segfaults
Date: Mon, 17 Aug 2009 16:56:52 +0300
Message-ID: <20090817135651.GA4570@harikalardiyari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 15:57:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md2ic-00088O-MB
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 15:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbZHQN44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 09:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbZHQN4z
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 09:56:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:14578 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbZHQN4y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 09:56:54 -0400
Received: by fg-out-1718.google.com with SMTP id e21so668780fga.17
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=PJ2fNBCnh0TiTy/wTURA4bBkNtmq0GiZdpXxi7E4IA4=;
        b=QCHGYvu38RS0qqxS4n/dYTJ6Skp9BfG4Gz5IDiU1ac1ULn0Xrqm5GcJN8w1d/hRudG
         bAW6rKWNSuKtORqk7taNtHN4J4bH+DuF27ia8ssec3weq11bwg+VRgvkqR8aB/eJsGxY
         ab2YLSa2je3j59kjaX7wRBvg+KdeVOV4K3tvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=SelkQpjIztE60czCAdRD/+V3JDLC33se8FMpxm2s9wpBmuml3VT4pPk2ZCQ1z4BYXu
         QFNbSXhPhmJSJHfxdPN1XUPPAiDEz2EeUrsBW2rzdZpgZXv15AFsRtNYpn4GYrNz3AcI
         gLHuaH1qeJtS0NmhtuiiJUQe6669a5FEb/uTg=
Received: by 10.86.169.25 with SMTP id r25mr2371134fge.17.1250517414735;
        Mon, 17 Aug 2009 06:56:54 -0700 (PDT)
Received: from harikalardiyari ([78.179.33.172])
        by mx.google.com with ESMTPS id d6sm2669526fga.19.2009.08.17.06.56.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 06:56:54 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126182>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

$subject.
git version 1.6.4

Here's what gdb has to say about it:

2456 alip@harikalardiyari> gdb --args git clone http://git.savannah.gnu.org=
/cgit/xboard.git
GNU gdb 6.8
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-pc-linux-gnu"...
(gdb) run
Starting program: /usr/bin/git clone http://git.savannah.gnu.org/cgit/xboar=
d.git
[Thread debugging using libthread_db enabled]
Initialized empty Git repository in /usr/src/alip/xboard/.git/
[New Thread 0x7f382f0566f0 (LWP 28121)]
got 6db08230fafeb8a5fd163689e0225608bac64169
walk 6db08230fafeb8a5fd163689e0225608bac64169
Getting alternates list for http://git.savannah.gnu.org/cgit/xboard.git
got 94a064d8ab2c5e91d542015dd7307924b20ce729
got a72effb29a1f88097fa34240d35380128c3c84c8
got 6cab23ba23301b578d4995f3c889e574ea4b9e99
Getting pack list for http://git.savannah.gnu.org/cgit/xboard.git
Getting index for pack 720d634dfc5e7511332c1e6851f7c5c5f88e7af2
Getting index for pack 06483273097cbac210f10a4bd43324ae660053e6
Getting index for pack a0a25c7cc57128b5317e0b5e7b8de7a59afe9af6
Getting pack 720d634dfc5e7511332c1e6851f7c5c5f88e7af2
 which contains a91f883e599185408c2e868458fc870b45f90647
walk a91f883e599185408c2e868458fc870b45f90647
walk 94a064d8ab2c5e91d542015dd7307924b20ce729
walk 6cab23ba23301b578d4995f3c889e574ea4b9e99
got ceb25797d2bdef03233071092e73d7cdf750a63d
got 00f19ab354710c1f41deba65b92af335317b25e5
walk 00f19ab354710c1f41deba65b92af335317b25e5
got 5195908348d5a926726de5d5447a27febd58b0c5
got c7646fb352bb0f7a286e991d893604190d6144bb
got b24e950f7c4105d99cb16959934231ee041e2b4e
Getting pack a0a25c7cc57128b5317e0b5e7b8de7a59afe9af6
 which contains 94a9ed024d3859793618152ea559a168bbcbb5e2
got b72e3e511a5aecf63c36ec720d819babc4a32e80
got 96872f2a88d025fb298254d7215b0a2a46ab2517
got 0a785501c2a0af15b29498dc5304d4f78e464724
got 41c83fb406c79f7482de0a63b3a41d7cdc5d9930
got 8f5adeee096e8325a77f4d0f1198c6de3e5c8c4d
got eb8df7d39eaa78cbba8ea6d43e48a9d5565f85c4
got af0c6fb67a21096bde685ebbb442089e158eaab7
got 81d056612386f3bfbb2d954b1776b385b77b0354
got 2ec8546ca81919b50458f2dfee0fb04deb909732
got fd3b1e187f4711df4b2b9be7a538e5e7a6a9d974
got 15bb2bd5db019f4b5873ff47a81876bf744fe3b7
got d0f226bee1b67eecf307cc625925a0aa6b7543ec
got 266e77e80239db82c6c9c74190b172bb4eb9aa2d
got a546658f7c58b1f72e13d038efc77347060ddcb6
got 87f71b2afc316dc18ed39ec5e0eba041b9bc850e
got c89673fe13e92003dd53fc590b682f4bae229a0f
got 71d706e2cd500e15b0b3fcccaba5530a85173759
got a0978a0f361032a670dc644752dae210a2b3d1e8
got 17463be1dd790b3c8e64eaae95135add449e82db
got 8b401ae12b0e72fe9b03ea1b08b2e4cb89378a8d
got 6cdb7dfebf13e58ce8bbca0a2890057694eee073
got f997ac9797b7427a2c3e3abf8dd95bc2df2bf028
got 7d80cb4c3eb366e28f542b095f958289b4a719e3
got 40fb9ce5458e0df6f33160d7392a8b56aa0e1501
got f945dbf2bcef821a53120501b0a06fc0388a2d5c
got c7b87e2a937e0e83a6f6347649e38c1e4636c14a
got b5b9c2fdb4f3964777c3a3f2f92d2784430feddd
got 0d4b26f7ca8c3108d839e9e339adecb8d1395aad
got b2fcec6a8916695ecb5f1007db2e7fc504d23d05
got 82957eb41b19cd497b761c42cebb4580bddd6baf
got 394a9fdac5b251114074c8bea117c5676fd7caa5
got 9c345f61dd8eaf6c5fb45cc90bb133227609608a
got f02507f1df2b2fc9e999d89b2003ef80b92fae8b
got 5806d53acedf3633d17151c1dd3d0f7316dc3264
got 460073895fc709ae6844800bbe61300bf51a0154
got d4c3dbec93edfd27c52775178ba11242ded59193
got e777067113c5726d1706f266de057aa7361dbec5
got 46e2b200ccb840dfab62258434570c840ebebfa1
got f020f22a9ab9e88c6585d8b204aa8ce016a291e5
got 02c9ec3643c6eb94212be431c72a11f03b4e5b1a
got 0657847b19f925d8af5f450c78dda46f8ae5f7d0
got 05af22bd8201f75fb9718382a3307eda68d5e976
got 427cd7d5dfc211ccd962a18bc9666c72a7966b79
got 77d5bf31108026eb97c6b8e288c9d6d092b767dd
got 22737c1f642d614a14045c72a648bfb0fbfbf9da
got b95f2d1475ce464e507d4dbaf2e3af8f6b6f9a48
got f718239d651c2476ff8b7abff7940d2054f44e4f
got ba30dcb13a69fd3b82a10da5456e47b448d4bcc9
got 83d0f555a7dad1d410761ec89273d795f038860c
got 562609284c1f98090bd14dfddbbe2a4991d1e5a8
got d9a98ef891407dd11863ff5e2553ff79aa24d32e
got 0ae04cca10cea96e05c7d4c261aa5d3b208a0b47
got db9e377a69a3d6bd4a8256d00dca3bee680a6a2a
got 1e1e01c9481a519faffbaf6c645dfa8017cabdb5
got 6cd5f80a6aa0390d2412db7d49427ce845d7c946
got b5381c9bfd883c7a84167b022a64c5ca0385930d
got cd0415a4adb0af252cfdf588323a5814a249e90c
got 2a574b7641b9c0f6414b9943695391b6b8252a54
got 5d662edd417ae9f858cb374e03f09a7639b2c03d
got 2bae494f2cf9486b771c706a1eec6217e46ce778
got 8f84481839d7eeb3e0b0da0088b3093742b546cd
got a6d954d86827b3d3777c186d836f4b533602e567
walk 83d0f555a7dad1d410761ec89273d795f038860c
walk 2bae494f2cf9486b771c706a1eec6217e46ce778
Getting pack 06483273097cbac210f10a4bd43324ae660053e6
 which contains 74e24bdc2ec3f275da63ca1396a773e7043cb9e9

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7f382f0566f0 (LWP 28121)]
0x00000000004ada21 in process_object_response (callback_data=3D<value optim=
ized out>) at http-walker.c:93
93	http-walker.c: No such file or directory.
	in http-walker.c
(gdb) thread apply all bt

Thread 1 (Thread 0x7f382f0566f0 (LWP 28121)):
#0  0x00000000004ada21 in process_object_response (callback_data=3D<value o=
ptimized out>) at http-walker.c:93
#1  0x00000000004ab3e3 in process_curl_messages () at http.c:657
#2  0x00000000004ab475 in step_active_slots () at http.c:571
#3  0x00000000004add95 in fetch (walker=3D0x13d3b50, sha1=3D<value optimize=
d out>) at http-walker.c:476
#4  0x00000000004a74e3 in walker_fetch (walker=3D0x13d3b50, targets=3D4, ta=
rget=3D<value optimized out>, write_ref=3D0x0,=20
    write_ref_log_details=3D<value optimized out>) at walker.c:176
#5  0x00000000004a0e46 in fetch_objs_via_curl (transport=3D0x20, nr_objs=3D=
4, to_fetch=3D0x13d5780) at transport.c:375
#6  0x000000000049feab in transport_fetch_refs (transport=3D0x13d4300, refs=
=3D<value optimized out>) at transport.c:1064
#7  0x0000000000416a05 in cmd_clone (argc=3D<value optimized out>, argv=3D<=
value optimized out>, prefix=3D<value optimized out>)
    at builtin-clone.c:513
#8  0x0000000000404391 in handle_internal_command (argc=3D2, argv=3D0x7fff8=
9c74b10) at git.c:246
#9  0x000000000040453d in main (argc=3D2, argv=3D0x7fff89c74b10) at git.c:4=
38
(gdb)=20

--=20
Regards,
Ali Polatel

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEABECAAYFAkqJYaMACgkQQU4yORhF8iC4qgCgl4VsiGOY3jVvnm6NK0EZXj08
KDkAnjjQRr3AY1U3leBsY7gHtHQEm3yC
=ZobT
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
