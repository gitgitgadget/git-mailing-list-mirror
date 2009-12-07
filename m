From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [RFC PATCH v3 0/8] Remote helpers smart transport extensions
Date: Mon, 7 Dec 2009 13:57:37 +0100
Message-ID: <40aa078e0912070457i16394913v5ff041061ec9eeaf@mail.gmail.com>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
	 <7v7hsz9qxj.fsf@alter.siamese.dyndns.org>
	 <20091207210608.6117@nanako3.lavabit.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 13:57:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHd9s-0007HB-Dy
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 13:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934104AbZLGM5d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2009 07:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755722AbZLGM5c
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 07:57:32 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:54617 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755126AbZLGM5c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 07:57:32 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1124329eyd.19
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 04:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8wSTfcA2ghvx1ahWW82sYURgte2gVylK067YVd+aEUE=;
        b=UE8Z+gwvxbH1SW4eweaPDMmx0hU6ElpeSAaRxgtMzYOAw/91wajmfGfNuMj8V/gH7f
         o6PzupNbDZwa6Le0O1JsyyTIYOmbv5f4Q/UoTDj9hfPaELbaMm7yE+Ohb7xsYhK1N+Fz
         yrZdPXXVdR2NNc47LufVpAhRab0By6pcszlnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=HyhuRHeHk8DzEFhLx508IkRtmHhmVDnq7B3KifIiOPkQwd1crHlRh6NT5BF/RyygJq
         Mi5LWwjk+YC3DRXUSV/89De+hkD7o902OErkvMXTjv6AH7h1OizDN80P/B/NTs7VAC98
         1V4GAtvcRsz+pHmNGMxcNbcGTqvIDWd/CRInQ=
Received: by 10.216.86.139 with SMTP id w11mr2333553wee.10.1260190657607; Mon, 
	07 Dec 2009 04:57:37 -0800 (PST)
In-Reply-To: <20091207210608.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134755>

On Mon, Dec 7, 2009 at 1:06 PM, Nanako Shiraishi <nanako3@lavabit.com> =
wrote:
> Quoting Junio C Hamano <gitster@pobox.com>
>
>> I queued to ease the discussion in 'pu'. =A0I had to fix-up some con=
flicts
>> while doing so. =A0Please sanity check the result.
>
> I see that you changed many "char* variable" to "char *variable", but
> what is the reason for these changes?
>

Documentation/CodingGuidelines:

 - When declaring pointers, the star sides with the variable
   name, i.e. "char *string", not "char* string" or
   "char * string".  This makes it easier to understand code
   like "char *string, c;".

--=20
Erik "kusma" Faye-Lund
