From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 07/12] utf8: keep NULs in reencode_string()
Date: Sun, 31 Mar 2013 07:23:02 +0700
Message-ID: <CACsJy8DGPtfeAGAGXPZ0XaVNPYr=_upcR3rZojYXE2QD4cxvUA@mail.gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com> <1364636112-15065-8-git-send-email-pclouds@gmail.com>
 <51571B92.80303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 31 01:24:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UM644-0007Bs-Er
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 01:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962Ab3CaAXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 20:23:35 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:39155 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711Ab3CaAXe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Mar 2013 20:23:34 -0400
Received: by mail-ob0-f176.google.com with SMTP id er7so1111966obc.7
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 17:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=oBKcSIi4xh/ODTjSFp5WqcfjyS2q8+28Fu9V82/KeHo=;
        b=avsJRVu5y/tbTwwXMQ54Om+QoqhB32pj6hSjJn68WJYEnT6Tnp2dED8ZDUZ+2hQWA/
         SLNIdZ/OWir/fwfMeMqbywaLsbyGfr+TxZt859q0Y0Y8q6HT92F4bz+6L1G/mi6Yajbc
         JlvBL9NIY6YMGCnBfn8v7uxSXefhrcB9QPF86DBVDPLfQjFGhn41AE+Jet9Vb7CIdg1y
         +d7LTc7EQlUDrNIJEWaF3IW9vU8Z9V5bsyuipEiYJC/K4dpt+9qbzLL6WfVGvRMeBwDO
         maRMo/iZuj/kR7GAVkPNUBUsNqNcaINYCVq8s4Mss9Q4aGo3oy16yXLLMuehI7L3CF9e
         x0TA==
X-Received: by 10.60.31.79 with SMTP id y15mr2472731oeh.123.1364689412215;
 Sat, 30 Mar 2013 17:23:32 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Sat, 30 Mar 2013 17:23:02 -0700 (PDT)
In-Reply-To: <51571B92.80303@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219598>

On Sun, Mar 31, 2013 at 12:06 AM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 30.03.13 10:35, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> [...]
> The short version of a review:
> Would it make sense to leave  reencode_string() as it is,
> and add a new function reencode_string_len()

Hmm.. yeah.

> +char *reencode_string_len(const char *in, int insz,
> +                     const char *out_encoding, const char *in_encodi=
ng,
> +                     int *outsz)
>
> And I didn't manage to apply the patch on master (631bc94e67383b66da1=
90550866566f09d32)
> is there a specific commitID it should be applied on ?

v1.8.2
