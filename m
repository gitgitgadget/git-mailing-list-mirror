From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] commit: reword --author error message
Date: Fri, 16 Jan 2015 14:37:20 -0500
Message-ID: <CAPig+cR4vaYe+KiJthmpzo3p7JQyGgEDBqqLP0nBM3YjXXZywQ@mail.gmail.com>
References: <54B7CCCD.1070708@drmicha.warpmail.net>
	<84cf10a22858275d6e213311c93df7f6a5408f60.1421331608.git.git@drmicha.warpmail.net>
	<xmqq4mrs7x5h.fsf@gitster.dls.corp.google.com>
	<20150116093220.GA3006@peff.net>
	<xmqqwq4m3a8k.fsf@gitster.dls.corp.google.com>
	<C67968DA2DD34039AF6EC8B61AA1CA47@PhilipOakley>
	<xmqqbnly376a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Gunnar Wagner <gunnar.wagner@irisgermanica.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 20:37:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCChz-0003sR-NL
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 20:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619AbbAPThW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 14:37:22 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:41963 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029AbbAPThV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 14:37:21 -0500
Received: by mail-ob0-f169.google.com with SMTP id vb8so20693528obc.0
        for <git@vger.kernel.org>; Fri, 16 Jan 2015 11:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+XlFWBIdQQA9rRFVpSwzmXXUs6axwi/ixzQxNAXRGbs=;
        b=xFzhMhcpCQ1Uzw26OHOyiBYdfsFCIHnLEKvUwuh8kfNtT98k3bC3/Sqbevnll5fP+X
         w/fgzqc/Ix9EWHBGYPKZZCDvWwF6zuiAGtuYNEnWJtJRq5cPhDuD9wyalPCVyr/vaTVb
         ewFWHerKpqoBKbpflfY4cSmswRkCp5EF2NaRlS1el7snrOZ+v5TLDvJFIiYgt0UVExZC
         MdZUYAm4EJysvgFqou+NkLlEI3KN00gVo9leEd53x2PIvnRSgE7GhxGXU/TMHnUuRns3
         wLoEI+yDT36gCXLggi2bjcGq5P1Oce57PEQiwbqNtWQn+rjPurk69bpMwaNSsnDfhtEY
         2wfw==
X-Received: by 10.202.217.138 with SMTP id q132mr9805226oig.35.1421437040269;
 Fri, 16 Jan 2015 11:37:20 -0800 (PST)
Received: by 10.202.171.196 with HTTP; Fri, 16 Jan 2015 11:37:20 -0800 (PST)
In-Reply-To: <xmqqbnly376a.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: VATw4SmD5hyI1IXT3-lqx9AKUq8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262565>

On Fri, Jan 16, 2015 at 1:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>     die(_("--author '%s': not 'Name <email>', nor matches any existing
>> author"));
>
> Sounds good.  Thanks.

To further bikeshed (particularly if "nor" is in the mix):

    neither 'Name <email>' nor a match for an existing author
