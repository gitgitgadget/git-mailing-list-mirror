From: Stefan Beller <sbeller@google.com>
Subject: Re: git fails updating submodule only if --quiet is specified
Date: Tue, 22 Mar 2016 14:43:42 -0700
Message-ID: <CAGZ79kZAMwZz3w-shT_Z3itbKQWzhW2fmUzh=-gRg0Db7gRV6Q@mail.gmail.com>
References: <3E1D841C-7665-43DB-A0F8-99999C59C28D@googlemail.com>
	<219B1DC5-8379-4FD5-8739-D99890362769@googlemail.com>
	<CAGZ79kZaV3w5TM+FPORcFOdeCY8idCYV_yB4Vt5eSNVrNomp2w@mail.gmail.com>
	<CAGZ79kb0izRAZoQaDxTjKNz0VFEBqbkCSmro2pHm_kmLpJk0mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Marcus T <maddimax@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 22:43:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiU5b-00026x-KX
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 22:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbcCVVno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 17:43:44 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35917 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbcCVVnn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 17:43:43 -0400
Received: by mail-yw0-f171.google.com with SMTP id g3so272013553ywa.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 14:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=EXx/7wPVGyizjPa92g6p7FjspoIzFwxajF5VSgarebk=;
        b=S3GL6M8kupJS1j1cjhFalnd7ZFBQhA2n/gvAoSlYD2/NzE936JL8w7BbtlpQmShX9Y
         mCp92UJSZRgbBb+Drj8B+NfcRVcRl9NmPEU1AC9uIZzjA/8YDWjc6dOKyT/QRRspj1Bw
         NVJI/bniNzZEs0oWCgPwtFNNJOz8naMZiGndLv5vtfVHBG1dPpDLxaXuK4nT4uEg/dEQ
         4gNHUc2bOEhZnAqsj4O0RJfWrTXNRSuKQc91FrxV7giUlkbYS6IPSXIXNL4dkRXppPiM
         wJiNLro8AxHdXpOYTX5sQlektASXFdGdvZkPQP+SRE3UD/rurBsurCRyFDDuNYxD3Sc6
         KkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=EXx/7wPVGyizjPa92g6p7FjspoIzFwxajF5VSgarebk=;
        b=LirvzFvaHK8OVdvMTBlB6u8T9LmCMLWPWrJhWLlZsy7kKoBho9pBxtEeXivUOkcRjD
         er6ESaGc8cEp80dwIB1Pw5IujdOCLk/8PJLLBqAOQofqrtgVfZfT63U8nVR2huG67TvF
         GAHOXVlKcaBNCfjxENHjuzdApBsfAYkKzhehyeO01zt87m2qxDgMx+hKYJvuVv/f8WVP
         l/0TmJcgz+yI6K+0uJTMDuh1AO0QkeTdCWySpYL6hFgBPnRkkWmxVQsJrQGahdetsJnt
         UtSvfIQKG7K2/oMgBwghgikxagKn686NSZ9L7XT98ysx3mByGHEC9Ch/V8goxzMKklFC
         Xmqg==
X-Gm-Message-State: AD7BkJKXTOnnMfIZHcjh5zUwQHGPsAXkYJ46xqHuB0EHAaebhslXYLO1sS1gNdDM4z/sUdhwz3C4EQEbjNQidlnx
X-Received: by 10.37.19.66 with SMTP id 63mr19193947ybt.75.1458683022166; Tue,
 22 Mar 2016 14:43:42 -0700 (PDT)
Received: by 10.37.51.137 with HTTP; Tue, 22 Mar 2016 14:43:42 -0700 (PDT)
In-Reply-To: <CAGZ79kb0izRAZoQaDxTjKNz0VFEBqbkCSmro2pHm_kmLpJk0mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289570>

On Tue, Mar 22, 2016 at 2:38 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Mar 22, 2016 at 11:22 AM, Stefan Beller <sbeller@google.com> wrote:
>> However lookingat your logs, I would suspect it is an error in git
>> clone instead, as that is the
>> last command which has the --quiet flag passed through the stack.
>
> git clone --no-checkout --quiet --separate-git-dir tmp_gitdir
> git://git.busybox.net/buildroot tmp_workdir
> fails as a standalone program as well, so let's debug that.

GIT_TRACE_PACKET=2 git clone --quiet --no-checkout --separate-git-dir
tmp_gitdir git://git.busybox.net/buildroot tmp_workdir

