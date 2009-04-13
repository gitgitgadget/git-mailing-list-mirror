From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3 09/13] send-email: Remove horrible mix of tabs and 
	spaces
Date: Mon, 13 Apr 2009 17:49:55 -0500
Message-ID: <b4087cc50904131549sec5acc4m7201b1411245b95f@mail.gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-10-git-send-email-mfwitten@gmail.com>
	 <7vab6ke0ip.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 00:51:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtUzz-0003Tg-UU
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 00:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbZDMWt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 18:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbZDMWt6
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 18:49:58 -0400
Received: from mail-qy0-f117.google.com ([209.85.221.117]:51740 "EHLO
	mail-qy0-f117.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbZDMWt5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 18:49:57 -0400
Received: by qyk15 with SMTP id 15so203122qyk.33
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=D/VoqWhD3n11DfJFUR+vl663FRcMwPXzThXDKEudscc=;
        b=E39HwZTlkReewLbCC3T7Sk5UHT+/DE7BMmo42QTEQ7JnUFSMX+tn3K9/AjIrVPNcXL
         Z3CQ4h04HokSPJp2r2/ciYWU+bSMQZ3gV++doXIBX+/aFT1PoAnNgu4NlPRHemHYsxXh
         qBWra57vENNC168/qKOLDJq/7tD821o3V0Q3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Y9eL1iZaIXdc9iYUZxIn6chdZp3RVxT5SdnqOsvd04g62kaYqyfg9dS3+tCVqoS6fp
         OSGSjIqK1zeJ2Fg3wLDNRN0E5QormBvT6a8NuakUNP7icWl90WvcYZinc6OfIRVJPfcy
         eAgN+zyZbabfLgg7bC7vYVOhRdZf8YVrmU5mU=
Received: by 10.224.61.20 with SMTP id r20mr6745446qah.249.1239662995979; Mon, 
	13 Apr 2009 15:49:55 -0700 (PDT)
In-Reply-To: <7vab6ke0ip.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116500>

On Mon, Apr 13, 2009 at 15:55, Junio C Hamano <gitster@pobox.com> wrote=
:
> Michael Witten <mfwitten@gmail.com> writes:
>
>> Currently, no lines match the following:
>>
>> =A0 =A0 [\t]+[ ]+
>> =A0 =A0 [ ]+[\t]+
>
> I understand the latter but what's wrong with the former? =A0The widt=
h of a
> HT is by definition 8 columns throughout the git codebase.

Ah, well, the width of a HT has been a free variable in my
calculations; I was operating under the assumption that whitespace
used for indentation can float freely according to the user's
settings. A few of the lines were aligning function arguments via tabs
and a few extra spaces, which is not reliable in my model.

=46rankly, I don't like tabs and spaces sharing the same contiguous
block. I don't like it all. ;-B
