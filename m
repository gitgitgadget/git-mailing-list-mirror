Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OzaJ57wq"
Received: from sonic306-20.consmr.mail.ne1.yahoo.com (sonic306-20.consmr.mail.ne1.yahoo.com [66.163.189.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC13FC
	for <git@vger.kernel.org>; Sun, 26 Nov 2023 04:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701000484; bh=9oLIMmJY+W2w/uETEGUqnFHbjl4tLJoWb/FdEftqh0M=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=OzaJ57wqi+Ddh3NdCbJzqpHsH4VvKlIXC/tl1wmM9It/w+aU75laRYrnj0aV3b+uI0h1yFbSVUPUA5n3Cx8w7vQmLWZR3rZ4GTH7m6DGk4y8A4s5pee9yyGP1MmVvjOu9LzwCf6A8UVLt+FUo+FMO8BDxprgP4YkHpRuQIT+EGai71Hb2+rQSv/MsF5uCq42N+dB6G7EYya8WZ5WaHSxJQ4QK5LTcC4S0rMVvnOFjDrT60Es3P9p5kqalz9nZCtjqMTMDhYdCMz8Oz4aMawN1Tq/Qs2i0q+8MmV/Li5B1HvrvdxzVKAhUgFQBbYDLlLT/tJNh2cqOnM2hx5to9L/UQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701000484; bh=823N5cC4VR4KhdI/HixF1YWw1DKUmL1z4L86BzlWWg3=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=Mqo9weSy8dQhnMZeF/03p/FNfSk723FUaorO304nYOISaD/6X4LvqdQDKV5LpV9+7qkiIVZKgElO3DDT+qj8JkzkzPsddCGaUtOCcNJ8Bhvsb6XvNVEB4GsFdzJP325K8BJwrohVJ5eK/fNfY7TX9+SeJdochxlqK/vpOdmy3jkeW+2ywpMQAuCAFHGtz7m588WkfK4c6Gz+w66h8jV5tLMUHENAQUMpoO9HFBQRaiQD1J0yHzud6ipjx+ZW3ATa3lb0hMwrlRUtFH4MgcT2Yiuy4bry9b8vbM9e0Kz3hHTgiP1UOtpaTDmBFjEz9lZOnpx+1ep2midi7mBBCB1CGg==
X-YMail-OSG: B.t_7VIVM1l21S2qfvlC6PwFG.85YuQAArduG3tZ_jvMj8Paz9uU8pz3EQRRNhg
 xDOvxycr2eMNddQgNnvZD2vOr7eYxcbCD9zSsjaXszlUqFB3DwxXwhxdis2dm9XmnVjnO3xdcpJS
 ezDVQjVOf1Xbj8IinUh7ftTA4Ba0CWv74RPN_Ht6QlmM6RdeKh.MFA6rWQ3GQolVGEQD3MrXn5rC
 NoYdo4sTExbHLfL6m67OyQASX9lgowDmdbtVwHhPn8i05WFPOiehTtf1VBtONlmCTGSyvrghUbhq
 htZXosDyNgpFeLGXCGvUlPMWKRkPFNezgauCg1EZybvfISUlITSdX.hYf4PHLKn21f5s6H0Fh8MB
 _yrywXNfeXrfpobRTD_WrwyFE3L_m7oO8QhaHzur0pAJCD9BwtkXMz60i3XHHrEceuGxnPX4VD.b
 8mflQijW1xEWbWqoOpACq6buZ9qDFYWKugOfgMurtX30T6rBGow3N8OXKhY17lHlG0t0uO8TFIHH
 0sCj4DZE3q3mRnUypae0Xfr5KI4ma4LzdR6ShAOuhJP1vLfIznviBHvPWpb7lH97_A0xFTlMbjum
 F5BmesQ0Ikt__0.cpnHcn0VG80oUViqUyAZRjEBr0.diZ9ip4tV3LAYNAeorGKpVmM1LRakrdVtF
 52rrQvK1bWerYZ.ykqy9xp.VAX1tJfSFZAASEZAprsOkNVg6zwr5mDlEWm5BlpKepLk6iO2u4Z3.
 rZY5DIdewX3b6qRLJTpv_bB.wk_st.5CZO7or.EsnbAAZra3TQRwl4bCg_VL4ifabQBDCB8wj140
 R32gyPTwVHAhWB_n0Zk6jqJ9CG4.lkqPvNLy5lvP6QAmmHTa0gyWuTO5gyF0qcDlRnch4kwh.CRW
 XSUJxriCF3adTVLNxcGGHoNcunttrBjZaiBi30amC51KpymzaKP8RKVldVERP8J5hQ8mlilVky.3
 i6brILJDki0qEZi3qtjhHab_blAa032Wq7OBdT9q87dzGaqMzqhv6ELjBpeLBWMXIGp7OUI5xD4D
 vEnhm.I8rH4lqYQaxpJIkbtYZC6VDQ08WwvS2g.58Y2LC.vpUUjnz20pW3NocK1Av1sKkRP067Mq
 vqR0zNFCAIddcOSbFPh7fud1GSD.9cqPI0xAtHiS4IA8nJNvy7nK8KMpoQzY409JD_pOFjNX4iSK
 yI13tzdMQFiqPah_Ip4oZyWWDKnH6m8rOSoYYyuh9zgVgw_qjcW7Jfs.yNUyx77bBbYTpmBHfmGW
 OVhCguHo.gkMVhCHP7lxWXWNri1SqExYEzlKSnGCkgIcplOsfEDUSQIeKPmkMPB0sZbbhmcxq8_F
 EHaagR_V4F9LzroOVgob6Hv6j8OOdhRtzfAQ2ElOqwSPHYiIIPZzoGf5qbYZa2MsjCsPCn7I6BhF
 SyTYS4YSbvnpHdTgMt70brxiZjOONpExQ9RICZEzIFW6PGYZELNqzuHGB10A3tWQwdC6N.zpbVYl
 nyMWJWnJE8li4ZPApx7AZs6Z_LP5oMtAOJ.mgNWtXFlEWjG6Xcmxr7sLcRUEyHjPeLOnT6Dh5Bse
 hm5FCcMvYRplKN4tRw5et1TiqoapOhuQT_n4h1xUyVDXy1.oudOC4RwGpky2ksK48tpdIskCUV3c
 .og.W41hu_Zg.Ygqc6g9hRWFABjQdxIWSO_GAI9ZrNGQRlTV9bUr9.VAD2T4DFNip9lcOrfiWHom
 sZw7QoONFGEH7JJT_oyFcp9HkdR0_matbMnZYr7as6cKfFndwmNjXHWp.olLJ.cN6VlD0jm95A2I
 ZMF7Mfb0UjKKmuL3YK0uang2uKQdYKhCnf6JGftUZQ6Y9UAQFa6ySmpQhAmZS2X9uch72knoW87Y
 YcZ3skfyij_6WT7mSxBWNKpNoD.zLhGZDgj6Prj_Pr5kzlInieM3aEvTFTi31DXx4Mi6kGDE4KUb
 s7W8Y7Dh_60A1vFC4w990iJrjOLvHcqUArtZx5HwNdjeuCmQxQ2j9FUAyZnAYX._rcV5MnDPARGi
 q.iKFwn.mXDngfVgtGZmaUcjyJaOTpOK9MjWvGaHnSGI0NfJtv5zPEyPi_7JbMfmUzFKBuAE_L__
 kxbjL3TiP9fvCbLQ0ied3xcmHM2Yaqi9eFM_sARkEAjId4pGX.0PSwUZOx5yMjL_l
X-Sonic-MF: <qa23d-git@yahoo.com>
X-Sonic-ID: 658ebd94-403c-4b05-aaca-bd6c2001c84d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sun, 26 Nov 2023 12:08:04 +0000
Date: Sun, 26 Nov 2023 12:08:01 +0000 (UTC)
From: Vovodroid <qa23d-git@yahoo.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <511253473.8084883.1701000481697@mail.yahoo.com>
Subject: No automatic continue of rebasing with rerere
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <511253473.8084883.1701000481697.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.21896 YMailNorrin

Hi,

when running non-interactive rebasing (i.e. no -i option) with rerere turne=
d on, already resolved conflicts and recorded conflicts causing Git to retu=
rn exit code 1, as if error occurred.

Also "git.exe rebase --continue" still opens log editor unless GIT_EDITOR e=
nvironment variable is set to true.

Such behavior causes to user to perform a lot of unnecessary Git runs, or c=
licking if some GUI shell,=C2=A0like in GitExtension, is used.

See https://github.com/gitextensions/gitextensions/issues/11382 for discuss=
ion and screenshots.

Regards.
