From: Sven Strickroth <sven@cs-ware.de>
Subject: [PATCH 0/3] MSVC fixes
Date: Thu, 09 May 2013 03:10:50 +0200
Message-ID: <518AF79A.5000408@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:20:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFXE-0002wd-N8
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384Ab3EIBUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:20:12 -0400
Received: from srv1.79p.de ([213.239.234.118]:33163 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754798Ab3EIBUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:20:09 -0400
Received: from [192.168.0.20] (p5B03ACDA.dip0.t-ipconnect.de [91.3.172.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 0A5EF441003;
	Thu,  9 May 2013 03:10:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
	s=mail2013; t=1368061850;
	bh=pOvjlNIT9sTAUP6o6hcbN64e4fSIS7pOqJp2vIx1Y+0=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:Content-Type:
	 Content-Transfer-Encoding;
	b=neAYyKrPh6vXJe0leaXZTSRJObYoWRCiwpGTjodPlWIBsM9IeGN2TkoOMd9YB45l4
	 Goo20WU4NUUE6jjF9cEKjK5hs8WreH0DvphDG7x+ywzEd0SlEC8W0g1XHHMqVn4hea
	 kL2vfonLzS4FWuRFhe7IbVDALGI/uPmJq54QtlYg=
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223704>

Hi,

I've 3 patches fixing warnings and errors when compiling with latest
MSVC (2012).

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
