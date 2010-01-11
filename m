From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] string-list: remove print_string_list, since it is not 
	used anymore.
Date: Mon, 11 Jan 2010 20:34:02 -0200
Message-ID: <a4c8a6d01001111434j18b77b88j525b9acb47c7e100@mail.gmail.com>
References: <1263245389-1558-1-git-send-email-tfransosi@gmail.com>
	 <alpine.DEB.1.00.1001112252040.4985@pacific.mpi-cbg.de>
	 <7v3a2ccmrg.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1001111722150.10143@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 23:34:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUSpx-0003B2-AC
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 23:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab0AKWeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2010 17:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150Ab0AKWeG
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 17:34:06 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:33655 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab0AKWeF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2010 17:34:05 -0500
Received: by ewy1 with SMTP id 1so3819243ewy.28
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 14:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P0rY2UDT5rOu8JknEu6U3jouwlVbx0Vqf2lHV8FVVGM=;
        b=Lc6RTbZMz/QSJ7fftP3kAReooR0E0thacHK1ZeOXcqZLrXnEHGrI6TFs+gPlElz1m5
         seZaKYY3rcrYxDJEZv+PFnZglg9tvRcudz24+4m7mZdlAYCzmjPhwXh5LJhJa6O4i03P
         fb1Xb9J+hYQEW6jDCrZB7UTbGoWTL+wL1vwXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UdO/7StmnVPr/oIVVpWH5Oej0xFyvq5RybQR07cO4p0CcB2Vms0QYVD/VG01yJYXbu
         U3nywLB42AoeOKdxRB+VdpOnG7mLUsiKM6/3k72xTwqIE+90ATWRv43+YbCpMMoNHUq0
         QLy98aBYRkP9TE2WuLS5KAEf+ndDYlvk8xLwE=
Received: by 10.216.90.1 with SMTP id d1mr245521wef.136.1263249242543; Mon, 11 
	Jan 2010 14:34:02 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001111722150.10143@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136673>

On Mon, Jan 11, 2010 at 8:23 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Mon, 11 Jan 2010, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > On Mon, 11 Jan 2010, Thiago Farina wrote:
>> >
>> >> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
>> >> ---
>> >
>> > It was never used, except for debugging. =C2=A0Does it hurt you re=
ally all that
>> > much?
>>
>> Exactly my feeling.
>>
>> I think I discarded at least two other patches sent to me to remove =
this
>> "unused" (but obviously meant for debugging) function in the past. =C2=
=A0I
>> guess we'll keep the function this time, too.
>
> If so many people are so inclined to discard it, then maybe a little
> comment could be added to explain its existance?
>

I can add the comment if Junio is ok with it. Something like this:
"This functions is for debugging purpose only. Please, do NOT remove
it."
