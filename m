From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Wed, 30 Apr 2014 15:11:31 -0500
Message-ID: <536158f39fccd_4781124b2f090@nysa.notmuch>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <536129068cc28_1404fdd310fd@nysa.notmuch>
 <vpqha5akamh.fsf@anie.imag.fr>
 <5361416a172fe_f9b15012ec7e@nysa.notmuch>
 <xmqq38gufxbm.fsf@gitster.dls.corp.google.com>
 <53614fb5e204_2aa5fa32f0df@nysa.notmuch>
 <xmqqlhumegqg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 22:22:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfb1D-0007sI-N5
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 22:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759305AbaD3UWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 16:22:12 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:44694 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759107AbaD3UWL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 16:22:11 -0400
Received: by mail-yk0-f172.google.com with SMTP id 131so1975939ykp.17
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 13:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=jxLQgigthAReDXw+9Ja+AiOCIIJ1AckM4L2E6Rfv1lE=;
        b=vIX141tIQcbCQeRhp2jaGzxkoMDbFphPDdPxOj/7YPQKycNczdpfcVaj/CnG3857HE
         UY3HLFy3YswqV4z7SpMFAjcNWmrvLn4XAjpg5RyB8WUlovRMmWqBM16fzuZniuqMsVat
         d7KUGREhTzIdH/DzIXyXG4D9QCESzT3DusHTvZifYrdPWexVx+V2qlLJUMBCpPnJPbcK
         hz9Q7gJ8KVgIJ6uYNvWypB2xMuiInJsgyzDKje0Fnms/miyfayljHwvOk3XADH5CPJer
         0wtVX0KBli7aga0QTmCARZ1n/FeVn0LrWzYoNdbA20TKIZAqMdCtfOcQY+Ecm6uGgQqX
         CpXw==
X-Received: by 10.236.124.236 with SMTP id x72mr8843399yhh.49.1398889330164;
        Wed, 30 Apr 2014 13:22:10 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id k70sm44749809yhm.38.2014.04.30.13.22.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 13:22:09 -0700 (PDT)
In-Reply-To: <xmqqlhumegqg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247775>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Junio C Hamano wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> > Matthieu Moy wrote:
> >> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> >> ...
> >> >> > Yes, this has been discussed many times in the past, and everyone agrees
> >> >> > the default behavior is not correct.
> >> >> 
> >> >> You definitely have a strange notion of "everyone".
> >
> >> While I do not quite see the previous discussion as deciding the
> >> particular implementation is good without further tweaks, I would
> >> say that everybody agrees that the default behaviour is not good for
> >> everybody and therefore should (or for Linus, "it is OK to") change.
> > ...
> > I said 'everyone agrees the default behavior is not correct', which is
> > true.
> 
> Isn't that what I said a few lines above?  Why are you still
> arguing?

I'm not arguing, I'm clarifying what I said for Matthieu. What I said
was a response to him.

-- 
Felipe Contreras
