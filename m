From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: Fast staging/unstaging of hunks/lines
Date: Mon, 12 Apr 2010 19:55:08 +0200
Message-ID: <j2s36ca99e91004121055x5cb37d3er423bdfda5aa70702@mail.gmail.com>
References: <7ed246d74b2ea872a4af3b99d519590ab17ffefc.1270457921.git.bert.wesarg@googlemail.com>
	 <201004112101.54908.j6t@kdbg.org>
	 <q2m36ca99e91004112349l9e336fffl7e69bb75bce07a40@mail.gmail.com>
	 <201004121945.16216.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 19:55:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Nqx-0005kj-Vx
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 19:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234Ab0DLRzM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 13:55:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:33954 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab0DLRzK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 13:55:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1617800fgg.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/bQXcmcR7hKpFD0T7ZBtUD+0bbQ18VyrP+XdHE5WEbM=;
        b=EIq3a7r2m5VLkKYaiRNN3vwL4fEOl4pJGfzFfYVBhVMKCdKp30dGAaSdfZKU2SGSgm
         ZrlwfTthX18/J/d7MXdd/zrxFzdMfPZncK3NheWyrdb3Zpud3ai/wxB9CjpJ/FScZIP9
         uznZ0zyZFrIfrjYwqevkFzDMg/9Q1iAkU7JNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UXKJnw1ZA1mjNRlHvM8S5W20zflUgm+38UAtlZcsfX9svKFb3cdhwOwq4jt5SkSw1g
         dOSs2PW8JBAXbD8wep7UU8P+j7XM83q/EKUyD5/Mb5nUmyK5EL6+LWhPtKkHbmg0R6U5
         30Rh4pFATKl6AvJV53wcrp2l9DtA4A4j+cUSU=
Received: by 10.223.111.7 with HTTP; Mon, 12 Apr 2010 10:55:08 -0700 (PDT)
In-Reply-To: <201004121945.16216.j6t@kdbg.org>
Received: by 10.223.5.5 with SMTP id 5mr2755764fat.80.1271094908449; Mon, 12 
	Apr 2010 10:55:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144760>

On Mon, Apr 12, 2010 at 19:45, Johannes Sixt <j6t@kdbg.org> wrote:
> On Montag, 12. April 2010, Bert Wesarg wrote:
>> I don't feel comfortable with this ambiguity myself. I see two ways =
to
>> solve this:
>>
>> =C2=A0 =C2=A0 a) Use Shift-Button-1 for lines
>>
>> or
>>
>> =C2=A0 =C2=A0 b) Use Shift-Control-Button-1 for lines
>>
>> and make Control-Button-1 only stage hunks.
>
> That's worse, because you need Shift-Button-1 to extend a selection.
>
> The problem is that the X-Windowsy way to overload single-click opera=
tions.
> Personally, I prefer to get an operative response only on double-clic=
k. It's
> still unused, I think.

Good idea. But I fear that you can loose your selection, if you move
the pointer accidentally while double clicking. Its still worth to try
this.

Bert

>
> -- Hannes
>
