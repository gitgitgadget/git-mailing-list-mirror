From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] send-email: Add support for SSL and SMTP-AUTH
Date: Sun, 2 Sep 2007 21:06:17 +1000
Message-ID: <ee77f5c20709020406p491ef90eoc2c6096db6e6e04e@mail.gmail.com>
References: <11887028854022-git-send-email-doug@11011.net>
	 <7vveatpklg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Douglas Stockwell" <douglas.stockwell@gmail.com>,
	git@vger.kernel.org, "Douglas Stockwell" <doug@11011.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 13:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRnHd-0003Xt-55
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 13:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbXIBLGT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 07:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbXIBLGS
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 07:06:18 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:17368 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932383AbXIBLGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 07:06:17 -0400
Received: by rv-out-0910.google.com with SMTP id k20so724208rvb
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 04:06:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ShIfB+LmukVPifov3mndW8zBWBqs4AQIujrEit/AXRK2ecbtwWZhkbnJxKDQeQGvGsmtZ83zKe8Lz+Am8bbmdRTMP98em+l/DmGEF1X366TdoUJ5mN/XY3RJmLOabUQ/7tePMVmFCGn7vYbtdKTMt5oAHGb6hZWFkCm/I3rvl3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LG+8AJI2K+t0TsW1tz2okPYnv9XGTuhPzmTQl1KVKse8ZESC4H2ky+6wXjAtuAQGYVh5NnIHsZRE/klBBtpzNBM7Py6UjFwt+1W3e72eVwedpb8VY9UuYahchMPX4WiwCGql+PYdRJ875Adlpd4zzRZgQdCcH6fXqvNa0tShBPg=
Received: by 10.141.209.7 with SMTP id l7mr1531266rvq.1188731177305;
        Sun, 02 Sep 2007 04:06:17 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Sun, 2 Sep 2007 04:06:17 -0700 (PDT)
In-Reply-To: <7vveatpklg.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57316>

On 02/09/07, Junio C Hamano <gitster@pobox.com> wrote:

> So it might be better to split the configuration variables in this
> way:
>
>  (1) in ~/.gitconfig (that is hopefully readable only by the
>      user):

Perhaps git should then start warning if ~/.gitconfig is world (and
probably group) readable/writeable, a la ssh's ~/.ssh/X (for various
values of X)?


Dave.
