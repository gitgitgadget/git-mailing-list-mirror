From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 5/5] help: respect new common command grouping
Date: Thu, 21 May 2015 09:16:07 -0700
Message-ID: <xmqqiobllxdk.fsf@gitster.dls.corp.google.com>
References: <1432213989-3932-1-git-send-email-sebastien.guimmara@gmail.com>
	<1432213989-3932-6-git-send-email-sebastien.guimmara@gmail.com>
	<CAPig+cRX9_1h4W6sWxb22FF3Hwgqx2f=hK=tQkfTUdkTJiQo-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?S=C3=A9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 21 18:16:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvT8q-0005y4-7b
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 18:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156AbbEUQQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 12:16:11 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34661 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306AbbEUQQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 12:16:09 -0400
Received: by igbhj9 with SMTP id hj9so14463579igb.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=O/VQBf+e5Fmgu1VFweQy785N6BWwa97hcS6SxVqyax4=;
        b=NIssfcITalS1i6KZzjH1SMyCw4Lr/ytMhAzqcn3nq2SU8Adr1PJNtUlUzFQllBw7FV
         Aqj+2YFhSxeuuRXTsmzQH6x6Y0Fqz1ggCbKeLdlVM7BdAmnzpNrZIf+ycGdKCzShmYEL
         hiqugL+CAobZUxgFXE8cpSVEbGQPeFjDglAPnRYw3Ms5oGsz9vvGNBuqAsFokPEee+MU
         JgXCT45PY92UqJSsH0wXrLtOBjQHiludMEqIOCPcsWCNm1A4bJ7VEgGFLs+29T5bTKCB
         kijbVFaPScwMxJIe45BdQziJxSpusHzzN5rRIE7OYZ4jhKCm/5DikEm7IgfiJWRCaG/o
         FPrA==
X-Received: by 10.50.39.9 with SMTP id l9mr4538979igk.45.1432224968844;
        Thu, 21 May 2015 09:16:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id h128sm15188674ioh.38.2015.05.21.09.16.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 09:16:08 -0700 (PDT)
In-Reply-To: <CAPig+cRX9_1h4W6sWxb22FF3Hwgqx2f=hK=tQkfTUdkTJiQo-w@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 21 May 2015 10:29:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269603>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +
>> +       puts(_("These are common Git commands used in various situations:"));
>
> The clause "in various situations" is quite nebulous and thus adds no
> substance.

FWIW I view the latter half of that sentence as explaining the group
labels which we did not have (so we did not have to mention in the
original).  Perhaps swapping the order may clarify, as the list
itself is a two-level, i.e. list of workflow elements, each of which
has list of commands?
