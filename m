Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576B0C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 21:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiALVi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 16:38:27 -0500
Received: from elephants.elehost.com ([216.66.27.132]:58690 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiALVi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 16:38:26 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 20CLcMXq037349
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Jan 2022 16:38:23 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <002901d807ee$84cd2f40$8e678dc0$@nexbridge.com> <xmqqtue8so89.fsf@gitster.g>
In-Reply-To: <xmqqtue8so89.fsf@gitster.g>
Subject: RE: [PATCH v1] Modify NonStop configuration to disable uncompress2
Date:   Wed, 12 Jan 2022 16:38:16 -0500
Organization: Nexbridge Inc.
Message-ID: <003d01d807fc$b9217400$2b645c00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHbiG/+K3gIjJcqhakMnQ8/PDNX6wKW7DKmrEQwlaA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 12, 2022 3:17 PM, Junio wrote:
> <rsbecker@nexbridge.com> writes:
> 
> > Modify NonStop configuration to disable uncompress2.
> >
> > The zlib version available on NonStop x86/ia64 does not contain the
> > uncompress2()
> > Procedure.
> >
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> >  config.mak.uname | 1 +
> >  1 file changed, 1 insertion(+)
> 
> I'll lift your s-o-b from this patch and use it in
<xmqqzgo0u5j7.fsf@gitster.g>, as the
> patch part didn't apply.
> 
> Thanks.
> 
> >
> > diff --git a/config.mak.uname b/config.mak.uname index
> > a3a779327f..9b3e9bff5f 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -576,6 +576,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
> >         NO_SETENV = YesPlease
> >         NO_UNSETENV = YesPlease
> >         NO_MKDTEMP = YesPlease
> > +       NO_UNCOMPRESS2 = YesPlease
> >         # Currently libiconv-1.9.1.
> >         OLD_ICONV = UnfortunatelyYes
> >         NO_REGEX = NeedsStartEnd
> > --
> > 2.34.1

Thanks,
My mailer wrapped the commit. Unfortunately, git send-email is not working
in my environment and --smtp-debug is not helping at all. I think it is
probably a certificate issue, so I have to manually paste the patch into
Outlook - the most yuckiest way to send a patch in the history of patches.
Regards,
Randall

