From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/3] t3404 incremental improvements
Date: Thu, 22 Aug 2013 14:17:03 -0400
Message-ID: <CAPig+cRM_j7KOKG+YS1aTqz7suDY5LC7kh5-oP5H-GAenUqq-w@mail.gmail.com>
References: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
	<xmqqk3jesk2a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 20:17:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCZRY-000261-TI
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 20:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853Ab3HVSRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 14:17:05 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:35435 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab3HVSRE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 14:17:04 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so1727733lab.20
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 11:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=c83UDq0ZIRkzSDUYSl+QHtS0gpCZfyDaj1BW0DWbN2I=;
        b=eP2OUZYKvnvDbOEOJDBs/wExVisQIAgkW7yGdW2lNn/pvYrEemyt5N5K3TYuTYtLWh
         yPNaGsEHVY+mfNpxDaf0MAmbmQhv1vvTfuV4CIZCSMqstM5iN0lJV64UMONXXsLwTvCo
         cvLAcXbDFdZe5eodGBgGBBqjaZqv6nEx0imYLWqStxrJK9Qn5ThAhwFsnSH2ehaXDpRS
         9lNuYShlQq4XIDyAZ1CDuwxy71sE2FBlwpEJooC8x22ysXABc6ZacUyCccLNqSh5evkL
         XAvucwNq+JynKEXTbB95FOPfGh6yW+6ds/LhhN6rrRD287/IpJ3d4vtuOZMdMXvfAVFK
         6BWw==
X-Received: by 10.112.150.97 with SMTP id uh1mr2809545lbb.34.1377195423278;
 Thu, 22 Aug 2013 11:17:03 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Thu, 22 Aug 2013 11:17:03 -0700 (PDT)
In-Reply-To: <xmqqk3jesk2a.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: C9MEcpu6u6qG3zLabXQCS6mpS_Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232770>

On Wed, Aug 21, 2013 at 7:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> This set of patches was meant to be a re-roll of [1] addressing Junio's
>> comments, however [1] graduated to 'next' before I found time to work on
>> it further, so these are instead incremental patches atop 'next'.
>
> Just FYI, 'next' will be rewound once the upcoming release is done,
> so we have a chance to rewind and squash.

How would we go about this? Is there something I can do to streamline
the squashing?

Unfortunately, the various fix-up patches do not have a one-to-one
correspondence to the original three patches in 'next'.
