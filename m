From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/4] Submodule Groups
Date: Thu, 21 Jan 2016 13:56:16 -0800
Message-ID: <CAGZ79ka+LZHRjVB8bZ4u+-n-U06mUWsbx9nRVCvd4aPwrb7yHQ@mail.gmail.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<56A14AD4.6040608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 22:56:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMNDK-0003WM-54
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 22:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbcAUV4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 16:56:18 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36056 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbcAUV4R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2016 16:56:17 -0500
Received: by mail-ig0-f172.google.com with SMTP id z14so135994829igp.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 13:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=o6WVTNdKqcBRGax5SaRl6Gy37vrbxa0W6+hTQxxDmdQ=;
        b=XkVU5nl1kvzaDl1YTtUdifOsA98eC31IEA6cpLfARxSZ1biVCijzWpKlbazbrvvt62
         BoEy6ERYXzI75ZopMYsWNNYA/rGzBUWCvh6ocoK/zIoafxFeIES0gRaSeE/jqkQFzVkf
         LAIVho/tRHN4skm7frkTBwWUuG0/cHpU0/IldqJzepk2p9OZmWPThrgUOvtCmWVIuazB
         2ilFEsyyGP/V/fi6ZP9ENi+bNKizS1UrOKTQIulDTMWbkd9iy37k3NU/oBsCiglUnalX
         u0I4eAdqLBirWrj7xw+TZoPLdt5bLalfvWgmLxT8F5cca9B34x5/cjw1zS60+cZwbb5W
         L8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=o6WVTNdKqcBRGax5SaRl6Gy37vrbxa0W6+hTQxxDmdQ=;
        b=l4MZsUXhnn+NMhGSMrVeham+dWo670Lm+FLwLyXqZOTm7CenwCHwNL777H3D3CYpJL
         zY18SH16fQw1Q3dt8lKzBsD7+gLAO3r83fUyvajNAubM6mEnzSZz5A6urJEYrf35HEPl
         b7kH8/xqZULYe1N6+iE7gtso/fyjwpXnRDq6ENYYyxyGSarjp9LP5ZPGaQEvxfRBgTqR
         FaKUeWVDAok4t32cjgYhW6oiQV7Rqz00qMmJAES/6XM87faRDlbZYTpeewSlZ+2E+Tdp
         17DJgN7/hkioYmR1dGhjks2G/YktN8teDVO1ui9hmVjWcxYIR4v/C0jN4BmI0yDiTi6c
         TQpQ==
X-Gm-Message-State: AG10YOT2taWGHadKnIVc39sYcLDacK6WLaJCedIGJvzHP0YRmVIDfbBHPX6aKI2sSD9bwyoDA+LTLztGNwDY2I08
X-Received: by 10.50.59.147 with SMTP id z19mr524538igq.93.1453413376583; Thu,
 21 Jan 2016 13:56:16 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Thu, 21 Jan 2016 13:56:16 -0800 (PST)
In-Reply-To: <56A14AD4.6040608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284532>

On Thu, Jan 21, 2016 at 1:17 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On 20.01.2016 04:34, Stefan Beller wrote:
>
>> So you could have a .gitmodules file such as:
>>
>> [submodule "gcc"]
>>          path = gcc
>>          url = git://...
>>          groups = default
>>          groups = devel
>
> On the quick I was unable to find the rationale why entries are now stored as separated lines compared to v1. I liked the comma-separated approach better as it's more compact.

IIUC the line oriented way is preferred as it is our standard. Do we
have any other options stored as a comma separated list?

>
> Anyway, if it's only one group per line, I'd find it more fitting to call the entry "group" instead of "groups" as it will always refer to a single group only. Also that would better match the "--group" command line option naming for "submodule add".

Makes sense to use singular then. However per discussion with Junio in
[PATCH 3/4] submodule update: Initialize all group-selected submodules
by default, we want to not name it "group", as it's unclear what a group is
supposed to mean. What does a group do? which operations are supported?

So for git clone, we'd rather use "--init-submodule" which can be passed a
name, path or group.

For storing that selection we'd go with "submodule.autoInitialize" in
.git /config.

The third user visible place submodule.$NAME.group however can stay in that
variable name as to point out the the concept of a submodule set/collection.
The groups concept may be used in the future for more than initialzing
submodules.

Instead of having a submodule -> set assignment, we could do it the
other way round:

     [submodule "gcc"]
         ...

     [submodule-set "default"]
        submodule = gcc
        submodule = foo
        submodule = by/path/*

This may be more handy from our perspective (while designing it and
writing the code),
but I'd assume this is less useful for the user. How often does a user ask:
"How many/Which submodules are in $GROUP" as opposed to "What about
submodule foo,
is that part of group $GROUP?"

>
> However, if I'd read the single line "group = default" in a .gitmodules file, it wouldn't be immediately clear to me that "group" can appear multiple times per submodule. "groups = default" would me more hinting is this regard because the plural is used, but without reading the docs I'd assume multiple groups would be specified like "groups = default,devel".
>
> Long story short, my personal favorite still would be
>
> [submodule "gcc"]
>          groups = default,devel
>
> followed by
>
> [submodule "gcc"]
>          group = default
>          group = devel

As asked above, how many comma separated things do we have in git configs?
I'd really not want to add more mental complexity to Git. As far as I
remember we have
rather double configs than one long line separated somehow.
(The only thing that comes to mind is multiple remote urls for pushing)

Thanks,
Stefan

>
> --
> Sebastian Schuberth
