From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [RFC] Use cases for 'git statistics'
Date: Wed, 21 May 2008 22:52:16 +0200
Message-ID: <bd6139dc0805211352r264e61aeva196dd5f3c0ff1ec@mail.gmail.com>
References: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com>
	 <200805121440.12836.jnareb@gmail.com>
	 <bd6139dc0805120604m349b1fbbr39c6dcb8d893e771@mail.gmail.com>
	 <200805131507.04912.jnareb@gmail.com>
	 <bd6139dc0805130637saf704e1v2ab67c99da3078c3@mail.gmail.com>
	 <7vlk29er1w.fsf@gitster.siamese.dyndns.org>
	 <7vprrf4lar.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 22:53:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyvJH-0003QV-8W
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 22:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944AbYEUUw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 16:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbYEUUw1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 16:52:27 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:13985 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYEUUwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 16:52:25 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1766052ywe.1
        for <git@vger.kernel.org>; Wed, 21 May 2008 13:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=5orPgNvbH9mQVaHoJ9YPjtPJhwIYWgmSvwHZfmcrVsU=;
        b=tEDl4D7wMXYaH/qRk/x1FEji9CbqQ3pbRJH2k4DY2jG4XRv/KFiR0OqGmF1y9NOXp88Yjb+R06unaVhPZGWsGjYq2qslGwKcfT8zuMNQciWn9eR1HJmoWAs3fFiIP6J0LY47LZ6zaWbQrUOJy6vMB9HitnhxoSQkI/uCtXQTdmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=VT4QsW595FdWihqr6LGz0o0nLzMEc5fGRR+BkQH4S76Nz9xVEbjW30mXg/4VRh+HHGLDbXC5etNWWIRbW7Mdjiydv/fZFuEi5al2IGorrVfIAasXRo/Lnqv7DAv7SMV7eqRZyATj+/Ta1YUQszaw6i0PA+iEyzwuMJRsbmSSvGs=
Received: by 10.142.171.6 with SMTP id t6mr4078165wfe.173.1211403136218;
        Wed, 21 May 2008 13:52:16 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Wed, 21 May 2008 13:52:16 -0700 (PDT)
In-Reply-To: <7vprrf4lar.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 83b606edddc9214a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82582>

On Wed, May 21, 2008 at 7:30 PM, Junio C Hamano <gitster@pobox.com> wrote:

> I just realized another thing about "the source of trust".  The
> "statistics" would count _only_ what gets accepted, but maintainers and
> list participants have much richer set of datapoints to judge the
> strengths and weaknesses of contributors --- rejects.

I think I know where this is coming from and what you say makes sense.

> An early round of contribution from somebody needs deeper review if the
> contributor has a history of taking many rounds of refinements to get a
> rather trivial change into an acceptable shape.  IOW, over time people can
> learn who are meticulous and who are careless from rejection counts, which
> is not recorded in the committed history.

Yup, in order to gather that kind of data a more elaborate tool (one
that is integrated with a review tool like Rietveld or such) together
with the VCS would be required. I'm confident that this project will
result in useful statistics. Perhaps they will not be enough to
determine which patches to let in and which ones to reject without
human interference (I'm actually quite sure that won't happen), but I
do think other useful statistics may be gathered and used
nevertheless.

-- 
Cheers,

Sverre Rabbelier
