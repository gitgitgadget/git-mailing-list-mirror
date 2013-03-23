From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG?] rebase -i: edit versus unmerged changes
Date: Sat, 23 Mar 2013 18:21:22 +0530
Message-ID: <CALkWK0nspPEaA3BLjgV6Qv2UgXRbDft1d6SmRCiVNJoxpqLFwg@mail.gmail.com>
References: <CALkWK0n=fb_kq+Ed3rd9MhQUCHY3+_nj=zw4M+GmjbzEO56SOg@mail.gmail.com>
 <CADeaMWoeRQBbrqLsfieKTE2rRbpzU-Hyp+mv-=CTj+=Znmf=Zw@mail.gmail.com>
 <CALkWK0mgX40oicqxnoa7M3NJP_k8jDrg7mVGyWrg5T+=iRtHQA@mail.gmail.com>
 <7vsj3pdcm5.fsf@alter.siamese.dyndns.org> <CALkWK0kHFHtsy1Eh+jnY-JNSDUYd2xtiavhPNjaT8H3mJvYZkA@mail.gmail.com>
 <20130322182550.GF12223@google.com> <7vehf76uai.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 13:52:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJNvf-00057j-Au
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 13:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950Ab3CWMvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 08:51:44 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:63590 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab3CWMvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 08:51:43 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so4318853iak.4
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 05:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DgThLndMk+ZXuZcW+SO14Tx8sOIDq8Nv7m74t+3kCH8=;
        b=rBa4CpeRIV07qnP3jnihVLXAzXuv0fIPhlFg7WGcfWO186cymeWn8wOK+10If5D3hd
         UtoxNjskzCG+ti5r150RHz+oE73eHxLOEVnPlS3cuq3/uaNFMp+DAJeMsryCXC6k/XF8
         4htZQ/1vaq21o+JFp7eLs0YMUYBegQWuEcxVWXokB1L3G3Yr7gu7xtJvkhSWHGlVq/97
         sWWXrgbVfpX97jQHj+0bSPLLV9/WeUmsPfeiVGq/yIKpsA3HTwwX8IECeGSfhpv+SWrE
         +ykw1SZb9aLgBd+iYBGD6Dg4NYieDl0lt7lc/z3Nr9r+hCLntrImsqOfRde1TLXbWv5U
         4rgQ==
X-Received: by 10.50.50.71 with SMTP id a7mr7079423igo.14.1364043103047; Sat,
 23 Mar 2013 05:51:43 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sat, 23 Mar 2013 05:51:22 -0700 (PDT)
In-Reply-To: <7vehf76uai.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218913>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Ramkumar Ramachandra wrote:
>>
>>> I'd really to have that final 'git continue' in Git 2.0.  Can someone
>>> attempt to break up the migration path into manageable logical steps
>>> that we can start working on?
>>
>> Is there any deadline or migration path needed?  Depending on the
>> design, it might be possible to do without backward-incompatible
>> changes, meaning the migration path is "whatever someone feels like
>> implementing first lands first".
>
> FWIW, I am not convinced yet why we would even want "git continue"
> in the first place, so I won't be the one who would be suggesting a
> migration path.

Okay, I'm confused now.  You were the one who suggested a unified "git
continue" in the first place, if my memory serves me right.  Why are
you doubting it now?
