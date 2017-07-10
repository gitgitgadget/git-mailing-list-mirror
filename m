Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A09120357
	for <e@80x24.org>; Mon, 10 Jul 2017 14:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932355AbdGJOOZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 10:14:25 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32951 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932217AbdGJOOY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 10:14:24 -0400
Received: by mail-pf0-f178.google.com with SMTP id e7so50705684pfk.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=XtfcbrDKeI3IZBWUTONuaYJt+faNBDR4EW6JVW5/CYg=;
        b=TrfVKC9SUuriJLnM7Rnc+S2T4P8X4vl491zbCMxLrxzUgogErbDp4L0BM3vkZToblf
         bLLCz454tGe2xYow2RiZ6gaxLyoZK7otOCro9KvMGew6bx2MU2iIeDsjW1yJGRGjS4Hi
         Ni4fFVoxJB30BoFwvMMon/rvQOA3Q/+g2kFNJf3cBHvVVvPsw86h6vcM/nrJZYjk4mac
         M6KvTNTtffBhQ7h1PebOebiviBpgSAMd0KZv8WwDvClmYiEie2TgdnBQz24a0UeYqF3G
         ZLYt4bYp/vHG41IjvczNMEI0Qm+q63R/RRa/snKoZ9QrF1GqkeaRHDzEErZLsjkX243m
         hw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=XtfcbrDKeI3IZBWUTONuaYJt+faNBDR4EW6JVW5/CYg=;
        b=Qhgq4bZoSqLmaDMlpczN3dG26//yooSzRDSYOPvJCAkvhaXqeyiR5zbAbnrCGHBg7A
         PhsiJ/VxK9FYYAdmAInAoZ8w9vuC+wT23lEO1GRyDbV1S0cut1pI8ck7+gMdDOo0OAko
         eeqAJumwxEwO36e0V3MutJ7UZdPG0/xvQ+U31hCaB3TqB8UtD6em4baImmFjwyXzWaru
         0UFX8N7I2JlyopKOCPlXICphfTN4DjM3MxsmPVZb5GDwyuOfoG426AGzUf9U0dFWeQfr
         4t1DiesAmjstuuz7CnBvMUJrGDkVR1bI7/I3/QFcrJj6sntRtZykqFuPfzau2VhQEHz9
         OKHA==
X-Gm-Message-State: AIVw11043oewwA2fbKscePyRJ+l2h00mtfma85G5rz7gal0zVz7GqoVz
        5TqQayFEyBIBbQ==
X-Received: by 10.99.250.69 with SMTP id g5mr14830754pgk.11.1499696063471;
        Mon, 10 Jul 2017 07:14:23 -0700 (PDT)
Received: from unique-pc ([117.209.165.116])
        by smtp.googlemail.com with ESMTPSA id m5sm18205269pfg.22.2017.07.10.07.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jul 2017 07:14:22 -0700 (PDT)
Message-ID: <1499696071.1647.2.camel@gmail.com>
Subject: Re: "Branch exists" error while trying to rename a non-existing
 branch to an existing one
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Mon, 10 Jul 2017 19:44:31 +0530
In-Reply-To: <xmqqd1998mks.fsf@gitster.mtv.corp.google.com>
References: <1499624859.8552.9.camel@gmail.com>
         <xmqqd1998mks.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-07-09 at 11:57 -0700, Junio C Hamano wrote:
> This is borderline "meh" at least to me.  An argument against a
> hypothetical version of Git that "fixes" your issue would be that no
> matter what the source of renaming is, as long as 'master' exists,
> "branch -m" shouldn't overwrite it, and it is a good thing to remind
> the user that 'master' exists and the user meant to rename it to
> something else.
> 
I'm not against the fact of reminding the user about an existing
branch. I'm with the fact that, warn him when he really has to care
about a branch being overwritten i.e., when he tries to rename an
"existing" branch to one that refers to another existing branch.

I found this behaviour odd as I try to relate it with the 'mv' command.
It's behaviour is as follows,

    $ ls
    file  some_file
    $ mv nothing file
    mv: cannot stat 'nothing': No such file or directory

If I haven't missed anything the following patch seems to fix the
problem,

diff --git a/builtin/branch.c b/builtin/branch.c
index 48a513a84..2869aaca8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -476,7 +476,10 @@ static void rename_branch(const char *oldname, const char *newname, int force)
         */
        clobber_head_ok = !strcmp(oldname, newname);
 
-       validate_new_branchname(newname, &newref, force, clobber_head_ok);
+       if(ref_exists(oldref.buf))
+               validate_new_branchname(newname, &newref, force, clobber_head_ok);
+       else
+               die(_("Branch '%s' does not exist."), oldname);
 
        reject_rebase_or_bisect_branch(oldref.buf);


-- 
Kaartic
