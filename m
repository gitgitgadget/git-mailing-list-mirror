From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Failing a test on OpenServer 6 t5100-mailinfo.sh
Date: Mon, 10 Aug 2009 08:29:16 -0600
Message-ID: <alpine.LNX.2.00.0908100826440.10120@suse104.zenez.com>
References: <alpine.LNX.2.00.0908081014560.13290@suse104.zenez.com> <9NpKOKLSn88JzY2TZHUJ89wA2DmHDCazUmQpdWGi9Wi25O90kUipEg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Aug 10 16:29:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaVsL-0007Fm-Gd
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 16:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbZHJO3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 10:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753516AbZHJO3R
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 10:29:17 -0400
Received: from suse104.zenez.com ([198.60.105.164]:45871 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbZHJO3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 10:29:16 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 27B9E6D88FB; Mon, 10 Aug 2009 08:29:16 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 0F47E95000C;
	Mon, 10 Aug 2009 08:29:16 -0600 (MDT)
In-Reply-To: <9NpKOKLSn88JzY2TZHUJ89wA2DmHDCazUmQpdWGi9Wi25O90kUipEg@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125448>

On Mon, 10 Aug 2009, Brandon Casey wrote:
> Boyd Lynn Gerber wrote:
>> With a config.mak.autogen that is fixed for OpenServer 6.
>> I now have three tests that fail.
>>
>> The first is because of the OS does not allow perl to do somethings.
>>
>> The second is a new problem.
>
> Probably your system is missing support for some character encodings.
>
>> *** t5100-mailinfo.sh ***
...
>> * FAIL 12: mailinfo 0011
>
> This uses charset ISO8859-15.
...
>> * FAIL 16: mailinfo rfc2047/0001
>
> ISO8859-2
>
>> * FAIL 19: mailinfo rfc2047/0004
>
> ISO8859-8
>
>> * FAIL 26: mailinfo rfc2047/0011
>
> ISO8859-2
>
> You can just skip these tests if you don't want to install the missing 
> encoding support.

Thanks,

-- 
Boyd Gerber <gerberb@zenez.com> 801 849-0213
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
