From: =?ISO-8859-1?Q?Johannes_L=F6thberg?= <johannes@kyriasis.com>
Subject: Re: [PATCH] receive-pack: Create a HEAD ref for ref namespace
Date: Fri, 05 Jun 2015 13:53:45 +0200
Message-ID: <ef4dae3e-3ae8-4727-9448-80f801e1dbdf@email.android.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 13:54:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0qCB-0005hE-4K
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 13:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbbFELxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 07:53:50 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:52165 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbbFELxt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 07:53:49 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 609d42d2;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 11:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date
	:subject:message-id:in-reply-to:from:to:mime-version
	:content-type:content-transfer-encoding; s=theos; bh=Rhw8rJunTxu
	TpQSYNz0UNNC+U1M=; b=rF3BNswD3Ls0nPiMuv/LSzUghwy4Ww4tWKtplnHHl69
	ZN5nTSkdlEThmp26tu8cS03G2IhtUNzo4idtGJx7ZxCjLtxpM0iTO/317dg7te/a
	GGwLDgv8OL0ZnPAYzgUyqYLhHMOyrLPVxivOZ688q7xc8h71JLT8AVxRAc8Fnhn4
	=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:subject
	:message-id:in-reply-to:from:to:mime-version:content-type
	:content-transfer-encoding; q=dns; s=theos; b=LKTjmEewjDIoic6H1R
	TxXPELvM5PC9/nDGNFOpYcvr3lZfL/8YoDGG/aNwi/mc6sEnJT6e40n9z1GGXZ4f
	bCXdkMfPZRU/gjpjyBxpl72B875mc1H4XctuF3H9BICw6lZuLbubVylBepSoGQlK
	MsDSOosy4honaZA+nitlsPF/M=
Received: from [IPv6:2a00:801:240:c967:d4f3:d2e6:1609:52db] (2a00:801:240:c967:d4f3:d2e6:1609:52db [IPv6:2a00:801:240:c967:d4f3:d2e6:1609:52db]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 631a40fa;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 11:53:48 +0000 (UTC)
X-Android-Message-ID: <ef4dae3e-3ae8-4727-9448-80f801e1dbdf@email.android.com>
In-Reply-To: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270826>

UGluZy4KCi0tClNpbmNlcmVseSwgCkpvaGFubmVzIEzDtnRoYmVyZyAKKFNlbnQgZnJvbSBteSBw
aG9uZS4p
