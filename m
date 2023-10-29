Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1154CCA6E
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="TPF5vLi3"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320AFBC
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698605804; x=1699210604; i=l.s.r@web.de;
	bh=GIdfEscalwarWPwzaXXbOzY6zPuqwHWekcG67YOI2No=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=TPF5vLi3i1OKjpSzW5ar5etKf1m2gz8i8fl4X20NdZmCN8u3qWyVcuhrx49qQlAg
	 zMZ2KMdEVDvaTYgHw4KBC+DbJpUIs4j0BVWnNReleEh+TgEZq863skWo+R3G8dyeQ
	 IfsjciRZmrh88qu6qJP8GVqCz/mHPre0cSH1wpwyE8wJbhuzoWzR0mj7dEt1IqbGL
	 GrwP4jIjQp+A/s2up2/ByI6EMMraRKcYK3uZG6sr/EIFJzdy4SO7HXct/XDYtXHiv
	 D3PQpaOIr1uwlSA8yjfT+KPdBbF3l/Awe6IxTsBU6jwXh0tRSXfMMk0Br4j6Ac0O1
	 bVJ+Eg7ZQByKK2ixqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.209]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmlu-1qiJNy1LKI-00FCiq; Sun, 29
 Oct 2023 19:56:44 +0100
Message-ID: <cc829a27-2580-4e07-a6ff-2c4992131420@web.de>
Date: Sun, 29 Oct 2023 19:56:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: ls-remote bug
To: Lior Zeltzer <liorz@marvell.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
Cc: Andrzej Hunt <ajrhunt@google.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <BL0PR18MB2130C672D503E49F955E04E8BADFA@BL0PR18MB2130.namprd18.prod.outlook.com>
 <BL0PR18MB2130A3CA5DEF0DD7199F2979BADFA@BL0PR18MB2130.namprd18.prod.outlook.com>
 <ZTsNfgJV1JN2y-Aw@debian.me>
 <BL0PR18MB213007901229C84D348D4CB8BADCA@BL0PR18MB2130.namprd18.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <BL0PR18MB213007901229C84D348D4CB8BADCA@BL0PR18MB2130.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N6R8Jth9MfB6jOxOToLxN1iHXITkagvytbbFx/2lPMXuiAOgUr+
 3hkTvgmFVWPGKn8wedcUrY4GMv4QI3DSaQLb6fc13qW5LLiy9R5SEU78Qeun1DHyUyZ+tIx
 etDr0rk14N6VFLwozrLItnhmCLsMjVWVk8lMo2awj7/thb0KFqDxd0j8GJcy9M8wsoqQNUL
 XuSh47dYMTPH/TO3l6Cxg==
UI-OutboundReport: notjunk:1;M01:P0:zO3EFqT5E6U=;71tsPsnikgkhywjB+KULrBCcX/k
 WKa8CdhBIIypixxZ9XLEAmjvuW+DzsndVdt7xqJ+oQaAzit/UtS4zAP7+fC+mANoNUSeSR6Iz
 bgUlrilNfJj5InfABj0CNDStDZTA4ey90eRsHsw6DXGI6BK19AxBh43vmfijC6H1o/usFV6yb
 UvKU9Zcx7Lbq8UP1P8knt3qSrd/KLhXDmik1BnAMHv6A8G50LhYQxYf/ltXFkCBnRxZ00yKme
 0Dvc0StwpyvOxBEg5Fzba5ALwOO25Oa86evlPcUkC7UDQXiD38oAp3p1jR8hWN45jRJf95Dp8
 58FwVzPydrfl95RshGFUXp0hcakeomDETQACwTFAXXfnhId+S5OaTGpqCxgQNXTLbgvxKvvei
 XMp4UXb97XF7nVE13XjBbsmMv1GSf1n0kMHkKFSVMLJkxZ/4rF9OgjK0iADPnICCqn7IzpQ6S
 iPEHlFblf/WoVilz75qZXTDHM8IpEYzT2uZfn9s3iPiiYf1lNzvr4I8eR8zOD90shmwLe22Mn
 CNIZBzM8442584VfLSx5cAOSyzg5yICKGLzBZhA9Hehekg1E5YyMXGoVDbZK6OW+a6Ye1I8o1
 C7B6roKmR6YkqtxG1We/mDTyFY7zWTK1iqeKfp+ASKteklmkEUZcpegYH9T8kNc/CUt0xiZ3v
 Uzn2IW20E/6CC5rfsX8ZJbNPksYBYYHwF36EL3DxsnoOHh9deSxdVX7gFWR1qzyPT5hPygdWz
 TtloZFUNholHcGcdcN4WYLs9ioYcq03c96W1CINGh5u4BtxQYAMjll+ygnLuNzYIXurruqDUw
 4EofoNl6yI7Qfy5FXgDZCRrwaL7U4+qVJEd6UU+/WltbLPlVwQSEPdDmEOYOhaonOyaFWUqH3
 Wx3FrM6SOsJULk8RpRs3b/HPqJCsqpRtx8FfTFlg6ASLmb0gmh7z6pfYkkYEjWiNpXQnTBudX
 +DR2FQ==

