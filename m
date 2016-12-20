Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C4B1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 16:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755843AbcLTQxy (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 11:53:54 -0500
Received: from mout.gmx.net ([212.227.15.15]:53809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755520AbcLTQxx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 11:53:53 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPV69-1cEiy21r5F-004g7a; Tue, 20
 Dec 2016 17:53:47 +0100
Date:   Tue, 20 Dec 2016 17:53:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] winansi_isatty(): fix when Git is used from CMD
In-Reply-To: <d661dbf1-9852-965a-2ca9-67d763115b9e@kdbg.org>
Message-ID: <alpine.DEB.2.20.1612201751060.54750@virtualbox>
References: <cover.1481454992.git.johannes.schindelin@gmx.de> <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de> <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org> <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
 <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org> <ffc6a7a0-4ae4-b755-0b09-5bcd7114a2e6@kdbg.org> <d661dbf1-9852-965a-2ca9-67d763115b9e@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:J3f9nSGAKlB6v2VoZ/2YNQyZJmoDZGmOTivUF2iAZ5N53VkQUqw
 lKtgCGfSPG77SYHaQ8UZFbHZMc9YaEDp2N0hOHkZ8sMy+Pix6BbkSrZreDYdLzInWeZjPR+
 uhfLtkYL4ofYKGOa3sxGIsPT/nNN6z4AgUrkEEVTirdi1daB2Iw8ptLmZAulDYT6f10zwHQ
 PPOh7bhvrKdaAulXdN23A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xN97pm6LK7g=:Ku1oaJugcV1bANrRAO3pK2
 5eDXAfagl1iq2fvdPA7x6U0Ux3m7ngbXPEOhtkPscmY22R99DkiNj9kZCOFTS9cKS3R10e798
 q05elB2udyU7fxws86+7o5qyQpXQUHmMX5itQBwyXk/z6s/Ss4lXdQQ8B8T7bT0PoHQfssKQ0
 vJ4URxTlMI1QhQZ++qPIVSdN6ShKkz5kFFhy/caGCOsQl99xQYKTBUeyHeFc0gA00OjRdY2pA
 LvMeLS1RN0JwHb2qPHOXctDl7DkG9tu3SO6E7w3Pm2EW4upJiI766KGKfYNeHQ2zZb/GmfWEf
 C5i4ctn6y/f4WJtSe/iD1nUfULqs+itnZ93dsjpBCEpCGMcIkKQqaK/fBrq6DPpPBxbdQzbse
 G0VPeFMfVXh36o0OUHHtzaRG5BbJ8CfI1HHFmyJeTh89upf4CiZxaoQezOfAf2Von+GbyeeYO
 Lao9uVuMgZ+Q+BO2yHKenmx1jvIQmb58WVoM8wFSd8kWLz2CpWlH8VNx7a0cDJa20CLmnga4H
 Z9i4Bq8ZUVCT3d+Oy9IEgdyE85Hc7WMfWIp9Et5Jk2hnk0FGDAWtflcwVC5cx0uyQviypCtIt
 aScyS7vOTua8sssFLWyosBx6aFQrdjFECKiAFZZDuU7mgKjGOHV95Lrzsoa5Uf6Gy8WLJXcI1
 vsNQ24MQJfobl5VLehsoWTYFZZpOEJQywIvDuPfizdWc5LE1GV8IRXVA+mqiia8veokJ2BPXq
 M47xDZymxI9xyHoitGt3Gv+gR0cfpC0IPyJwhvm6ui8SwXMp48FQ5JqSHeZ9EvJ1hSXKSdGfx
 l4DTaQe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Sun, 18 Dec 2016, Johannes Sixt wrote:

> What do you think?
> 
> diff --git a/compat/winansi.c b/compat/winansi.c
> index ba360be69b..1748d17777 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -575,9 +575,8 @@ static void detect_msys_tty(int fd)
>  
>  int winansi_isatty(int fd)
>  {
> -	int res = isatty(fd);
> -
> -	if (res) {
> +	switch (fd) {
> +	case 0:
>  		/*
>  		 * Make sure that /dev/null is not fooling Git into believing
>  		 * that we are connected to a terminal, as "_isatty() returns a
> @@ -586,21 +585,19 @@ int winansi_isatty(int fd)
>  		 *
>  		 * https://msdn.microsoft.com/en-us/library/f4s0ddew.aspx
>  		 */
> -		HANDLE handle = winansi_get_osfhandle(fd);
> -		if (fd == STDIN_FILENO) {
> +		{
> +			HANDLE handle = (HANDLE)_get_osfhandle(fd);
>  			DWORD dummy;
>  
> -			if (!GetConsoleMode(handle, &dummy))
> -				res = 0;
> -		} else if (fd == STDOUT_FILENO || fd == STDERR_FILENO) {
> -			CONSOLE_SCREEN_BUFFER_INFO dummy;
> -
> -			if (!GetConsoleScreenBufferInfo(handle, &dummy))
> -				res = 0;
> +			return !!GetConsoleMode(handle, &dummy);
>  		}
> +	case 1:
> +		return !!hconsole1;
> +	case 2:
> +		return !!hconsole2;
>  	}
>  
> -	return res;
> +	return isatty(fd);
>  }
>  
>  void winansi_init(void)

I think that would break running Git in Git Bash (i.e. MinTTY) ;-)

Let me try to come up with a patch series starting from your patch. We
need

- to abandon the _pioinfo hack

- to make isatty() work correctly with /dev/null

- to make isatty() work correctly in CMD

- to make isatty() work correctly in MinTTY (i.e. with MSYS2 pipes instead
  of Consoles)

I think we can have it all.

Ciao,
Dscho
