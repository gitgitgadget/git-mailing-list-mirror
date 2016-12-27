Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C6B200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 18:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755875AbcL0Sxy (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 13:53:54 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33078 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755550AbcL0Sxv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 13:53:51 -0500
Received: by mail-qt0-f177.google.com with SMTP id p16so331019725qta.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 10:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qqn9bmi/rGynffpVJXdlOyWS4VcSk/Gb9HUvxhtQJEo=;
        b=eZpqbeIvy5H2tEvUug9xVyjXMT+C0SpDeroBvSZPY3dshoKc01mwCH2ahtF/87RpBk
         gnIV5+W8J/rDsZOQ2/TdZP3v+uhc+zQswMK0usgH/OvMXCNjv1nwdblcdY0RgB5/Ps06
         yp9bMlNaw6hA3yb6ffRS1VBRcwIt7nNJT2wwzSJrMmXtKCHc6/nI4B5hHG2y3i7zmf5r
         DDijCDWv2y8WHqkqHKhTY7ovTBJDHwXvxk7KOng312ljuLF7U+eZvZQwyRvX8NRg8FiB
         O7AespDNJpROzIqs231/bbzBEMHqAG0/BokjcGwOdl7bUYT47k+bqHnI97OirGcOMrFE
         fNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qqn9bmi/rGynffpVJXdlOyWS4VcSk/Gb9HUvxhtQJEo=;
        b=hUy+D/pFj8WBdesDk2P3hu7tDUqj6lyXOWYpTn1OuX557xkrKpXjj+cZ/qg54ywb2v
         MeLcG2I1ul8bQpn8CRxz78fXDXgBk+8a5Y71m1WimzMBtEZzSyKbXqRSEawTjXpGeosw
         myAvT83dm4Ox8B4pAci1GITu8xmy3euUbikD9zZTwURijpWZOZdqq7OcEAGOUQuM53lV
         TTE096ZV5+itpg//lw/e5Z08noAlnK4Ps6lulZvJHGp2bLDjd0pGN8MX7Kf13q+U7qaf
         pVLZQpxYrp8W1jvOAgZHlcqyD1xQweR62HLuN8W3IXMZFOboEXt40sDHAqyK6KCx1aeQ
         7C3w==
X-Gm-Message-State: AIkVDXI3XzV8MiVkppvXdULv0/Ho0plP4m7M6VVY/GubaQTlgj7rWgxs4JvYBbjrASgXOXHLV4Wz0fwJN7jO2Sqo
X-Received: by 10.237.34.206 with SMTP id q14mr29805868qtc.101.1482864358546;
 Tue, 27 Dec 2016 10:45:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Tue, 27 Dec 2016 10:45:58 -0800 (PST)
In-Reply-To: <20161227082922.8B7A813893D@mail.altsci.com>
References: <20161227082922.8B7A813893D@mail.altsci.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Dec 2016 10:45:58 -0800
Message-ID: <CAGZ79kbOjpi4SBLPVaKXJ+L8VN+0N=ZqgDcHeYydkKsS20yR1Q@mail.gmail.com>
Subject: Re: Gitview Shell Injection Vulnerability
To:     Javantea <jvoss@altsci.com>, Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, aneesh.kumar@gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc the author of gitview

On Tue, Dec 27, 2016 at 12:29 AM, Javantea <jvoss@altsci.com> wrote:
> I have found a shell injection vulnerability in contrib/gitview/gitview.
>
> Gitview Shell Injection Vulnerability
>
> Versions affected: 8cb711c8a5-1d1bdafd64 (<=3D2.11.0)
>
> Gitview executes shell commands using string concatenation with user supp=
lied data, filenames and branch names. Running Gitview and interacting with=
 the user interface with a malicious filename or branch name in the current=
 repository results in malicious commands being executed as the current use=
r.
>
> AnnotateWindow.add_file_data(self, filename, commit_sha1, line_num):
>     fp =3D os.popen("git cat-file blob " + commit_sha1 +":"+filename)
>
> AnnotateWindow.annotate(self, filename, commit_sha1, line_num):
>     fp =3D os.popen("git ls-tree "+ commit_sha1 + " -- " + filename)
>     fp =3D os.popen("git blame --incremental -C -C -- " + filename + " " =
+ commit_sha1)
>
> GitView.set_branch(self, args):
>     fp =3D os.popen("git rev-parse --sq --default HEAD " + list_to_string=
(args, 1))
>     fp =3D os.popen("git rev-list  --header --topo-order --parents " + gi=
t_rev_list_cmd)
>
> The program also has other uses of os.popen but none use values that the =
user can manipulate. However, the fix should definitely replace these insta=
nces so that the code might one day pass pylint and manual code review easi=
er.
>
> The function os.popen has been replaced by safer functions in the subproc=
ess module. The code can be improved easily because it requires very little=
 change to convert the code to work with arrays of strings instead of strin=
gs.
>
> If you have any questions or would like a patch, please let me know.
>

I guess you could send a patch to fix it. It is unclear to me
how the patch submission process for these work, though.
Please see contrib/README to see why it is unclear to me.

> I expect that things that start their life in the contrib/ area
> to graduate out of contrib/ once they mature, either by becoming
> projects on their own, or moving to the toplevel directory.  On
> the other hand, I expect I'll be proposing removal of disused
> and inactive ones from time to time.

Maybe it's time for a spring cleanup and remove some old (dead?)
projects from contrib?

Thanks,
Stefan
