From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Fix archive format with -- on the command line
Date: Wed, 30 Dec 2009 12:13:09 +0900
Message-ID: <20091230121309.6117@nanako3.lavabit.com>
References: <20091210212636.GA27722@Knoppix> <7v1vj2a3ik.fsf@alter.siamese.dyndns.org> <20091210222258.GQ4114@genesis.frugalware.org> <7vws0u8n99.fsf@alter.siamese.dyndns.org> <7vhbry8l54.fsf_-_@alter.siamese.dyndns.org> <7vd42m8kyr.fsf@alter.siamese.dyndns.org> <4B23B019.40106@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 04:13:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPp0F-0004wy-Le
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 04:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbZL3DNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 22:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbZL3DNO
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 22:13:14 -0500
Received: from karen.lavabit.com ([72.249.41.33]:39600 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934AbZL3DNN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 22:13:13 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id F1C5F11B89A;
	Tue, 29 Dec 2009 21:13:12 -0600 (CST)
Received: from 9683.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id M7A35KCJYVKJ; Tue, 29 Dec 2009 21:13:12 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=B9e9/I7Joc9yIn6fJC2plxmuP4IJxHPG7iIDG9V4w4g+GB8mMInEgFTzNIAjaVHpaaXRBJDFVCWTR7fzKGs9fjdjo0r+n+KFTNzVNYmOgSHN2q5g7djQ/JcpCFelGLnaX/RfFmV0yF0EY8MSaFGMPSYnkCMhkMX7igDXV8p+ioQ=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <4B23B019.40106@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135851>

Junio, could you tell us what happened to this thread?

"git archive HEAD non-existing-path" doesn't complain like "git
add" does, and the patch is to fix it.  No discussion.