Am 27.10.23 um 13:16 schrieb Lior Zeltzer:
> The reproduction ,as I wrote in the code, should be done with few thread=
s in parallel
> Each working on a list of ~10 repos with each repo containing a lot of r=
efs/tags (~1000)
> All this should be against gerrit (my gerrit is 3.8.0)
>
> Also read the notes below regarding the code that was moved between 2.31=
.8 and 2.32.0 in ls-remote.c file
> I can elaborate more, in a zoom meeting.
>
> 10x
> Lior.
>
>
> -----Original Message-----
> From: Bagas Sanjaya <bagasdotme@gmail.com>
> Sent: Friday, October 27, 2023 4:08 AM
> To: Lior Zeltzer <liorz@marvell.com>; Git Mailing List <git@vger.kernel.=
org>
> Cc: Andrzej Hunt <ajrhunt@google.com>; =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason <avarab@gmail.com>; Junio C Hamano <gitster@pobox.com>
> Subject: [EXT] Re: ls-remote bug
>
> External Email
>
> ----------------------------------------------------------------------
> On Tue, Oct 24, 2023 at 10:55:24AM +0000, Lior Zeltzer wrote:
>>
>>> uname -a
>> Linux dc3lp-veld0045 3.10.0-1160.21.1.el7.x86_64 #1 SMP Tue Mar 16
>> 18:28:22 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>
>> Gerrit version :
>> 3.8.0
>>
>> Bug description :
>> When running ls-remote : sometime data gets cut in the middle
>>
>> Reproducing :
>> You need a few files with a few repo names (I used 4 files with 10
>> repos each) Call then l1..l4 And the code below just cd into each of
>> them does ls-remote twice and compares the data Doing it in parallel
>> on all lists.
>> Data received in both ls-remotes should be the same , if not, it
>> prints *** Repos should contain a lot of tags and refs
>
> What repo did you find this regression? Did you mean linux.git (Linux ke=
rnel)?
>
>>
>> Note :
>> 1. =C2=A0without stderr redirection (2>&1) all works well 2. On local r=
epos
>> (not through gerrit) all works well
>>
>> I compared various git vers and found the bug to be between 2.31.8 and
>> 2.32.0 Comparing ls-remote.c file between those vers gave me :
>>
>> Lines :
>> if (transport_disconnect(transport))
>> 		return 1;
>>
>> moved to end of sub
>>
>> copying ls-remote.c from 2.31.8 to 2.32.0 - fixed the bug

This partly undoes 68ffe095a2 (transport: also free remote_refs in
transport_disconnect(), 2021-03-21).  With that patch connections are
kept open during ref sorting and printing.

Perhaps the other side gets tired of waiting and aborts?  Maybe
splitting transport_disconnect() into two functions -- one for
disconnecting and and for cleaning up -- would make sense? And
disconnecting as soon as possible?  Just guessing -- didn't actually
reproduce the bug.  Still, demo patch below.

>>
>>
>>
>> Code reproducing bug :
>>
>> #!/proj/mislcad/areas/DAtools/tools/perl/5.10.1/bin/perl -w use
>> strict; use Cwd qw(cwd);
>>
>> my $count =3D 4;
>> for my $f (1..$count) {
>> =C2=A0 my $child =3D fork();
>> =C2=A0 if (!$child) {
>> =C2=A0=C2=A0=C2=A0 my $curr =3D cwd();
>> =C2=A0=C2=A0=C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0my @repos =3D `cat l$f`;
>> =C2=A0=C2=A0=C2=A0 foreach my $repo (@repos) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chomp $repo;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print "$repo\n";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chdir($repo);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 my $remote_tags_str =3D `git ls-remote=
=C2=A0 2>&1`;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 my $remote_tags_str2 =3D `git ls-remote=
=C2=A0 2>&1 `;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chdir($curr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ( $remote_tags_str ne $remote_tags_st=
r2) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print "***\n";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0 }
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0exit(0);
>> =C2=A0 }
>> }
>> while (wait !=3D -1) {}
>> 1;
>>
>
> I tried reproducing this regression by:
>
> ```
> $ cd /path/to/git.git
> $ git ls-remote 2>&1 > /tmp/root.list
> $ cd builtin/
> $ git ls-remote 2>&1 > /tmp/builtin.list $ cd ../ $ git diff --no-index =
/tmp/root.list /tmp/builtin.list ```
>
> And indeed, the diff was empty (which meant that both listings are same)=
.
>
> Confused...
>
> --
> An old man doll... just what I always wanted! - Clara


