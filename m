Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29131D69E
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457473; cv=none; b=dkEq+zX5UuDREew/ensUat6WikTJdcuhDo9YQI0BkABHygvy+M/cjocI2svIUNrmuGLVtxFMY6BQyI0s7lo5CjwHgIrdnQE72TzIqwdCJuK/1NoyfuYFCmdWqwRBAsBC3aqh3GP3HZ1fmUgjKAW2SvytCzMzBixaF9n2O9bR+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457473; c=relaxed/simple;
	bh=DgmQcwEXvjd4+VvWxkJ2J0VqcjW1EuQNJkVbSia39Nw=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=ZX4IQsx0JxCTW0njWWS23WGCEzgkDqaejTck6FMmurONgwO2niT2Or6Vy1qhXXSyZbkdjar+vbSS87QALIIxde+ebWOQqEmwCdLUPZa5+rzHHoih3fFqqPYJ9ZOX00fvXkVvZOUxlfimf49TOeFwKq59xuSDNVeLJiO901sUG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=online.ms; spf=pass smtp.mailfrom=online.ms; dkim=pass (2048-bit key) header.d=online.ms header.i=github@online.ms header.b=DDD5JH5w; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=online.ms
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.ms
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.ms header.i=github@online.ms header.b="DDD5JH5w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.ms;
	s=s29768273; t=1720457458; x=1721062258; i=github@online.ms;
	bh=QrfH2McOKVfa+DD4TnSX3siK3HpkHhH8GnxQkAfpbbE=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DDD5JH5wC+pnLaFZhpSkHdFjRY6PpAyO4epOa1mqxj01BIq7cnRBq5Zp23sMcQ4C
	 m/hq5XQis2SlBca8NuX/3j03ufT5yOOAOBLbkcjhdEeUj0oSOKMCrKcD46ZrKGULo
	 eLOuJA8JREt5Rj1WoictL+oAzH6CqatU95MifDS7sMRnIGZyN0l08LBkkCl+4sgnD
	 RxJw7NkAvcqHWy4h4AeDqoU/c20173xGD13YLQm1LL1MB8tJNUzZmH60x8A2AiJUf
	 NpfEB/ce2Y9C2RGzIfOGwxxU5T/eh3+QU00w+RBvr3Dvjz/JAko4E+gO9R3tqY5jT
	 zPM4wyolU4It4ge9KA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [176.198.82.185] ([176.198.82.185]) by web-mail.web.de
 (3c-app-webde-bap34.server.lan [172.19.172.34]) (via HTTP); Mon, 8 Jul 2024
 18:50:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-3d633a4a-10c6-444e-9e5c-79330941ddb6-1720457458565@3c-app-webde-bap34>
