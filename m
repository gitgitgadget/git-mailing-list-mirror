From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Documentation: replace [^~] with escapes everywhere
Date: Mon, 15 Sep 2008 20:10:08 -0400
Message-ID: <32541b130809151710j59963af9id84b3c1553ec738d@mail.gmail.com>
References: <1221470398-8698-1-git-send-email-trast@student.ethz.ch>
	 <1221470398-8698-3-git-send-email-trast@student.ethz.ch>
	 <32541b130809151656n4f39018fu2045eb6280d6da00@mail.gmail.com>
	 <200809160205.23371.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Sep 16 02:11:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfOA3-0002p9-7x
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 02:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbYIPAKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 20:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754150AbYIPAKL
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 20:10:11 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:52571 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998AbYIPAKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 20:10:09 -0400
Received: by mail-gx0-f16.google.com with SMTP id 9so26255819gxk.13
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 17:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=y9TLamZAS2Ot0zbhaKoyYy+GbT/P/eA1xsiakq+R3m8=;
        b=Dt9Uw5olrJe/XJlvRhdcUlcX6JWzx/FASLNUUVU2CLKlP9QNT586gEFLNy9yfv1Ia9
         C6KlLwUzmE/BKr1EyrmOH23OZoHitRAMRBYQn28m9IKCO4iFLdgC4wHQ2Yn1+98cAlyr
         9J9hivSz4QADmLmwLbMz3DZapzm7ePKxfFk5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NB/hSt35o9ibNmLSbDkC+aG+82HtKa5wLAap7aek6ngU/A7wSvKqeSloQO1GJBd38S
         2zPpGMqDCbgkPS86d2mG1S2vww51tCKupzaeVv89hpopWMcfNGbyVXJyJXofc2Pdk6ra
         4GmLGppG4k7z6mOVS1FeyWBUPiV0WVfzUEl7s=
Received: by 10.151.156.15 with SMTP id i15mr380508ybo.184.1221523808991;
        Mon, 15 Sep 2008 17:10:08 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Mon, 15 Sep 2008 17:10:08 -0700 (PDT)
In-Reply-To: <200809160205.23371.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95964>

On Mon, Sep 15, 2008 at 8:05 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Avery Pennarun wrote:
>> Rather than uglifying all the documentation to work around the syntax,
>> perhaps we just want to disable subscripts and superscripts
>> altogether?  I can't really imagine the git documentation needing
>> them.
>>
>> To do so, we can add these lines to asciidoc.conf (I just did this on
>> another project yesterday, but I haven't tested in git.git):
>>
>> [replacements]
>> # Disable superscripts.
>> \^(.+?)\^=^\1^
>> # Disable subscripts.
>> ~(.+?)~=~\1~
>
> That's indeed a far superior solution.  I withdraw my patches in
> favour of this.

Er, do you mind submitting (and testing :)) a new patch that does it?
I don't have time right now.

Avery
