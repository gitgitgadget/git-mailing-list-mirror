From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now incompatible with Cygwin (and probably Windows)
Date: Wed, 28 May 2008 19:46:15 +0200
Message-ID: <bd6139dc0805281046n3d811b83l1a1c15cc6e2d8122@mail.gmail.com>
References: <483AC2CE.7090801@gmail.com>
	 <7vy75vvtxo.fsf@gitster.siamese.dyndns.org>
	 <32541b130805280933r573d59d0mf9cdc09f5e5a6a17@mail.gmail.com>
	 <7vfxs2uytm.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"Mark Levedahl" <mlevedahl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 19:47:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Pjx-0005IQ-6M
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 19:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbYE1RqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 13:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbYE1RqQ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 13:46:16 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:1352 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbYE1RqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 13:46:16 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2632770wfd.4
        for <git@vger.kernel.org>; Wed, 28 May 2008 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=mLZXtg5/P0FXxek2xUo1LCskf0P+WcOyin0qeAXNMG8=;
        b=VQuS7A9GUq/doqdCjXqKBOQQbRpul8fmSWGl6zup02gaqYYpQ9m61WqVYyqVolymZQOJmRQvhLeoAw0K8EbLoAotwxXUkselN+cWHEGQf1mPJfZcBVcUZt8wiqU9OdnIi6M5Eq7zNWHvk75QmylGuTYQXZxfxI99iV21YL3e8W4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rW0q7vC7q0WSvPNYWOlmWz79UyvWIt2IjarrGPuw6SI2Sd6uwoHcX/g4JxsG2SOchZjBF2coamZodJNbhyRxD5diuBKL6QorqxPaWSYD2SWf2mWKhwLSM4h29lBtEO1BB+B/8BNhGrkioXZOLsx1Ztf+TNMxOhIMGauV7Z1sHyo=
Received: by 10.142.188.3 with SMTP id l3mr631446wff.174.1211996775826;
        Wed, 28 May 2008 10:46:15 -0700 (PDT)
Received: by 10.143.10.16 with HTTP; Wed, 28 May 2008 10:46:15 -0700 (PDT)
In-Reply-To: <7vfxs2uytm.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83116>

On Wed, May 28, 2008 at 7:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Please learn to think before typing, let alone sending such a message to
> waste other people's time.

Why so harsh?

> What alternatives do you want to implement?  Certainly not silently
> creating "nul-garbage" file instead and pretend that nothing bad happened,
> as that would lead to madness.

Or instead we could have a '-f' switch or such with checkout that
allows you to checkout a revision that contains a bad file, but with
that file missing. Of course this needn't happen silently, a big
warning saying "could not checkout file %s because of %s" may still be
issued.

-- 
Cheers,

Sverre Rabbelier
