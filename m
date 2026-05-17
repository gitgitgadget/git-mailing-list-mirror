Received: from send215.i.mail.ru (send215.i.mail.ru [95.163.59.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13FC3451AB
	for <git@vger.kernel.org>; Sun, 17 May 2026 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779010516; cv=none; b=H2Gy1/R8aCxGaCbjvwn1fc1jQTTG7xUTKQWDA/UL3+4mWajviYhrBTH8WAtJHoVmCGBmxUrD6fV9E+VomLmYRZfUzYunqliwse8NF0jh/V0uLhboyuX3QjYVq7LPwBmnr4RTbBfuGEMDRWA9snFgPowIYYaZOHpSVSdtvcv5ZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779010516; c=relaxed/simple;
	bh=fcmAwdG1SkSzRCLaBBt0GnVRk3reEWWu3iDZ1ajs1x0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=uC6DDDzUQ1bvf26a9RhloLD9yPqXO4EceN03AoqXUVP8lfG1CQmtZNiVyInbazftbaiNLqpnuJF7F1DwJRNV1dydZwVkRQfZV/QGx19V0Iin9I0v84pQHYViiIW/gJB7Ty55c+TXXOyVZbuunxgCUPimgXM1LwKkrkxT27eeBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leshe4ka.ru; spf=pass smtp.mailfrom=leshe4ka.ru; dkim=pass (1024-bit key) header.d=leshe4ka.ru header.i=@leshe4ka.ru header.b=e4qNVnca; dkim=pass (1024-bit key) header.d=leshe4ka.ru header.i=@leshe4ka.ru header.b=UUOI+bJD; arc=none smtp.client-ip=95.163.59.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leshe4ka.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leshe4ka.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leshe4ka.ru header.i=@leshe4ka.ru header.b="e4qNVnca";
	dkim=pass (1024-bit key) header.d=leshe4ka.ru header.i=@leshe4ka.ru header.b="UUOI+bJD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=leshe4ka.ru
	; s=mailru; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=Ae94iBAebFn2uS+gm990vDFmoIWaUH3QAgWX0u9n6Go=; t=1779010515; x=1779100515; 
	b=e4qNVncaUZ+3sPSGzo3nG6+BMSPCjNSraosoeiI8XYY04/orkQBki1UI2ICGwpRY5vGjTJl6Jo3
	UadsKtMcMzzOwSm4Ij/hYj/nfiYHcEFik8fy2ktORHQX5fWOKcFk1qzCfcMA40i4EQ1gBaet8rDuI
	HFlpRtkT2hYNS8XDXOM=;
Received: from [10.113.205.83] (port=41862 helo=send57.i.mail.ru)
	by exim-fallback-8448d5fcc9-czf2q with esmtp (envelope-from <admin@leshe4ka.ru>)
	id 1wOXfI-00000000XLW-3L9E
	for git@vger.kernel.org; Sun, 17 May 2026 12:20:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=leshe4ka.ru
	; s=mailru; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=Ae94iBAebFn2uS+gm990vDFmoIWaUH3QAgWX0u9n6Go=; t=1779009604; x=1779099604; 
	b=UUOI+bJDyJZeH5B1ymqwm++2aqqNl7h7pAywuVevBZPc8Tc6wzgGW5WzWIuPY6CWh4NGO4ZXDlO
	n+yqYxAajpwlelosEfarA71cGBJiQKCNcZ4Oetlvtsyp5EGFPsDY3ZRsJzAXrd9bDMXRLEIc8+H8p
	ptvMUhirKgdPWXa9YpA=;
Received: by exim-smtp-8466d5ddfc-xc4sj with esmtpa (envelope-from <admin@leshe4ka.ru>)
	id 1wOXf6-00000000Dyg-1iIg
	for git@vger.kernel.org; Sun, 17 May 2026 12:19:53 +0300
Message-ID: <eaa03980-fbce-4402-88b8-0f260f2927ab@leshe4ka.ru>
Date: Sun, 17 May 2026 12:19:50 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Alex Naidenkov <admin@leshe4ka.ru>
Subject: git rebase --continue segfault
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9EA22463D89EA19FF3A6DCFA4AE1896F6AE4036971BC3E451182A05F5380850404C228DA9ACA6FE270B85CE407DB38AD93DE06ABAFEAF6705305DD8A64A03214B95E776084487EFDD54C098BE40D9806F
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE768BD42809A772457EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375663020B905B4D011A3585FC58AAFD1173026BBF67F91437D288F2766B80188F989389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C045A75973B56231AD8941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6042F1592492B88C6CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C22499DE6AD2C230B254A76E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8BA9D3B29298EB7A373AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E735F1C9CF18C8EB2269C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A533E6DC275044D97C5002B1117B3ED6967ACCB2C6A8978F5D466072E6821086B33610D81D389A125CDE35189EBF2DEA28FEA14CD2CD220BB99C5DF10A05D560A9880EC71AF561E0AAD9143641EC25BB39625D8AB6E1FD6057F36E2E0160E5C55395B8A2A0B6518DF68C46860778A80D54AF47762AB4810619
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659D46A3A78F22950C062F5470EDB029E22AE8D55C8C6C0B88D5AE8AC8F63A025460F96C77B47A45CE0B8341EE9D5BE9A0AE2958DE6F6C931A3694DEE93EB4488FF0001549F3CBF2FAE52EE4E5D9E54FDA44C41F94D744909CE297962314527CE4CCD2BDFDA72912706C98847793A3C30D8
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVax5M0mESuWm2awRu//sPEw=
X-Mailru-Sender: 4D2EE57CDC377DD318D9A9C0AFBECD2D3CD3088A20C1935BB951B70A5BD4BD8E0DBDA50D270B913B9BBFB9D4C9B76856B0DF20F7571CF4112D063C67CFD4E849FF6C93352CAD091FC9C09973CC75087D1167B3295517EB76B4A721A3011E896F
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4253C1AE593082A99F15FEC50743827BE48F54E0D3146F114049FFFDB7839CE9ED35FF1F95AE02984DF043DBFC6616D56D06F796179C4B382BA910E8807524D6DB87CCD4968036E22
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZoeXxIhjyU7V25BUH137bfA==
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

Hi, ive encountered on segfault when ran `git rebase --continue`. 
Hopefully this would help

- i was in the middle of big rebase

- entered pin for signing commit
- segfault happened

```

Debuginfo Build ID: d98c557aaa4baa2e6da8a12cf5a76d241c5af104
```

```

gef➤  bt
#0  repo_parse_tree_gently (r=0x557e86b43780 <the_repo.lto_priv>, 
item=0x0, quiet_on_missing=0x0) at /usr/src/debug/git/git/tree.c:193
#1  0x0000557e869161bd in repo_parse_tree (r=<optimized out>, 
item=<optimized out>) at /usr/src/debug/git/git/tree.h:28
#2  collect_merge_info (opt=0x557e9bf793b0, merge_base=<optimized out>, 
side1=<optimized out>, side2=<optimized out>) at 
/usr/src/debug/git/git/merge-ort.c:1745
#3  merge_ort_nonrecursive_internal (opt=opt@entry=0x7ffe20ae9eb0, 
merge_base=<optimized out>, merge_base@entry=0x557e9bf793b0, 
side1=side1@entry=0x557e9bf79430, side2=<optimized out>,
     side2@entry=0x0, result=result@entry=0x7ffe20ae9e80) at 
/usr/src/debug/git/git/merge-ort.c:5256
#4  0x0000557e8691a6b8 in merge_incore_nonrecursive (opt=0x7ffe20ae9eb0, 
merge_base=0x557e9bf793b0, side1=0x557e9bf79430, side2=0x0, 
result=0x7ffe20ae9e80)
     at /usr/src/debug/git/git/merge-ort.c:5419
#5  0x0000557e869e0e8a in do_recursive_merge (r=r@entry=0x557e86b43780 
<the_repo.lto_priv>, base=base@entry=0x557e9bf8b800, 
next=next@entry=0x557e9bf8b850,
     base_label=base_label@entry=0x557e9bf627e0 "parent of db33c0f 
(fix)", next_label=next_label@entry=0x557e9bfab130 "db33c0f (fix)", 
head=head@entry=0x7ffe20aea160,
     msgbuf=0x557e9bf1b710, opts=0x7ffe20aeb990) at 
/usr/src/debug/git/git/sequencer.c:782
#6  0x0000557e869e355e in do_pick_commit (r=0x557e86b43780 
<the_repo.lto_priv>, item=<optimized out>, opts=0x7ffe20aeb990, 
final_fixup=0x0, check_todo=0x7ffe20aea35c)
     at /usr/src/debug/git/git/sequencer.c:2445
#7  0x0000557e869ebe75 in pick_one_commit (r=<optimized out>, 
todo_list=0x7ffe20aeb330, opts=<optimized out>, 
check_todo=0x7ffe20aea35c, reschedule=<synthetic pointer>)
     at /usr/src/debug/git/git/sequencer.c:4921
#8  pick_commits (r=0x557e86b43780 <the_repo.lto_priv>, 
todo_list=<optimized out>, opts=0x7ffe20aeb990) at 
/usr/src/debug/git/git/sequencer.c:5030
#9  0x0000557e869ef336 in sequencer_continue (r=<optimized out>, 
opts=<optimized out>) at /usr/src/debug/git/git/sequencer.c:5487
#10 0x0000557e867d536e in run_sequencer_rebase (opts=0x7ffe20aeb7a0) at 
builtin/rebase.c:376
#11 run_specific_rebase (opts=0x7ffe20aeb7a0) at builtin/rebase.c:755
#12 cmd_rebase (argc=<optimized out>, argv=<optimized out>, 
prefix=<optimized out>, repo=<optimized out>) at builtin/rebase.c:1910
#13 0x0000557e866e9e65 in run_builtin (p=0x557e86b35530 
<commands.lto_priv+2352>, argc=<optimized out>, argv=<optimized out>, 
repo=0x557e86b43780 <the_repo.lto_priv>)
     at /usr/src/debug/git/git/git.c:506
#14 handle_builtin (args=args@entry=0x7ffe20aed760) at 
/usr/src/debug/git/git/git.c:780
#15 0x0000557e866eb30c in run_argv (args=0x7ffe20aed760) at 
/usr/src/debug/git/git/git.c:863
#16 cmd_main (argc=<optimized out>, argv=<optimized out>) at 
/usr/src/debug/git/git/git.c:984
#17 0x0000557e866e77e4 in main (argc=0x3, argv=0x7ffe20aeda58) at 
/usr/src/debug/git/git/common-main.c:9

```
```

[System Info]
git version:
git version 2.54.0
cpu: x86_64
built from commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
gettext: enabled
libcurl: 8.19.0
OpenSSL: OpenSSL 3.6.2 7 Apr 2026
zlib-ng: 2.3.3
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 7.0.5-arch1-1 #1 SMP PREEMPT_DYNAMIC Fri, 08 May 2026 
09:29:23 +0000 x86_64
compiler info: gnuc: 15.2
libc info: glibc: 2.43
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]
pre-commit
```

