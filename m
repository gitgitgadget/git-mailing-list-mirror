From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/6] revert: Simplify passing command-line arguments around
Date: Sun, 9 Oct 2011 14:34:40 +0530
Message-ID: <CALkWK0niwg1Ogs+xBr8NHEce-MUUzPc_Upn0ZKRi3iCZ6fA4BQ@mail.gmail.com>
References: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
 <1318095407-26429-7-git-send-email-artagnon@gmail.com> <CALUzUxo=xN735+=Yz9eS_VSW3fpiTeng9s-66qM0Jno40-DPXQ@mail.gmail.com>
 <CALkWK0kA=zhpsmYhjMwv11xyHNhA0Ps=BjUDao0+HFLMKnADUg@mail.gmail.com> <20111009085306.GA9209@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 11:18:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCpWT-0005xD-GA
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 11:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab1JIJSN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Oct 2011 05:18:13 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50614 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046Ab1JIJSM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Oct 2011 05:18:12 -0400
Received: by wwf22 with SMTP id 22so7808003wwf.1
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 02:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2Sce+xWPCgaVsREOpzuCNpmgWYyqBgYRpfz149sfrIw=;
        b=M2BaeOrV5QJeRJWjiN3AhfjUO3OSXsXUlxxCTpycX1niBcyf8DNykVNUyp7Gganc4p
         9lpyCU7DEmb3401xpC+Zf3kgawuQroDmaEYuOmnIp5nGC9Vxt8hpiGabXASex4G4NHeT
         Bhp4GFl1tUQf82LRMb+gRum+1Ih6xPIEG0RGA=
Received: by 10.216.190.131 with SMTP id e3mr4896149wen.48.1318151526242; Sun,
 09 Oct 2011 02:12:06 -0700 (PDT)
Received: by 10.216.51.207 with HTTP; Sun, 9 Oct 2011 02:04:40 -0700 (PDT)
In-Reply-To: <20111009085306.GA9209@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183192>

Hi Jonathan,

Jonathan Nieder writes:
> More important than the idiom is the intent. =C2=A0Presumably that in=
tent
> was something like "I wrote the commit message, so if it makes you
> scratch your head, blame me, not Jonathan; and I made some other
> (minor) improvements, so consider blaming me even if it's the
> functional part that makes you scratch your head."

Exactly.

> Sorry I haven't had a chance to look over the patch yet. =C2=A0Is it
> supposed to introduce a behavior change, does it prepare for some
> future change, or is it just a cleanup?

Prepare for some future change.  See $gmane/179282 for original discuss=
ion.

-- Ram
