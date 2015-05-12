From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/8] t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
Date: Tue, 12 May 2015 14:53:31 -0700
Message-ID: <xmqqegmlea3o.fsf@gitster.dls.corp.google.com>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
	<1431225937-10456-3-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kZFC3Qr-S5dxHFf3W6FF6miNcbD8qCD48fP=PqzDhf75Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 12 23:53:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsI7S-0002e3-If
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934096AbbELVxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:53:38 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35151 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933934AbbELVxd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:53:33 -0400
Received: by igbyr2 with SMTP id yr2so121823309igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=GdL2NbGE9ufcBMRNhaC3VGsj7THYhWQqh10pl893o3A=;
        b=OUlC7R2BHjYCRFxh3CrhBezfeSzqc1k1AKS4AZpNrfSKPXFJZ9DnR3F9ftWrvrcQaj
         fFycTOhsseFcARQBk3AbcDXDFc5B/F12bDe+ty7rTx8ryMY0NJT61ltBdH20Ttflnpol
         1a9LrWoZMAnpXVbdlVlRqQRkf+X+gbNihGxA6VmTi7CRPWolSd4nXD7kuTRmBq0xibFl
         FTb5zlgKmSlMgPqUCflvCc9glMf86k5xr6sXOnEEAoEqUaWBJjUhfrrO/OHQtO3jazno
         Owb4vkfOU69gJj/1tA3OmP9F87877wJIQPFzDlC5X3m8OOY1bTEnpVHgCpPz0IGK6hQB
         tbxg==
X-Received: by 10.50.143.33 with SMTP id sb1mr22731796igb.33.1431467613142;
        Tue, 12 May 2015 14:53:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id cy11sm2095320igc.14.2015.05.12.14.53.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 14:53:32 -0700 (PDT)
In-Reply-To: <CAGZ79kZFC3Qr-S5dxHFf3W6FF6miNcbD8qCD48fP=PqzDhf75Q@mail.gmail.com>
	(Stefan Beller's message of "Mon, 11 May 2015 10:23:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268897>

Stefan Beller <sbeller@google.com> writes:

> On Sat, May 9, 2015 at 7:45 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> From: Stefan Beller <sbeller@google.com>
>>
>> During creation of the patch series our discussion we could have a
>> more descriptive name for the prerequisite for the test so it stays
>> unique when other limits of ulimit are introduced.
>
> I must have had a bad day when trying to write this. Either words are missing
> (just insert a "revealed" after discussion on the first line) or it

I just did this s//revealed/ while re-reading the v2 series.

Thanks.
