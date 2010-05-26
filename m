From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 3/3] commit: show abbreviated sha for commits with empty 
	diffs
Date: Wed, 26 May 2010 13:37:33 +0800
Message-ID: <AANLkTik_R4U3SvUwLR1nFZhszhmVC8SCmp0JhjGFbUsO@mail.gmail.com>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
	 <1274694452-4200-2-git-send-email-rctay89@gmail.com>
	 <1274694452-4200-3-git-send-email-rctay89@gmail.com>
	 <1274694452-4200-4-git-send-email-rctay89@gmail.com>
	 <7viq6bqmid.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 26 07:37:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9JE-0003M7-Cb
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab0EZFhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 01:37:35 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42822 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab0EZFhe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 01:37:34 -0400
Received: by mail-gw0-f46.google.com with SMTP id a12so511354gwa.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 22:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=7BAjnHx9s1EsQPaiJSTMSBgJ6F1bQsd0w77iCdDC/gM=;
        b=vO1R/KACK+TTnfpxRyKOIJjG3DAAEvUqqlvh3sKx1ncuu4vU0wzxsrz3pkUlSJ6QAK
         s7RXpCAdVPYCAWjYr5KKfond5HOM5T/lDOwcJVVAo507Cbmq6mcTdkUpeyx/tsow8XKA
         IxZRJhqBJSOI0/6qJ4TU3HDFnCFfaaaYr4pbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=v/3p1otLYn744WRGVYcNgdEDIahnQqwwOUj3RK78J8M+ly4bMYpBwvcEV3vA8c48Kd
         3eje5MPqwDZQIOfiyYpZ/tTqTP3T+HEf7BEv07sNpXRf48/LVF4tMHsPQXDJsrCgin0Q
         141z+HjqIank6N0ydcCdkqmNAhcW5ipUA3iLI=
Received: by 10.231.125.167 with SMTP id y39mr6611158ibr.93.1274852253773; 
	Tue, 25 May 2010 22:37:33 -0700 (PDT)
Received: by 10.231.33.12 with HTTP; Tue, 25 May 2010 22:37:33 -0700 (PDT)
In-Reply-To: <7viq6bqmid.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147744>

Hi,

On Wed, May 26, 2010 at 1:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The fix itself might be trivial, but the series seems to break 7502.20
> and 7502.22

I tested this patch series on top of:

 - efd1311 (Merge branch 'jn/shortlog' into next), which contains
   c197702 (pretty: Respect --abbrev option), the first offending commit
   to print un-abbreviated SHA-1s.

 - b26ba11, the recent 'next'.

It both cases, #20 and #22 passed fine.

Also, I outlined another possible fix in the cover letter to this
series:

  1274694452-4200-1-git-send-email-rctay89@gmail.com
  http://thread.gmane.org/gmane.comp.version-control.git/147619

I find the alternative fix a bit more precise; I'd appreciate your
comments, if you get the chance.

-- 
Cheers,
Ray Chuan
