From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 07/10] builtin/replace: teach listing using short,
 medium or full formats
Date: Sat, 21 Dec 2013 10:34:06 +0100
Message-ID: <CAP8UFD1hdNE__+bVtKegChBT4u3Rx7NEzBYYkdEmUwfFLLpkzg@mail.gmail.com>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org>
	<20131211074614.11117.96106.chriscool@tuxfamily.org>
	<52B196F1.3060003@gmail.com>
	<CAP8UFD3UsdcDg2D2nysMZgGAxLebYm-qQX3LZfqdwF9gNbyxgA@mail.gmail.com>
	<xmqqioumjc1n.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1+kydjrjhTxKDSMmOa+KiOYgMGK5gyxCe-LPih02=VYQ@mail.gmail.com>
	<xmqqbo0cfz1x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 21 10:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuIxI-0003vT-Os
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 10:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab3LUJeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 04:34:11 -0500
Received: from mail-vb0-f47.google.com ([209.85.212.47]:45757 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab3LUJeH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 04:34:07 -0500
Received: by mail-vb0-f47.google.com with SMTP id q12so1875766vbe.6
        for <git@vger.kernel.org>; Sat, 21 Dec 2013 01:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IkEPNK1lZUESc7iupXCOlPBirnd9yJ2TMMPq5I7ZXQk=;
        b=yBwfeAWsfBR8W1rI+OgjC553mHZSom39wU4OHgV4PQUiSjrJo8kw+ne8yZBZUrdTlI
         CYmXqcaENKPLtUCp0ctZxJDBxKcTJep+GNAGUx2TKS47BgS8EbPxpvpqh3H1dj0kVXxt
         I/rcYD4wwaHHEjS5NB2/PjxGs7k7KPg2mwVakief0UzzY04eZK2A4+Ok4dqOicJGc/mO
         NyTDC6MgfSIEnGd/PGUxVF9u7PjxMYrcLKGhjjjxr3DMh3tYY4MnZpm0MZLexhwjdXQg
         A4beN8VxJEdhKqBB52W1UArj9SCUbx0dxYGrPoN+zWoaylV0GoF/MX6wz7dtO9CRgeyV
         pfqQ==
X-Received: by 10.220.147.16 with SMTP id j16mr1070521vcv.28.1387618446168;
 Sat, 21 Dec 2013 01:34:06 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Sat, 21 Dec 2013 01:34:06 -0800 (PST)
In-Reply-To: <xmqqbo0cfz1x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239586>

On Thu, Dec 19, 2013 at 7:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> I think this last one might be useful for people replacing objects
>> with objects that have another type.
>
> ... which IIUC is strongly discouraged---didn't you have to tighten
> it recently?
>
> And that makes it "useful primarily for debugging" unusual
> situations.

Ok, so would you prefer the following:

- NAME_ONLY_REPLACE_FMT and "--format=name_only" instead of
SHORT_REPLACE_FMT and "--format=short"

- NAME_AND_VALUE_REPLACE_FMT and "--format=name_and_value" instead of
MEDIUM_REPLACE_FMT and "--format=medium"

- DEBUG_REPLACE_FMT and "--format=debug" instead of FULL _REPLACE_FMT
and "--format=full"

?

Thanks,
Christian.
