From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Get a git diff without taking index into account
Date: Wed, 18 Feb 2015 07:37:05 -0800
Message-ID: <CAPc5daU9km+gr-DHJzJF59mugwGeNX69H27E_DaoyBZnuzoiFw@mail.gmail.com>
References: <CAAoZyYN-ohiq-Od=u-cd5FRH8=NpJNGS+zEo+NYgwAK7Kjaz_w@mail.gmail.com>
 <CAAoZyYPhiKX1F5ymdSijR7=e8CT1sqaomehBjt-NVDz_A4V4UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 16:37:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO6gt-0008Im-Gf
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 16:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbbBRPh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 10:37:27 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64459 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbbBRPh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 10:37:26 -0500
Received: by mail-ob0-f174.google.com with SMTP id wo20so3187921obc.5
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 07:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=e9N3OJF1u9gnnnHvLcFPjNOrizIN+fF+Mj5Qpit/ntg=;
        b=NtJEZ+mRUga7EKwXslH5+ExkKc+3h6oWBpjGT5v0ZkA1r3zOQG9XqGjegC3WwllgEi
         omJqZkK+JEvwyqXRCj2aWyCXE2h25+jTPHY9YBv2ajjBbZKThNM5pA8YxerA7/kBpzZR
         DaIDCnAml0RqcwilyQth0ftQ+shSEVDdIuwSftxPUJPCiO4+7fP4Mc+hvBCioj3gTwQ3
         y2DXb/ZJ1A78I30Bzz6HAXYA9EA3vQH4LaqVTrAQJK7H2/ue7y30OVjY1u6cjNea3Nns
         FVa90CaJ4X82arwDFQJxmM3Lew5TyWlW+horKoq170Tn3F/+gTCtoofeRf2fpFTZKlvV
         +oHA==
X-Received: by 10.182.75.194 with SMTP id e2mr3557319obw.17.1424273846033;
 Wed, 18 Feb 2015 07:37:26 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Wed, 18 Feb 2015 07:37:05 -0800 (PST)
In-Reply-To: <CAAoZyYPhiKX1F5ymdSijR7=e8CT1sqaomehBjt-NVDz_A4V4UA@mail.gmail.com>
X-Google-Sender-Auth: uE4jTSvETeP3Z3NEBrUYMg84oIA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264022>

On Wed, Feb 18, 2015 at 7:06 AM, Eric Frederich
<eric.frederich@gmail.com> wrote:
> # how can I compare a working directory to a commit without taking the
> index into account?

You don't.
