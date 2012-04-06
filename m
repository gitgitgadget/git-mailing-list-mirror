From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Sat, 7 Apr 2012 00:28:05 +0300
Message-ID: <CAMP44s0xAvc9aTeBP81tXhX6Q67+7cQ-51C1AWrKPN7bc7=JXQ@mail.gmail.com>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
	<20120406201926.GA1677@sigill.intra.peff.net>
	<7v7gxs1ud4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 23:28:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGGha-00019Q-HI
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 23:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034Ab2DFV2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 17:28:09 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40175 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab2DFV2I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 17:28:08 -0400
Received: by wibhj6 with SMTP id hj6so828876wib.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 14:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SP4IcOTS79/v8T2nOPJ0Cd50YavO//fPHZzWRNdlmIo=;
        b=tY/JAPPPaT8R6WCShONLggMcwbwaxCtt546Cbv+xP/0n1wpvmUsieMY71QhWOEPNRt
         13iSG5swome18ga0/tKumg9CB5uK9IZg/ekAg/N69zYYHLhPEng+lKC+haFA+3HLJYPH
         Vm9n1OGjsa23aPPV932fD+mAnEE5u/jjQwQHBdKb+hFpLvGfoj8a4/9PW7L/bhGoFL1g
         D+mQg2ESys9LwDhHmlqMlNLzAeLB2oU8Do4u+9YYmxhbjjIgZmCOMqiiTaxcoJtM5gZv
         xgJPbngWws4wzhgooiFQei288H+prgQG/ALM+4jU3C0LwK4HbiMTAkowpf9bKv/IDpZE
         Vdjg==
Received: by 10.180.107.132 with SMTP id hc4mr14126456wib.21.1333747685977;
 Fri, 06 Apr 2012 14:28:05 -0700 (PDT)
Received: by 10.216.70.4 with HTTP; Fri, 6 Apr 2012 14:28:05 -0700 (PDT)
In-Reply-To: <7v7gxs1ud4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194909>

On Fri, Apr 6, 2012 at 11:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Fri, Apr 06, 2012 at 10:28:39PM +0300, Felipe Contreras wrote:
>>
>>> Something is better than nothing.
>>
>> Yes, but...
>
> ;-)
>
> This is a good example that sometimes something is worse than nothing,
> unless watched carefully by a competent reviewer.

And this is a good example of why you shouldn't blindly trust what a
'competent reviewer' says, as I'm pretty sure the comment is wrong.

But hey, if you prefer nothing, fine, drop this patch; let's continue
to blindly modify the completion and fix regressions as they come. I
guess I should drop my other tests as well.

I was planning to do a bit of reorganization to the bash completion
after having some basic tests, but I'll just jump straight away to the
actual patches then.

Cheers.

-- 
Felipe Contreras
