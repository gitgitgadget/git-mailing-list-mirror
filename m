From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 2/6] send-email: --smtp-server-port should take an 
	integer
Date: Sat, 11 Apr 2009 16:07:08 -0500
Message-ID: <b4087cc50904111407n27aea57n22772c09557f177@mail.gmail.com>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
	 <7vvdpbf11m.fsf@gitster.siamese.dyndns.org>
	 <200904111501.05734.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Sat Apr 11 23:08:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LskRR-0000Ib-6D
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 23:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758824AbZDKVHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 17:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759401AbZDKVHL
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 17:07:11 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:32941 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759414AbZDKVHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 17:07:09 -0400
Received: by qyk16 with SMTP id 16so2996708qyk.33
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 14:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ge0Y/cFZIVhtpmYFkQF+9M2xUJWyEkmkSWxc6A5xVdU=;
        b=mp6F3QK8EPVVrvc1KGXPmO5lg+wvqreGKsremPi25VS3f4YdSk/YQRPsRvfju3lUX7
         3OYJT5BpftORfzV9tfZCDxPF678f8Ob8qf6S/M792SprrmNG4pSHNbrxcq/czT/Ifzc4
         HL7+JGnTQQasr5Gk7+3F2pMQ2JkBrBcLg1Fug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ME4aK0snKQrPzduDzxMC0VznXHY+7TfWExJDLYwD//Qh6oBT4GluEV1jm7VJPPdMGA
         2AoEeQFBPozpvN8ayWxzDlzbxC8cHHYAi2a0uT/5OH3Un6++kyfaY5fDHPcfnWvUxq0c
         /cbbWJ8Piuk10O03aEB8oE0lh2zIKvNJQDzjo=
Received: by 10.224.11.17 with SMTP id r17mr4960147qar.346.1239484028444; Sat, 
	11 Apr 2009 14:07:08 -0700 (PDT)
In-Reply-To: <200904111501.05734.wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116350>

On Sat, Apr 11, 2009 at 16:01, Wesley J. Landaker <wjl@icecavern.net> wrote:
> On Saturday 11 April 2009 13:22:29 Junio C Hamano wrote:
>> Hmm, I have to wonder if there somebody who is using symbolic names for
>> ports, e.g. --smtp-server-port=ssmtp which this patch may start
>> rejecting.
>
> An common example is --smtp-server-port=submission (for 587).

Clearly, then, this patch is no good. Consider it thrown out.
