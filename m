From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Mon, 5 May 2008 20:02:46 +0800
Message-ID: <46dff0320805050502l5a456b69oe621ebad28b8eb63@mail.gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
	 <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-4-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-5-git-send-email-pkufranky@gmail.com>
	 <7vy76rtfns.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>
	 <alpine.DEB.1.00.0805041040560.30431@racer>
	 <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
	 <alpine.DEB.1.00.0805051249520.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 05 14:04:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JszQP-0008W2-LM
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 14:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbYEEMDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 08:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754868AbYEEMCv
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 08:02:51 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:39519 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbYEEMCr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 08:02:47 -0400
Received: by an-out-0708.google.com with SMTP id d40so535321and.103
        for <git@vger.kernel.org>; Mon, 05 May 2008 05:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=c3kmByNtkQ3YQBnCvYtcOWhcoOtTECOxLq6RDOzYt88=;
        b=o8BP6V1gIJ4brgcyWy8kaxXOOsyiZlMbZHlAIwh0u/J4OHUxsPvimLyCOe/6WAXX5nt94ITmLE1ind/tDjKPVtFQjYfP8g37OEjCguSVjClV/1YV0YwzcTNvsEiXNxt+A9stmXcjV1yBo+hnYInhnWfUM6XWz21NrDWSb+kD9xg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RUt681rVmAX3eMJRJQcfnTj1n1wPa6IW53dDtiHGfz61Jz0+dhLHbpfZxL4jmP9eclI+355Z4556B+538PNkT3t5fjF9xva6DxuYWofiI8kl0Uqzxu6Y0v/teLrE9srgDFxxS3SO6qcPZ/7kzoBpzwEwb/1giQDtmbcW1kFxIcI=
Received: by 10.100.91.17 with SMTP id o17mr7417280anb.90.1209988966743;
        Mon, 05 May 2008 05:02:46 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Mon, 5 May 2008 05:02:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805051249520.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81271>

On Mon, May 5, 2008 at 7:51 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>  > >
>  > >         The quick,
>  > >         brown fox
>  > >
>  > >  vs
>  > >
>  > >         The fast
>  > >         , brown fox
>  > >
>  > >  IMHO the layout of the new version should be retained, i.e.
>  > >
>  > >         The /quick/fast/
>  > >         , brown fox
>  > >
>  > >  should be shown.
>  >
>  > Why not
>  >
>  >   The <r>quick</r><g>fast</g><r>,</r>
>  >   <g>,</g>brown fox
>
>  I might well be a complete idiot, but your <r></r><something> example is
>  way harder for me to read than my example.
>
>  And of course your example would still be wrong: the "quick" and the comma
>  would not be separated at all.

So i am an idiot too -:). Should be

 The /quick,/fast/
 //, /brown fox


-- 
Ping Yin
