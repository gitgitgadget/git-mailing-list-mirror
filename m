From: Olaf Hering <olaf@aepfle.de>
Subject: Re: git log fails to show all changes for a file
Date: Tue, 14 Jul 2015 09:59:55 +0200
Message-ID: <20150714075955.GA24577@aepfle.de>
References: <20150714073035.GA22707@aepfle.de>
 <20150714074508.GE1451@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jul 14 10:06:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEvEE-00015I-Gt
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 10:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbbGNIGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 04:06:03 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:53127 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbGNIGA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 04:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1436861158; l=659;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=bsxnlvfC5ABoak1pNhJ4C7tM0JrjIe/H5A0hZVhn524=;
	b=qIeFLz2ypBmmluTZ7HDhvOgSHpMY88WKLzj7HlFDG88AajcoCU9iwDwZx6ai9ijQDU/
	wR6ClB8kONQ56Ux2NGs/s7feP75a+cmkaGY/Q8V81aeGI1yF2xlRL3c2YWF/nXvjKp8i1
	PfnUnVT59rXxN+wY/5NxRrUEa23FFFeqD0g=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnDYUArRV3Yl4Hhhq0jXs89otQpQsG2DtGeDmANaZw=
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a62:90:9c01:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 37.8 AUTH)
	with ESMTPSA id L013bbr6E7xtqE8
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate);
	Tue, 14 Jul 2015 09:59:55 +0200 (CEST)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 8BAE0502DF; Tue, 14 Jul 2015 09:59:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150714074508.GE1451@serenity.lan>
User-Agent: Mutt/1.5.23 (2015-06-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273939>

On Tue, Jul 14, John Keeping wrote:

> It was added in an evil merge (f9da455b93f6ba076935b4ef4589f61e529ae046),
> try:
> 
> 	git log -p -M --stat --cc -- drivers/hv/channel_mgmt.c

Thanks. Thats rather useless output...

@@@ -404,7 -365,7 +404,7 @@@ static u32  next_vp
   * performance critical channels (IDE, SCSI and Network) will be uniformly
   * distributed across all available CPUs.
   */
- static void init_vp_index(struct vmbus_channel *channel, uuid_le *type_guid)
 -static u32 get_vp_index(const uuid_le *type_guid)
++static void init_vp_index(struct vmbus_channel *channel, const uuid_le *type_guid)
  {
        u32 cur_cpu;
        int i;


Olaf
