From: "Tor Arvid Lund" <torarvid@gmail.com>
Subject: Re: [PATCH] git-p4: Fix one-liner in p4_write_pipe function.
Date: Fri, 22 Aug 2008 09:23:48 +0200
Message-ID: <1a6be5fa0808220023s1df3bac7u90a5103cc4a4a788@mail.gmail.com>
References: <1219353100-1692-1-git-send-email-torarvid@gmail.com>
	 <7vd4k1d0yk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Simon Hausmann" <simon@lst.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 09:25:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWR12-0003QL-2k
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 09:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbYHVHXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 03:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753120AbYHVHXu
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 03:23:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:42993 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbYHVHXt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 03:23:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so189408fgg.17
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 00:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=U64GaBjZbooBdGRnU/GxCh/qIkckWzF9rv/5RdZ3elM=;
        b=qVOIUOy7BckV3VGzgoZuIn8vdVDXLUl9AsLxJj5ZeAHbiQq7kZuUTjEIT3kp/8dKRX
         2odJ9db6lni+DaodhykhfCF3J2cEh5Xf2WeK/CRicX9a1iAzei2k4RHNQhQC6/1Y3QFV
         OTZMDJ+BYjVknaAHJaCkcX62ovWxRM905kO7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DzzYIHnL3+lcbfy823VGbYuGGGd/moYsQoJlV1us+vrYqpCsuBn6pQX75DlwiNywA8
         14Ry13IouxKmYwGtNGBtFalJAdLS9Zs12ZraR0eGKuY5SilSgNccBU1p9OsRwEFkBZBQ
         1yG9GuzmxJWeA6fxyr2eWZMGRF3L2XrioR8js=
Received: by 10.86.92.4 with SMTP id p4mr566890fgb.45.1219389828265;
        Fri, 22 Aug 2008 00:23:48 -0700 (PDT)
Received: by 10.86.79.9 with HTTP; Fri, 22 Aug 2008 00:23:48 -0700 (PDT)
In-Reply-To: <7vd4k1d0yk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93263>

On Fri, Aug 22, 2008 at 8:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Looks obviously correct.  Mind if I forge your sign-off?
>

Heh, that'll be fine. I don't submit patches that often, so I just
forgot - sorry ;-)

-Tor Arvid-
