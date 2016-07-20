Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6DA2034E
	for <e@80x24.org>; Wed, 20 Jul 2016 21:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbcGTVvO (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 17:51:14 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35619 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbcGTVvN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2016 17:51:13 -0400
Received: by mail-wm0-f52.google.com with SMTP id f65so762468wmi.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 14:51:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lvobrM0tguJcpU1o0xLtMoqBNobjJkmf1H5fpTiIQt8=;
        b=diEzYaUS6zqqHIGuhrAhdoIdumziPYP0+5CElGy2vxsDKbQQxYA/SN4b3oTgRXZZVl
         bA93eksXskI8RLeytVzFJWU7KF+aTaGcj9NZtjsRQUp5X4F1oaPFpzWTLhIzibubZXXf
         HW29htoYfKVJVoaOzY53jim+Zsq/8WdL1z1/DdQ4qFmrxmU//J5wo4lcin9/Py1Mh8UF
         kCXZyxTENhGIWWly2fnl6xwfwTlrX6gmngRiHHTv3ylCG7+vk+seVZN4lyYlF17UumRN
         k6RbzFsJSXNwW2jFStcuN1WlsNVt5VPSEU6QConJC6PhYFLA+n0oX7PEKLvLYJYPZeXG
         RpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lvobrM0tguJcpU1o0xLtMoqBNobjJkmf1H5fpTiIQt8=;
        b=gr2Rt2ATGePtJDBaZDDjZqNAR4P5WrG1sadPwQMn+mAXDA/FsOALDzYZaRvlTDGdsy
         zVbNpGJ0Q+G77VoyUgKETD39Vw04B0vIrieEAa9d19yxfrnd2YqVudm2ZnNX4ar7GDef
         BMGZu+6jTFfuiWhGKqSsIXMkRvtnqBRH8KqBwr2ACjLcBRPmOLX/j9+xavjX9ExOz+b7
         yhT/s1hB60ctTrt97dj3+BE2fqNTkCrjWz2eDpTt0klG18iBXEWP+aCg29gzMN+y/GrB
         4vbjx4pAEQSc9q+QscdzWoMaffOzyweMSX4bXWfi2Pg0QvDr/tAbFocBLWitDU7nlL14
         t8Rg==
X-Gm-Message-State: ALyK8tIKJQdj3I0p8rTCEIU790MIIZSn/NBu8uq7WThCOLavUPT2tm4hAsYtURtxMVvHQINlAOHwaUHMDlWjlw==
X-Received: by 10.194.99.11 with SMTP id em11mr3431057wjb.8.1469051471589;
 Wed, 20 Jul 2016 14:51:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.102.70 with HTTP; Wed, 20 Jul 2016 14:50:31 -0700 (PDT)
In-Reply-To: <42f9c384-489d-3fce-2b27-8884e683a3d5@us.thalesgroup.com>
References: <225e6ff4-178c-cd2a-6a05-b621f0ad4a84@us.thalesgroup.com>
 <578FEB1E.5060302@gmail.com> <42f9c384-489d-3fce-2b27-8884e683a3d5@us.thalesgroup.com>
From:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:	Wed, 20 Jul 2016 23:50:31 +0200
Message-ID: <CANQwDwe4OvNx+3uOG6Qbzj1CKK+N-pvTyk_j2WxDs-R2LPv3YQ@mail.gmail.com>
Subject: Re: Complex gitweb URL
To:	CLOSE Dave <Dave.Close@us.thalesgroup.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 20 July 2016 at 23:35, CLOSE Dave <Dave.Close@us.thalesgroup.com> wrote:
> Thanks, Jakub, for the quick response.
>
> On 07/20/16 02:20 PM, Jakub Narębski wrote:
>
>>> If I replace the hb=SHA argument with hb=HEAD, the URL still works. But
>>> I have no idea what I can use to replace the h=SHA argument.
>>
>> You can remove it.  'hb' (hash_base) and 'f' (filename) identify target
>> file in a repository unambiguously.
>
> If I do, leaving everything else present, I get "404 cannot find file".

Which gitweb version are you using? For 'a=blob' (i.e. displaying
contents of the file), if 'h' (hash) parameter is not set, then gitweb
finds it by using `git ls-tree <hash_base> -- <filename>` in
git_get_hash_by_path() subroutine. No 'hb' is equivalent to 'hb=HEAD'

What does `git ls-tree <hash_base> -- <filename>` results in your
repository?

>>> A complication is that the target file is not in the master branch.
>>> Somehow I need to be able to specify the branch. I've tried putting it
>>> as the h= argument but that results in "Reading blob failed". If I leave
>>> out the h= argument entirely, gitweb responds, "404 cannot find file".
>>
>> Did you forgot to set 'hb' parameter?  Is said file present in revision
>> given by the 'hb' parameter?
>
> The file is present in both master and develop branches. If I include
> hb=HEAD and leave out h=, gitweb doesn't find either of them.

It works for repo.or.cz (which uses gitweb as web interface). So we
have WORKSFORME situation. Now we need to find out what is
different in your case...

>                                                                                            Using
> hb=HEAD and h=develop or h=master results in "Reading blob failed".

'h' must be hash of the blob as an abject (of its contents at given revision).

-- 
Jakub Narebski
