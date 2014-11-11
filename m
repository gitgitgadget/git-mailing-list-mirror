From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: [Opinions] Integrated tickets
Date: Tue, 11 Nov 2014 13:46:26 +0100
Message-ID: <54620522.4060600@ira.uka.de>
References: <20141105124429.GF15384@paksenarrion.iveqy.com> <xmqqvbmsgocj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 14:02:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoB5d-0005Sv-PL
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 14:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbaKKNC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 08:02:29 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:36816 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751274AbaKKNC3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Nov 2014 08:02:29 -0500
X-Greylist: delayed 958 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Nov 2014 08:02:28 EST
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1XoAq1-0003Et-LM; Tue, 11 Nov 2014 13:46:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqvbmsgocj.fsf@gitster.dls.corp.google.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1415709985.
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1415710941.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.11.2014 um 19:45 schrieb Junio C Hamano:
> This is a tangent, but I personally do not think "ticket" meshes
> very well with "commit".  If you already know which commit was
> problematic, why are you annotating it with a ticket before
> reverting it first?

I would expect a ticket to be annotating the commit or version tag where 
the bug was found, which usually isn't the commit where the bug was 
introduced.