From: github@online.ms
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Aw: Re: linux git init/clone on Netapp NTFS security style volumes
Content-Type: text/plain; charset=UTF-8
Date: Mon, 8 Jul 2024 18:50:58 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <ZoryWtGqsD9iIafI@tapette.crustytoothpaste.net>
References: <trinity-ea5945a3-0663-4e48-b995-913003b5e932-1720294530422@msvc-mesg-web002>
 <ZoryWtGqsD9iIafI@tapette.crustytoothpaste.net>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:JTXkqER5O072u389WcilzhZSKNuKeKo3WemyV7Ay6D2lj6IK9Abm2bEhhwvaxLGQ7l92K
 HbaQysxpRD05lTwWmB2gCxYfvaFDjzrcGQGmj/EpvVnyORf33KJY2pnINVWCCdFUjaQO9DOZyQ5Q
 XboUVdCl2NsMUxOOkkfWYxOQZvhxVHuqzpe5teHrnWSD0ROm9vTRPcRYNPpYZCWLjLXJl9atvfME
 4XjYHX9sON/NkfOgsEihY3iS3N63O+/y5c81Ifbo/cxpoCAX7JxYyc/UQqF5eoqFiBA1aQPBWwNC
 qE=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LTZH5h11ucs=;mqsln8YC1COxRiOZ/uPFWQdAf9/
 VJaZhK35d3y93SFIblkE+rjVAVk2k/7u2Q1MFLcgirLJvfbRf6RUx/tG8VNkG7Cmw0rPc2/1o
 8ykhIoNkr+aDi5qTpEiixjIJ55jomK0es19VWCVYmW+Y382ojrFTQbrvMqJFV/gw8VyXFKZg8
 0BBRDvN0XWOCbaIplw1RUmVeQodu8X9YbuDHOkRojrXNyEkstYSSQiDUFvELm/2givNQYrAfl
 SzYKWqVwGO7FkAtpnqo8FKBS/V9IhO4S1LzABvhud0UD6PJVo8UxEl8Wf7gyEshaS2qcEDHkn
 O4DOsUPce2hn9mf95n6x5/V8teKWfFa2cU3kpnJLWZySIgwxj+c/QS+C+DzV4i4n7FvTz4l3Z
 Utcz/ao7bXkK4ql8+bjpwPOTVzWMNNmJbW7HjDYSsd0pZXVFaxK1vfk2CHcOkHv0aEGGHBGbh
 IdgSfYvLWMauB/ukZkvww47oWBRjHR5KR1WtJZBrrmlAm601cTJ5Jp9YF1+oEfQGWAlPKNiQ9
 h7RMVTlj2yJ1v5vSbOiR0g4LhGSkB0+8KV8C0SqH6AbUTNYX+SBxrLqofEemn1tznUBKnSmgc
 IHBK5qH+qRm0jIDORXr0rQ23kZKmulzbckA0v4JnstnO2jgf3/3Wn7tQC62v3RQjNOD0l7ohc
 zL2pB3tHXOCQFWm5wLRbfK19lZeGordmJmyTXp7WEBTS3omT1EHNzDY/qSX03CQ=

> Gesendet: Sonntag, 07=2E Juli 2024 um 21:54 Uhr
> Von: "brian m=2E carlson" <sandals@crustytoothpaste=2Enet>
> An: github@online=2Ems
> Cc: git@vger=2Ekernel=2Eorg
> Betreff: Re: linux git init/clone on Netapp NTFS security style volumes
>
> On 2024-07-06 at 19:35:30, github@online=2Ems wrote:
> > Hello,
> > =C2=A0
> > I'm trying to execute git init and git clone operations on a linux
> > client that mounts a Netapp volume with NTFS Security Style=2E Meaning
> > the client is Linux based but the filesystem is managed from Windows
> > side - especially linux chmod operations are not permitted=2E
> > =C2=A0
> > Maybe a new CLI option might be helpful to skip those chmod operations=
=2E
>=20
> I'm not surprised by this, because Windows volumes under WSL also have
> the same problem=2E  However, I don't see the behaviour you describe whe=
n
> creating a new file system with NTFS on Linux and using ntfs-3g to
> mount with default options=2E  In my case, everything works just fine=2E
>=20
> Note that I didn't try using the old non-FUSE driver because that's
> deprecated and I don't believe it's available anymore in Debian sid=2E
>=20
> What OS (including version) are you using and how are you mounting the
> file system?
> --=20
> brian m=2E carlson (they/them or he/him)
> Toronto, Ontario, CA
>=20

The feature is very specific to Netapp=2E The (Netapp) volume is mounted u=
sing NFSv4, but chmod operations are not allowed as permissions have to be =
managed using Windows=2E
Currently, OS is ubuntu 22=2E04=2E I'm confident that the distribution doe=
s not make a difference=2E

Following section of the code should be skipped for given case=2E
https://github=2Ecom/git/git/blob/master/config=2Ec#L3434-L3438

		if (chmod(get_lock_file_path(&lock), st=2Est_mode & 07777) < 0) {
			error_errno(_("chmod on %s failed"), get_lock_file_path(&lock));
			ret =3D CONFIG_NO_WRITE;
			goto out_free;
		}

I'm looking for some advice how to best skip or catch this section=2E

In addition, I came across this Netapp setting which might just ignore the=
 chmod operations without Client side failure=2E I haven't tested it yet=2E
https://kb=2Enetapp=2Ecom/on-prem/ontap/da/NAS/NAS-KBs/Can_I_set_UNIX_styl=
e_permissions_from_an_NFS_mount_on_an_NTFS_qtree


Thank You

Josef


