Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5691203EC
	for <e@80x24.org>; Wed,  3 Aug 2016 14:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbcHCOlA (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 10:41:00 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:36846 "EHLO
	mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932282AbcHCOk6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 10:40:58 -0400
Received: by mail-qt0-f181.google.com with SMTP id 52so144466315qtq.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 07:40:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=knlccvm69qQgjnsGpL8yDZbmeQOP+p0TK97QIlTZU8Y=;
        b=sd/fo9ZTsZjEq646iSMVeqTOxM6zEIFexBZZJ3f/RpX0OcIJrFml3XzzCvyg2+QSoq
         xLaSHSeqiDKOYYy3h7khDMMOPoc/9IDhqALx/mntKnSfdL25/JYdvaADpGi+mJpOy7CJ
         8a+y4USMCh38Kvan4P47FMPZS75JytfUc/t80PVZYnKSK8X3WdzSm5WN5wRsuMSiU5F1
         3rwgUVsodczfPi1TdhvQ72PRLzWw7DFEgiZhGbncOFIEMB6NP0cmiawGhp4RwvLNx242
         WcjIElqM7xQvGKWsooDbecm8DKlpz1soI8adp9Xr3xpFXRtvaFc6BuGxlDLioh4zaJNn
         kwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=knlccvm69qQgjnsGpL8yDZbmeQOP+p0TK97QIlTZU8Y=;
        b=mN8y/5NC0v2+vIJ6C3HmFnGRFPwM7APlnXA3jpHzCPikHqOSC3T5V0v9XmlmS7fT/3
         jGDBAvAP9Rjx7y9L1sXdFq9zh+c12bLHbukNa9NJcSYo7UaJ86Be960wC2P34qefYJ8e
         pTR+FgJxmvnGtuXAaDlo1cTE8/cSzxwkM2yyPs5uayCly8u2yoF1LWYAWF7cnLuKccVs
         7cx0+z45mtbv2WZDQK7StagH2NKc6EgWTaZvlxaT8gdPUo13RzZEHSn4ywzcTUVxBrD2
         NJBJcJBFA5TjDoJYBc1t4rcwFHrt7SbUuU/6moDvMumqsIK8Ts19+4rPqtwTjyZYp0FU
         tQhw==
X-Gm-Message-State: AEkoousV28uQdpV00exqNFoxg0eXcXhzmMfOe+1KauRGZffmpyz9DRtM4x+TZmLRlB6kmLTJF8FapDPZZc2xrQ==
X-Received: by 10.200.54.28 with SMTP id m28mr10795qtb.87.1470233675086; Wed,
 03 Aug 2016 07:14:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.45.67 with HTTP; Wed, 3 Aug 2016 07:14:33 -0700 (PDT)
In-Reply-To: <20160803140730.GA2390@atze2.lan>
References: <CAKON4OyiG=ddx77Bn3h-YAh-3BYGd2rXPb9smwaooWxfBmtDKw@mail.gmail.com>
 <20160803140730.GA2390@atze2.lan>
From:	"jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date:	Wed, 3 Aug 2016 10:14:33 -0400
Message-ID: <CAKON4OzzKWXXbnTW+NEhSNs9WPWq=AS970YeLMRx95ObYhGaxA@mail.gmail.com>
Subject: Re: Making file permissions match
To:	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 10:07 AM, Torsten Bögershausen <tboegi@web.de> wrote:
> On Wed, Aug 03, 2016 at 09:46:06AM -0400, jonsmirl@gmail.com wrote:
>> I'm working with some Windows programmers that don't believe in file
>> permissions They keep sending me zip files of their source tree.  I
>> have my copy of the tree in git on Linux with all of the correct file
>> permissions.
>>
>> So I unzip the archive they send me and to see what they changed. I
>> unzip it on top of my git tree. But now all of the file permissions
>> don't match. The code deltas are there but there is also all of this
>> noise from the file permissions.
>>
>> Is there an easy way to deal with this? I want to keep the code deltas
>> and ignore the permission changes. Since there are about 100K files
>> this is too much to do manually.
>
> (I'm not sure if I understand "match" correctly)
>
> You can ignore changes in the executable permissions:
> git config core.filemode false
>
> Please let us know if it works

Thanks, that might work. It will take a few hours to check since the
repo is huge.

-- 
Jon Smirl
jonsmirl@gmail.com
