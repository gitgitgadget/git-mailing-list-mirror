From: Csaba Henk <csaba@lowlife.hu>
Subject: Re: commit message parsing error in rebase
Date: Sat, 5 May 2012 00:54:21 +0530
Message-ID: <CAA-jfp=yMVFrfFgh9A_zNC5nG8PTvNWBRpkbpbVK+7GUU7jO9Q@mail.gmail.com>
References: <CAA-jfp=F7ije9nFJio5gnmNGptDR1ZTBbCi-aOv7JokqrXBgYA@mail.gmail.com>
 <7vlil7ah5w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 21:24:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQO7T-00043N-QV
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759474Ab2EDTYo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 15:24:44 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41513 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab2EDTYn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 15:24:43 -0400
Received: by eekc41 with SMTP id c41so940124eek.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 12:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Wxk5jVuY1BeLd7V0e2rZ/0fLTR0VMwJpvO4QMjsQGTc=;
        b=hFs6tNuF4xdyILEH/7Du08ckIhWsgwLUuk4GNDu5ai5z7r9l4d2fjw5I8Yc1OA7KEw
         4A1kJd78zy9sjVbl0RKDxZ9PGYK6iYfZGOXWyGmIVGHMMPFy+uQ1XQ8/wf2lRCCBur3m
         xQl4pGNBIR9RaZZRZaQsoMPL4doV3yGHGpwYDcfaleW+3YDvH2IlghCi93kSz1311THs
         Aj/t+Upe3dvAmu+2zz9eoE7Y1gcUaqoq4/qF2PHewg4aH2KUJ/LVrqo8DJgiHc+qrF4x
         bVHmqn5Pluhce4lHC2bcVM8R4vLOTEz6DYRIumfAWc9hidrAGCPrkCrgCUBskCndG31a
         413g==
Received: by 10.213.30.7 with SMTP id s7mr1393741ebc.77.1336159481869; Fri, 04
 May 2012 12:24:41 -0700 (PDT)
Received: by 10.14.194.198 with HTTP; Fri, 4 May 2012 12:24:21 -0700 (PDT)
In-Reply-To: <7vlil7ah5w.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: MIpuO7cnc1xX0xrZkoPP2LOLPAY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197057>

On Sat, May 5, 2012 at 12:48 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Sorry, but we do not support writing "diff" output in log message as-=
is
> (it is primarily because format-patch output from such a commit is ha=
rd to
> read for humans). =A0A common workaround is to indent such an illustr=
ative
> patches indented in the log message.

In that case, would it not be wise to be explicit about that and warn
or err if such a commit is attempted?

Csaba
