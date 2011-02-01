From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Tue, 1 Feb 2011 02:00:05 +0100
Message-ID: <AANLkTi=boNXZbryTGFth5igZ771BbTmEKmh7LOxko+T-@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home> <20110131210045.GB14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311621150.8580@xanadu.home> <20110131231210.GD14419@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 02:00:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk4bz-0001Sq-L3
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 02:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535Ab1BABAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 20:00:47 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64954 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272Ab1BABAq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 20:00:46 -0500
Received: by gyb11 with SMTP id 11so2243581gyb.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 17:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=IcY2I51+ht6RyriVXuGyVw9seyUKd3JG+oi47Dq1wKE=;
        b=L2zQuVDm1EZ4W2iktgLUi/oWjQPRaTNOdBNb6QH0DpRu7R1yKgeIi2hcHQsRYnRqFQ
         whva5FrAPqbbKex0+VqvEGuLuSQYbJCtTyzWEiIkLTl+rcYTDMXPj/diGzz+9JR2Ny5R
         l1cYGyB8pNIiBR4nI89me3AkSNlRb5hjBBOY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=EpoQTAl0sshSnLOdsrAd8hb6xsVAgz20zp8o8POAhFvRlMx1PZyatxXb51FgicVd3L
         jjTP2wsVXvk9xPX+rctGxG7QpQdsJY+H4jfJabfA1kJUCHFoBSz32a+zl9ZJfHoLNRfj
         bk5ymFlmjamzTRDUvUI/eyIAQ4f5PyM3MzAdc=
Received: by 10.151.45.17 with SMTP id x17mr8466906ybj.304.1296522045780; Mon,
 31 Jan 2011 17:00:45 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Mon, 31 Jan 2011 17:00:05 -0800 (PST)
In-Reply-To: <20110131231210.GD14419@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165784>

Heya,

On Tue, Feb 1, 2011 at 00:12, Jeff King <peff@peff.net> wrote:
> [1] I'd be interested to see how much we can get around that slowness
> using a notes-cache.

Do you mean something like a refs/notes/renames namespace in which we
stick notes on commits indicating that a rename indicated at that
commit, with an option of the user, after-the-fact, adding this
information manually?

-- 
Cheers,

Sverre Rabbelier
