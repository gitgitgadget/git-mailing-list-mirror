From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Tue, 30 Oct 2012 17:02:21 +0100
Message-ID: <CAMP44s3ap19TDsSo_fmNqJp+ROWo2Ka8bc35YQmR3mMw375WsQ@mail.gmail.com>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
	<20121030044609.GA10873@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 17:02:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTEGx-0004hl-GO
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 17:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933933Ab2J3QCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 12:02:22 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58716 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933825Ab2J3QCV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 12:02:21 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so404811obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 09:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DOWvI5h2LGVm+PxQ6yGvRXMOYklBdnVjKNA4m5po34Y=;
        b=dL062rTtl6pxzvOa6Qa7IraN9q2/RQWDAA1jpgI5tR+o/qe6VCtwl5F0gEXp49pN0n
         JoZDllXkiFB8oouPhFhWGkNgCRDfE8n6oyOILYIY38oQHZaTeEcSen4G0BRkDEQSPPN3
         iMaEufW5d2X6DioBthFDxPPb4T7kGgtT7ZXwNyjU1+0V+n8wTrI0F/i9BJxAsdr04Jqe
         DH8+xWdwsA3g3E94QMFOkxMqUaJhbW3dwzvAaSmPYE10omqXRdzburgllfn+9HdKoPza
         cOk08xLOCwC4VHUo+9vWxmC/z9wuD33ivXC70hTDRxKZ5fwdmal2N8ipA+/wXf23WlEe
         k/Xw==
Received: by 10.182.245.20 with SMTP id xk20mr28171973obc.89.1351612941201;
 Tue, 30 Oct 2012 09:02:21 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 09:02:21 -0700 (PDT)
In-Reply-To: <20121030044609.GA10873@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208706>

On Tue, Oct 30, 2012 at 5:46 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> No reason to use the full path in case this is used externally.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> "No reason not to" is not a reason to do anything.  What symptoms does
> this prevent?  Could you describe the benefit of this patch in a
> paragraph starting "Now you can ..."?

./test-lib.sh: line 394:
/home/felipec/dev/git/t/test-results//home/felipec/dev/git/contrib/remote-hg/test-21865.counts:
No such file or directory

-- 
Felipe Contreras
