From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/WIP v2 03/14] read-cache: connect to file watcher
Date: Fri, 17 Jan 2014 23:21:24 +0700
Message-ID: <CACsJy8DHDd6AFF3tiEgs+TcVdcB4GZQQ2rgMTB-bU+wdKFH0yQ@mail.gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com> <1389952060-12297-4-git-send-email-pclouds@gmail.com>
 <52D94B2D.2@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <tr@thomasrast.ch>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 17 17:22:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4CBI-0003e4-R6
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 17:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbaAQQWA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 11:22:00 -0500
Received: from mail-qe0-f48.google.com ([209.85.128.48]:62549 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbaAQQV4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jan 2014 11:21:56 -0500
Received: by mail-qe0-f48.google.com with SMTP id ne12so2252809qeb.7
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 08:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Yt+TvxRYG2AbKcYsaS7t+kTfUo0sbnFMQxyhIsekxIw=;
        b=Ug7bKcyygNN50cujANqTKsxQUWz4kNWtYTOJ1nIbNBR40hFZmIGV6NFShSFgr7uulf
         c907QHgcMX4v3O4dKEwvlBFliGAoGTJSEjW9mdoNR215AZBgZyGaPn1+5z5gaRjXjMww
         P5VYttDwQvlXKvPyzU7cQ1nDQhCpqBpNFrt3vraJGcBp0G65tLK8ux7/ATJbgZS8cuSq
         Y+AyFE50geFkxCDhh4kkX+PfeEaJRRrJ/ghKpTecNfLr9pBCdjb57XjOFaW1/ZmDpoIG
         GhXs0RikSRNnx3u60M5DwWfyUoRR4mjYp7Ov+J6CGR/dIvGuWXd0rohco7nPmfazAd3+
         tkEA==
X-Received: by 10.224.167.84 with SMTP id p20mr4761343qay.24.1389975714292;
 Fri, 17 Jan 2014 08:21:54 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Fri, 17 Jan 2014 08:21:24 -0800 (PST)
In-Reply-To: <52D94B2D.2@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240601>

On Fri, Jan 17, 2014 at 10:24 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 2014-01-17 10.47, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> [snip[
>> diff --git a/file-watcher-lib.c b/file-watcher-lib.c
>
>
>> +int connect_watcher(const char *path)
> Could it be worth to check if we can use some code from unix-socket.c=
 ?
>
> Especially important could be that unix_sockaddr_init() wotks around =
a problem
> when "long" path names are used.
>

Thanks! I did not even know about unix-socket.c. Well, I never paid
attention to credential-cache.c :(
--=20
Duy
