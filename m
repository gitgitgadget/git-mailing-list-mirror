From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/5] bisect: Add support for a --no-checkout option.
Date: Mon, 1 Aug 2011 06:42:03 +0200
Message-ID: <201108010642.03651.chriscool@tuxfamily.org>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com> <201107301619.51438.chriscool@tuxfamily.org> <7v39hmkkth.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 06:46:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnkOv-00018R-HB
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 06:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab1HAEmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 00:42:13 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:33216 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021Ab1HAEmM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 00:42:12 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 09FF2A6152;
	Mon,  1 Aug 2011 06:42:04 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <7v39hmkkth.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178315>

On Monday 01 August 2011 03:00:10 Junio C Hamano wrote:
>
> When used without "--no-checkout" option, "bisect" need to check-out the
> candidate version. What good would it do if it does _not_ update HEAD when
> it does so?
> 
> While you are correct to point out --[no-]checkout is a boolean option,
> this "we do not update HEAD but update this other thing" is not orthogonal
> to the option. It does not make sense when we actually touch the working
> tree.

Yeah.

> My preference is not to play games with "we can specify a ref other than
> HEAD" until somebody can demonstrate why it is a feature "because we need
> to be able to do so in such and such times", not merely "because we can".

So you want Jon to post a patch series with only a "--no-checkout" option. Ok.

Thanks,
Christian.
