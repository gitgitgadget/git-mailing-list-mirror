From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 3/4 v2] Add tests for .git file
Date: Wed, 6 Feb 2008 10:30:16 +0100
Message-ID: <8c5c35580802060130i12fc261aqbe9c136f26218188@mail.gmail.com>
References: <7vfxw66a0s.fsf@gitster.siamese.dyndns.org>
	 <1202284583-24478-1-git-send-email-hjemli@gmail.com>
	 <7v7ihi32bv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 10:31:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMgcK-0002vO-Fq
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 10:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760840AbYBFJaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 04:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760839AbYBFJaY
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 04:30:24 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:61695 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760788AbYBFJaX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 04:30:23 -0500
Received: by wa-out-1112.google.com with SMTP id v27so362820wah.23
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 01:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=l9epoKTSSCROwo25OshZ/KNwyQpUGP3qvc5BcOBJIaA=;
        b=lDeC36bO3Kk3yqcrcuAUPy6pU8tRW8s0/c4kAJRjrTFmKhWMRbSlfgbdSZ6mIaKKJ1Eb1G6etAeEZkIu49cYMtVBb8DgZMMq3AUC19dgkGOIFDKN1F1XdpzvHl9st+QqRBTiT0SixsKCcFWXoEU2pBe+7jBLDxSiooNjb6YU2Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dQjZUBBAN3jPqx4KSyKxu15Zm6//4QHOksnWiJAXszsJCm/g1Q+oa4wHSQdIoFXHhNinWkDN4E5MzQ9Fs7O+3QEoON2Ad2LCig11B774SdsJ+n82a01jEn8g9roGxhWXFPBG9pQiSGzuHaHb1aUjEViYZ15wSAyNXmwb+FrgpJI=
Received: by 10.115.88.1 with SMTP id q1mr3376095wal.98.1202290216313;
        Wed, 06 Feb 2008 01:30:16 -0800 (PST)
Received: by 10.115.73.7 with HTTP; Wed, 6 Feb 2008 01:30:16 -0800 (PST)
In-Reply-To: <7v7ihi32bv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72781>

On Feb 6, 2008 9:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
> > +objpath() {
> > +    echo $1 | sed -re 's|(..)(.+)|\1/\2|'
> > +}
>
> "sed -r"???  Please limit ourselves to the basics.

Sorry, I didn't realize 'sed -r' wasn't kosher. Should I resend or is
this something you'd --amend?

--
larsh