14:40:17.369362 pkt-line.c:80           packet:        clone>
git-upload-pack /buildroot\0host=git.busybox.net\0
14:40:17.405792 pkt-line.c:80           packet:        clone<
7e4dab488594021b012b1ef3b49772eece97b760 HEAD\0multi_ack thin-pack
side-band side-band-64k ofs-delta shallow no-progress include-tag
multi_ack_detailed symref=HEAD:refs/heads/master agent=git/2.7.3
14:40:17.406765 pkt-line.c:80           packet:        clone<
1264adda0ec0ec5edaff5e372b97972cee6ae33c refs/heads/2012.11.x
14:40:17.406799 pkt-line.c:80           packet:        clone<
8ab57bf9338f3a47683294aed6425f39828cbf80 refs/heads/2013.08.x
14:40:17.406813 pkt-line.c:80           packet:        clone<
e009e7d8615eec10d2c0c2676ef5a276f0a6a5e2 refs/heads/2015.08.x
14:40:17.406826 pkt-line.c:80           packet:        clone<
9f0610c188007ee481508d453b062d77614c153d refs/heads/2015.11.x
14:40:17.406838 pkt-line.c:80           packet:        clone<
7e4dab488594021b012b1ef3b49772eece97b760 refs/heads/master
14:40:17.406851 pkt-line.c:80           packet:        clone<
2dfabd10d1e484d84c0e6b5a58ab43d131ca3230 refs/heads/next
14:40:17.406863 pkt-line.c:80           packet:        clone<
72169f4a90a86b613a0d2be6217ccda5abf0b956 refs/tags/0_0
14:40:17.406876 pkt-line.c:80           packet:        clone<
ffde94bd2ca21542ae0b4518348f8e986b9d92e0 refs/tags/0_0^{}
... lots of ref advertisement...
14:40:17.432352 pkt-line.c:80           packet:        clone<
ac0194b3d63f07bd7379f1f7ddfc2bbc69ab3272 refs/tags/2016.02-rc3
14:40:17.432356 pkt-line.c:80           packet:        clone<
100ba0f6d6b8020dd4d3ea8ffbfc7f1f3219a650 refs/tags/2016.02-rc3^{}
14:40:17.432360 pkt-line.c:80           packet:        clone<
09d8764e8ce7d00c3f2028e65187f5ff31155583 refs/tags/gcc3_legacy
14:40:17.432365 pkt-line.c:80           packet:        clone<
961229caf56a6a3e3bc9fd58805d8e83dd6a84ae refs/tags/gcc3_legacy^{}
14:40:17.432369 pkt-line.c:80           packet:        clone< 0000
14:40:17.436239 pkt-line.c:80           packet:        clone> want
7e4dab488594021b012b1ef3b49772eece97b760 multi_ack_detailed
side-band-64k thin-pack no-progress ofs-delta
agent=git/2.7.4.1.g33fcf9d
14:40:17.436258 pkt-line.c:80           packet:        clone> want
1264adda0ec0ec5edaff5e372b97972cee6ae33c
14:40:17.436268 pkt-line.c:80           packet:        clone> want
8ab57bf9338f3a47683294aed6425f39828cbf80
14:40:17.436277 pkt-line.c:80           packet:        clone> want
e009e7d8615eec10d2c0c2676ef5a276f0a6a5e2
...lots of wants...
14:40:17.437114 pkt-line.c:80           packet:        clone> want
4a5e4d74cbd91a4d9a166d38a90b5c444722cc92
14:40:17.437121 pkt-line.c:80           packet:        clone> want
2977653121ad046e8a229f22552d3ce547bfb511
14:40:17.437128 pkt-line.c:80           packet:        clone> want
834f73774a296a178b1ee550752abaa5dfcde29a
14:40:17.437135 pkt-line.c:80           packet:        clone> want
44eca8025060071a410e18df6eba446821ad9a5a
14:40:17.437143 pkt-line.c:80           packet:        clone> want
ac0194b3d63f07bd7379f1f7ddfc2bbc69ab3272
14:40:17.437150 pkt-line.c:80           packet:        clone> want
09d8764e8ce7d00c3f2028e65187f5ff31155583
14:40:17.437156 pkt-line.c:80           packet:        clone> 0000
14:40:17.437387 pkt-line.c:80           packet:        clone> done
14:40:17.488562 pkt-line.c:80           packet:        clone< NAK
fatal: The remote end hung up unexpectedly
fatal: early EOF
fatal: index-pack failed

When not giving --quiet, you'll see the client ask not for no-progress
capability in the first want line.
