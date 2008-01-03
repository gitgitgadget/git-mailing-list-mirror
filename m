From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Avoid a useless prefix lookup in strbuf_expand()
Date: Thu, 3 Jan 2008 11:06:21 +0100
Message-ID: <e5bfff550801030206h1230f203oda58d168c9882b1c@mail.gmail.com>
References: <e5bfff550712300546o167c460bl4628d87f8a4e14db@mail.gmail.com>
	 <477BD3B4.2070708@lsrfire.ath.cx>
	 <e5bfff550801021027i6d6a399cob96ae3c840661884@mail.gmail.com>
	 <477C301D.7060509@lsrfire.ath.cx>
	 <7vr6gztgwn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 11:07:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAMyY-0003jv-D7
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 11:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYACKGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 05:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbYACKGX
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 05:06:23 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:24257 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbYACKGW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 05:06:22 -0500
Received: by rv-out-0910.google.com with SMTP id k20so5672370rvb.1
        for <git@vger.kernel.org>; Thu, 03 Jan 2008 02:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NTCvNT+8cuLDB2q/uyeuAPuZa3ESkdgQKwUh1gZO3XM=;
        b=jOASSMwXuz1Gcn4W22GS/Qp9d8HKzipYzfaRZzolUhN8v8o2MQb01PXgTBiIiOi5RmwkVvPo8jDKZtzO0Z0DsnVHYMTANsXdecFxT3ZqZjzw5yvUJEra0iwiApSzOsRSTMiFVVEWfvQRrBjf63AEu3V/EKN0GccpHMumAUQrM8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PsWMCj5j0zBcE5qBzL640RarhozuKafQi+R5ZmcAOErPPZX64T99DopRaH3ewjim0ZsxB4ujCPYyppSbaVyVh6vvCCDsXoNvxe4ez0mtm3KOgDdrZJfNBibJaCnqiNpY1UEI8WY/Mb1xTbHVWw9zFf2BeX6jOrefKbvozSaYveI=
Received: by 10.141.197.8 with SMTP id z8mr1123695rvp.285.1199354781688;
        Thu, 03 Jan 2008 02:06:21 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 3 Jan 2008 02:06:21 -0800 (PST)
In-Reply-To: <7vr6gztgwn.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69522>

On Jan 3, 2008 10:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>
> I'll let Marco bench it and hopefully Ack with an updated
> (final) commit log message.
>

I will bench today and post the results.

Marco
