From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2 15/16] Documentation/technical/pack-protocol: Mention http as possible protocol
Date: Tue, 02 Jun 2015 14:57:29 -0700
Message-ID: <xmqqmw0hzsc6.fsf@gitster.dls.corp.google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-16-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:57:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzuBk-0001Is-QS
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbbFBV5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:57:33 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35781 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbbFBV5b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:57:31 -0400
Received: by iesa3 with SMTP id a3so131061ies.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=FJe2Q/fKCa22nJXsBu8E7lhmhnPuRMjIbO9wK5YKhnk=;
        b=i7JF3x8aRDqQUzrtfkUlvuePbXUmQ40l+I0+CL1DvUy2Mgkn+D3iaqqZ69eV71gzqW
         ZAL+bFeXigjpEh4AhkQAxV9QMM4ROz/nK/wss6FDcCZ6krBaEFsCY7/JfYlFvhF0mAb3
         pwzu3lW840ruzn46owrbOr6RePpBt+c1SD1rSgCZe0Jo6s+vtWIaXfkGY+17mCkwdBVL
         yiltJT4bNR0eGQI947cpiXhVb98sB15vUFG3LLMB8sULh0Oa1GqiUA+mzH0vVz9We/ic
         p53mdL7U7PjrG+VX+TfQL/ny7hpdBoIgRya7pqd6pPz7rx7rIE4KOkwoHE9z9YHaAAh3
         5b3g==
X-Received: by 10.50.178.230 with SMTP id db6mr800579igc.26.1433282251129;
        Tue, 02 Jun 2015 14:57:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id l128sm13392670iol.1.2015.06.02.14.57.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 14:57:30 -0700 (PDT)
In-Reply-To: <1433203338-27493-16-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 1 Jun 2015 17:02:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270613>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> This may go unrelated to this series as well.

Yeah, this can come before this series as a good independent
clean-up.

>
>  Documentation/technical/pack-protocol.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/technical/pack-protocol.txt
> b/Documentation/technical/pack-protocol.txt
> index fc09c63..4064fc7 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -1,11 +1,11 @@
>  Packfile transfer protocols
>  ===========================
>  
> -Git supports transferring data in packfiles over the ssh://, git:// and
> +Git supports transferring data in packfiles over the ssh://, git://, http:// and
>  file:// transports.  There exist two sets of protocols, one for pushing
>  data from a client to a server and another for fetching data from a
> -server to a client.  All three transports (ssh, git, file) use the same
> -protocol to transfer data.
> +server to a client.  The three transports (ssh, git, file) use the same
> +protocol to transfer data. http is documented in http-protocol.txt.
>  
>  The processes invoked in the canonical Git implementation are 'upload-pack'
>  on the server side and 'fetch-pack' on the client side for fetching data;
