From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Sun, 9 May 2010 06:35:27 -0400
Message-ID: <AANLkTimDIPJpwpAJPTBIYK6QLwfBBpYP0w2RTvKbRys5@mail.gmail.com>
References: <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org>
	 <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org>
	 <384AA932-227B-43B0-9D38-560A3567918A@gmail.com>
	 <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org>
	 <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com>
	 <alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org>
	 <20100508204934.GA25566@dpotapov.dyndns.org>
	 <alpine.LFD.2.00.1005081450260.3711@i5.linux-foundation.org>
	 <20100508234222.GA14069@dpotapov.dyndns.org>
	 <42C31791-ACD3-4D43-99E6-287F9E63EDAB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 12:44:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB401-0005iS-It
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 12:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab0EIKfa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 May 2010 06:35:30 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:52407 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab0EIKf3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 06:35:29 -0400
Received: by wwa36 with SMTP id 36so921103wwa.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hqr95dSBWgWBKutBvCs1Ctnq+y1CCAghX/XwABUlOMs=;
        b=U3OH0xIofki0WfXLvN14dCBsTu2wG/i5K53FSpCNukoJ6pNMMXP9xNszi6VupLsPni
         rp4kGJP55XAw60rkoROYm3MHdpUbOU3wdRNRHMDAd8CkH22vTUNWIjAQ4YW/kiaG80e7
         FSIMvFXzdd81OiPpyKTN5KvlRnwLmMQRPG6v4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xXf3p7PtIBz9x49ysVIDzageXHzIZbsZ+iviSk+h7TyTJyWdmigPR4KXj4CWNYZ5Vj
         efHOHD0q6T7TO+2ktSO965yRwiTTp+ICLcW2anhIf51RNRZAxHVk+VR5m/9IJxjQ6Tlu
         H0LbTZLAxc7+eLLE4llqQs+aoq5+2ptJbDq00=
Received: by 10.216.86.145 with SMTP id w17mr1418114wee.216.1273401327927; 
	Sun, 09 May 2010 03:35:27 -0700 (PDT)
Received: by 10.216.7.207 with HTTP; Sun, 9 May 2010 03:35:27 -0700 (PDT)
In-Reply-To: <42C31791-ACD3-4D43-99E6-287F9E63EDAB@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146718>

On Sun, May 9, 2010 at 3:49 AM, Eyvind Bernhardsen
<eyvind.bernhardsen@gmail.com> wrote:
> On 9. mai 2010, at 01.42, Dmitry Potapov wrote:
>
>> On Sat, May 08, 2010 at 02:54:35PM -0700, Linus Torvalds wrote:
>
> [...]
>
>>> You could talk about "binary" vs "text", and it would make sense, b=
ut your
>>> argument that "eol" is somehow better than "crlf" is just insane.
>>>
>>> So I could certainly see
>>>
>>> =C2=A0 =C2=A0 =C2=A0*.jpg binary
>>> =C2=A0 =C2=A0 =C2=A0*.txt text
>>>
>>> making sense. But "eol" is certainly no better than "crlf".

Linus - Perhaps I missed this, but where would you this typemap exist?
I like this sort of prescriptive approach; out of the box users would
get a bunch of reasonable defaults, but they could customize it by
adding/changing them.