=2D--
 builtin/ls-remote.c |  8 +++++---
 builtin/remote.c    |  3 ++-
 transport.c         | 15 +++++++++++++--
 transport.h         |  2 ++
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index fc76575430..4c1daa0f92 100644
=2D-- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -128,6 +128,8 @@ int cmd_ls_remote(int argc, const char **argv, const c=
har *prefix)
 		int hash_algo =3D hash_algo_by_ptr(transport_get_hash_algo(transport));
 		repo_set_hash_algo(the_repository, hash_algo);
 	}
+	if (transport_disconnect_raw(transport))
+		status =3D 1;

 	if (!dest && !quiet)
 		fprintf(stderr, "From %s\n", *remote->url);
@@ -154,12 +156,12 @@ int cmd_ls_remote(int argc, const char **argv, const=
 char *prefix)
 		if (show_symref_target && ref->symref)
 			printf("ref: %s\t%s\n", ref->symref, ref->refname);
 		printf("%s\t%s\n", oid_to_hex(&ref->objectname), ref->refname);
-		status =3D 0; /* we found something */
+		if (status !=3D 1)
+			status =3D 0; /* we found something */
 	}

 	ref_array_clear(&ref_array);
-	if (transport_disconnect(transport))
-		status =3D 1;
+	transport_clear(transport);
 	transport_ls_refs_options_release(&transport_options);
 	return status;
 }
diff --git a/builtin/remote.c b/builtin/remote.c
index d91bbe728d..055a221942 100644
=2D-- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1000,6 +1000,7 @@ static int get_remote_ref_states(const char *name,
 		transport =3D transport_get(states->remote, states->remote->url_nr > 0 =
?
 			states->remote->url[0] : NULL);
 		remote_refs =3D transport_get_remote_refs(transport, NULL);
+		transport_disconnect_raw(transport);

 		states->queried =3D 1;
 		if (query & GET_REF_STATES)
@@ -1008,7 +1009,7 @@ static int get_remote_ref_states(const char *name,
 			get_head_names(remote_refs, states);
 		if (query & GET_PUSH_REF_STATES)
 			get_push_ref_states(remote_refs, states);
-		transport_disconnect(transport);
+		transport_clear(transport);
 	} else {
 		for_each_ref(append_ref_to_tracked_list, states);
 		string_list_sort(&states->tracked);
diff --git a/transport.c b/transport.c
index 219af8fd50..c71dab75e9 100644
=2D-- a/transport.c
+++ b/transport.c
@@ -1584,17 +1584,28 @@ int transport_connect(struct transport *transport,=
 const char *name,
 		die(_("operation not supported by protocol"));
 }

-int transport_disconnect(struct transport *transport)
+int transport_disconnect_raw(struct transport *transport)
 {
 	int ret =3D 0;
 	if (transport->vtable->disconnect)
 		ret =3D transport->vtable->disconnect(transport);
+	return ret;
+}
+
+void transport_clear(struct transport *transport)
+{
 	if (transport->got_remote_refs)
 		free_refs((void *)transport->remote_refs);
 	clear_bundle_list(transport->bundles);
 	free(transport->bundles);
 	free(transport);
-	return ret;
+}
+
+int transport_disconnect(struct transport *transport)
+{
+	int ret =3D transport_disconnect_raw(transport);
+	transport_clear(transport);
+	return 0;
 }

 /*
diff --git a/transport.h b/transport.h
index 6393cd9823..fd75905568 100644
=2D-- a/transport.h
+++ b/transport.h
@@ -320,6 +320,8 @@ int transport_fetch_refs(struct transport *transport, =
struct ref *refs);
 void transport_unlock_pack(struct transport *transport, unsigned int flag=
s);

 int transport_disconnect(struct transport *transport);
+void transport_clear(struct transport *transport);
+int transport_disconnect_raw(struct transport *transport);
 char *transport_anonymize_url(const char *url);
 void transport_take_over(struct transport *transport,
 			 struct child_process *child);
=2D-
2.42.0

