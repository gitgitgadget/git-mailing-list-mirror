From: "Miles Bader" <miles@gnu.org>
Subject: Re: [PATCH 1/3] git-bisect: war on "sed"
Date: Thu, 15 Nov 2007 20:00:14 +0900
Message-ID: <fc339e4a0711150300n64b9d670o1e183553a9de0cba@mail.gmail.com>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org>
	 <7voddv6fxz.fsf@gitster.siamese.dyndns.org>
	 <buozlxfeu0z.fsf@dhapc248.dev.necel.com>
	 <995F69D5-4ABC-44E7-BA2B-5E276479EDA1@wincent.com>
	 <buotznnesw9.fsf@dhapc248.dev.necel.com>
	 <86tznn4y7v.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Wincent Colaiuta" <win@wincent.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Christian Couder" <chriscool@tuxfamily.org>,
	"Ralf Wildenhues" <Ralf.Wildenhues@gmx.de>
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 12:01:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IscSi-0007cm-9Y
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 12:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbXKOLAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 06:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbXKOLAR
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 06:00:17 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:10227 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbXKOLAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 06:00:15 -0500
Received: by wr-out-0506.google.com with SMTP id 36so498939wra
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 03:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=d9arTt9EWa7r4vwzK6iPCTf16mETDRgvW/M2VNeTKmQ=;
        b=rtuP+5fNpCIsHVA0+s1tOyCnkTXuGXKZ4bidHyMK4QsAzfPTMR9fCu2w1pOO5FG+9+SajL6+TcxAgSQR/jxI/1G2RgWyZGr15Vdw+Zoo5KDG5LYWbd/kxC1OZ9Wp4fXfa2RCODxLDgBA4oJzffYMeq6J5gRRJugYrJPKaDML9Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ED4vQfTavSjwzIEvcTOo9pBsPMxUA8BmhHsQl8VfxSaTkuCZ9Oa+i0R99uE80mKHblxvXoBZS/VxZD7pPVmz3DKlAQ90NmthRAEYwCxTGdBIQpx6puk5ag4gqpyb0MfXNthzt2S/sIbB4Wo9JR4gOWz65WzIbcbpeSxNKj6Mr8A=
Received: by 10.90.94.2 with SMTP id r2mr911186agb.1195124414695;
        Thu, 15 Nov 2007 03:00:14 -0800 (PST)
Received: by 10.90.63.8 with HTTP; Thu, 15 Nov 2007 03:00:14 -0800 (PST)
In-Reply-To: <86tznn4y7v.fsf@lola.quinscape.zz>
Content-Disposition: inline
X-Google-Sender-Auth: 5994d4f01b95782e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65106>

On Nov 15, 2007 7:09 PM, David Kastrup <dak@gnu.org> wrote:
> > Er, I suppose -- if you are acquainted with that particular shell
> > variable syntax (I suspect knowledge of sed is far more widespread).
>
> sed is rather bad with regard to portability.  If you take a look at
> the respective portability section in the autoconf file, it is almost
> longer than that of Bourne shells.

I don't think that's really a fair characterization -- almost all of
the autoconf sed portability caveats concern weird corner cases in the
dusty corners of the language (and some are "common" issues with other
tools, i.e., avoiding ^ and $ inside of regexp groups).

For typical straightforward usage, there seems little problem.

[The main portability problems I've actually _noticed_ with sed are
the "-e" versus ";" issue and what happens with "\n" in various
contexts...]

-Miles

-- 
Do not taunt Happy Fun Ball.
