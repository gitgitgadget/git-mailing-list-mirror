From: Francois Marier <fmarier@gmail.com>
Subject: Re: [PATCH] git-archive documentation: .gitattributes must be
 committed
Date: Thu, 11 Feb 2010 16:48:03 +1300
Message-ID: <20100211034802.GS9853@isafjordur.dyndns.org>
References: <1265770284-14830-1-git-send-email-fmarier@gmail.com>
 <4B7303FC.6070701@lsrfire.ath.cx>
 <7v1vgsao21.fsf@alter.siamese.dyndns.org>
 <4B731043.6010108@lsrfire.ath.cx>
 <7vr5os7sl2.fsf@alter.siamese.dyndns.org>
 <7veiks7rux.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 04:56:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfQAH-0001vG-VG
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 04:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431Ab0BKD4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 22:56:23 -0500
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:42658 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328Ab0BKD4W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 22:56:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id AD34632E10;
	Thu, 11 Feb 2010 16:56:17 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tAvLpZ3Xq82S; Thu, 11 Feb 2010 16:56:16 +1300 (NZDT)
Received: from isafjordur (leibniz.catalyst.net.nz [202.78.240.7])
	(Authenticated sender: francois)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 8381932E0C;
	Thu, 11 Feb 2010 16:56:16 +1300 (NZDT)
Received: by isafjordur (Postfix, from userid 1000)
	id 7F7D75B436E; Thu, 11 Feb 2010 16:56:15 +1300 (NZDT)
Received: by isafjordur (hashcash-sendmail, from uid 1000);
	Thu, 11 Feb 2010 16:48:04 +1300
Content-Disposition: inline
In-Reply-To: <7veiks7rux.fsf@alter.siamese.dyndns.org>
X-Request-PGP: http://people.debian.org/~francois/public_key.asc
X-Hashcash: 1:28:100211:gitster@pobox.com::NEd/MeNlgMjEeIXY:00000000000000000000
	00000000000000000000000CshPM
X-Hashcash: 1:28:100211:rene.scharfe@lsrfire.ath.cx::CkEGLTaTrtqRLCDp:0000000000
	00000000000000000000000IQMfr
X-Hashcash: 1:28:100211:git@vger.kernel.org::WQ/3Yd0covT3aGYe:000000000000000000
	00000000000000000000000ABP/+
X-Hashcash: 1:28:100211:pclouds@gmail.com::uBoZPwFg0XWO7Ngg:00000000000000000000
	000000000000000000000000Z5gw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139572>

On 2010-02-10 at 12:33:58, Junio C Hamano wrote:
> +Note that attributes are by default taken from the `.gitattributes` files
> +in the tree that is being archived.  If you want to tweak the way the
> +output is generated after the fact (e.g. you committed without adding an
> +appropriate export-ignore in its `.gitattributes`), adjust the checked out
> +`.gitattributes` file as necessary and use `--work-tree-attributes`
> +option.  Alternatively you can keep necessary attributes that should apply
> +while archiving any tree in your `$GIT_DIR/info/attributes` file.

Looks good to me.

-- 
Francois Marier                         identi.ca/fmarier
http://feeding.cloud.geek.nz          twitter.com/fmarier
