Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3F5C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E2820733
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bmPn8G2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfLQSsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:48:01 -0500
Received: from mout.gmx.net ([212.227.15.19]:51687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfLQSsB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 13:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576608479;
        bh=NrKZr6wv5rTWLw2065YtkAIwo+yv325v33VoN5PFIXo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bmPn8G2XDs7iEq29zzLBx4mew5PFwZwnjMjO5yhV3OTEAu4yvelWu+AiXpFOf+jzH
         dw3eLxUqKODqUy7Mvmfrd0gYPB7JtJohaoQALZ2EcVkzUtWgzUduNr8wPoQUZl+Y7j
         SGXZFMoYI6DXyvyhNX5KOn1uuucl+XyVo7orWGYg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCb5-1iCGbv3XGb-00V6Iv; Tue, 17
 Dec 2019 19:47:58 +0100
Date:   Tue, 17 Dec 2019 19:47:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 07/15] bugreport: add curl version
In-Reply-To: <20191213004312.169753-8-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1912171946260.46@tvgsbejvaqbjf.bet>
References: <20191213004312.169753-1-emilyshaffer@google.com> <20191213004312.169753-8-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:v03fPuY+t6+imU8G9p3FeoisIJeHdmWv3CI+eQ5J6VePJVjxoTn
 Zk1kp0BOyy6jpt/TsZ87Y+Mwv6TUC9bYBwCf1TdEJyCQNCBgypu8bGQ/maJEOkkUgPwVuVw
 q/tRta4kJ585BWEHnZ5Gl67hEgIpQr1LiU4gfx6pwG66kFtaEngH5fpYrvQ+DFdquqFFxb6
 gyvCCzUmxB/Sqd+R5hKvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5MrQCJUNrAM=:dfMbGZonb0mLNW3gkCIyHD
 zi0CWWsF4VJs37xdB4Qwgs0mXeBrwbDhbiUyULwziNWFr+41CAcp7iaboX+uP1C4MjFkXxPjR
 ixAQCVh4CWb5WA8Qud4qpC6RFGUIgypvSfkdDG4bbXtUK7Vd40rRijIb7ip5XxzYPY9Jf8imJ
 /bJjoGdGd0RM06pHI29xa7IDLQDs/ZWAvt5BTW1qH6Id7GfUhkUOZwNYNgs702TIxFUGtUW0g
 M8u9YESXqGIDxeIbNl83HNBTSBWcrGXfYKP7sc35DMv/qo1oVvrXTQZtCU1Ao5q3ItVLM3vzq
 JEScmioex0S+t3oXnV1o9wY6aWtiOa7csYzy+8z24Kb3VaTQV1Mc7JKowuvlMUhWvMeyH5I8y
 nW1XGhGA/GqnGs0700y1PAaGLISBZQl4I3BT0EloYNPCathqSHHWgVexnhcmqPGAsIFQrvYw8
 JnN3w9xYtrxe2WCp9oz0NtBiE5mzldfsPc9JitEUhOChFNJ1mzQ3VzKMTSPCa6tID9fnfuvlK
 FQ0wYQ8PsgmAI73BXy3KmM+SBO7/c41EsfVtZv7y1sK4dVflOWEE6tjoOIVyR8n1ce4lnJOx0
 YgA+HN469M0Aq7aN9XBm6YPiGC1hjERp3H6QNS5f8k7L5obeTW78RTaRtM3tYyV/RvSZAg6I0
 UePyyiqgybVucvu+2UpVQGAwLEZ7LtARpJwV4WkGRMzSbB1EjXHvEfkUbjRmZGDav5AYNMLnM
 IxjmKDjN7NSZx4vBxjSji2EWCQ8iWgSMNfgr6ajIxvXv/IAB8jB1xFl/2Wp87CCVo00pjAQ5Z
 fQRPwjTyxDrJD1vM6m81Zc/okKN19ajUABUzz270llvJ0FPqEAUI0oS3zHVjJr0T1UgYp0vms
 qTjWn39n1BZsUd+MDKxzOGa0EyO0DHe24i504heGrN38RvHhykfnyvZ11yrr0Kt7isoI7egHd
 yi8R8QgDl6Y5kkfojEOAONyocDe4QV1bPYScp2SVU3QOv3VaUWm83skw0Q+RrMHmtH6l5X9Q7
 4IzWdiSNVWS9+oCSSe4DfRw6MQgVkyGcruCorUj5WTypHfWbJCMK0oTYjNkH9cCN3BCee0VdO
 SnKq0m8ULs5dUwvZ95+FCpZGAOlNBi6WNHrWDl7b2Gp4aKORR6ILhBE0l9CDhkVsjmL0OtIRq
 EBjgJ6lGmU9jeOdBt2VIYa/Kn79oXDZvJDZaXe5EvRL2C6hBSjsJlZHkE3ynHMked7XE+3HhQ
 YRpIlvu3FLfAfsS41sD8Cji30Jg0YHe4BJ77+ZPmbq+uo4i+yBNGKRNWY0Es=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 12 Dec 2019, Emily Shaffer wrote:

> diff --git a/http-fetch.c b/http-fetch.c
> index a32ac118d9..31844812a1 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -3,9 +3,18 @@
>  #include "exec-cmd.h"
>  #include "http.h"
>  #include "walker.h"
> +#include "version.h"
>
>  static const char http_fetch_usage[] =3D "git http-fetch "
> -"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
> +"[-c] [-t] [-a] [-v] [-V] [--recover] [-w ref] [--stdin] commit-id url"=
;
> +
> +void NORETURN version_info()

Pretty much all the builds in
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D23830&view=
=3Dlogs&jobId=3D253e5128-1058-5bd4-fdf1-9b556d3207f8&j=3Dfd490c07-0b22-518=
2-fac9-6d67fe1e939b&t=3Dce91d5d6-0c55-50f5-8ab9-6695c03ab102
fail because this function definition needs `(void)` instead of `()`.

Ciao,
Dscho

> +{
> +	printf("git-http-fetch version: %s\n", git_version_string);
> +	printf("built from commit: %s\n", git_built_from_commit_string);
> +	printf("curl version: %s\n", curl_version());
> +	exit(0);
> +}
>
>  int cmd_main(int argc, const char **argv)
>  {
> @@ -26,6 +35,8 @@ int cmd_main(int argc, const char **argv)
>  		} else if (argv[arg][1] =3D=3D 'a') {
>  		} else if (argv[arg][1] =3D=3D 'v') {
>  			get_verbosely =3D 1;
> +		} else if (argv[arg][1] =3D=3D 'V') {
> +			version_info();
>  		} else if (argv[arg][1] =3D=3D 'w') {
>  			write_ref =3D &argv[arg + 1];
>  			arg++;
> --
> 2.24.1.735.g03f4e72817-goog
>
>
>
