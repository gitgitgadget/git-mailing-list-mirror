From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/6] detect dumb HTTP pack file corruption
Date: Sat, 17 Apr 2010 12:11:07 -0700
Message-ID: <20100417191107.GA15911@spearce.org>
References: <20100415141504.GB17883@spearce.org> <1271358560-8946-1-git-send-email-spearce@spearce.org> <7v8w8m2c9r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 21:11:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3DQD-0002VZ-PK
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 21:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443Ab0DQTLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 15:11:12 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61882 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab0DQTLL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 15:11:11 -0400
Received: by gwaa18 with SMTP id a18so1931465gwa.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 12:11:10 -0700 (PDT)
Received: by 10.150.188.13 with SMTP id l13mr3517599ybf.181.1271531469870;
        Sat, 17 Apr 2010 12:11:09 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 5sm1072325yxd.53.2010.04.17.12.11.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 12:11:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8w8m2c9r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145171>

Junio C Hamano <gitster@pobox.com> wrote:
> Hmph, I am getting failures from "[index v2] 6 verify-pack detects CRC
> mismatch" in t5302 when this is applied to 'maint' (or when the result is
> merged to 'master').

Oops.  Well, I need to respin the series anyway to address Tay
Ray Chuan's comments.  Clearly I failed to run the full test suite
before sending this series.  I promise to run the full suite before
resending.  :-)

-- 
Shawn.
