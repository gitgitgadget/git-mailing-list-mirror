From: Miles Bader <miles@gnu.org>
Subject: orthogonal cases of log --date option
Date: Tue, 03 Mar 2009 17:18:56 +0900
Message-ID: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 09:20:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LePrg-0005ft-Ce
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 09:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbZCCITJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 03:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbZCCITI
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 03:19:08 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:51341 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbZCCITH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 03:19:07 -0500
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n238Iv0E023009;
	Tue, 3 Mar 2009 17:18:57 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay21.aps.necel.com with ESMTP; Tue, 3 Mar 2009 17:18:57 +0900
Received: from dhlpc061 ([10.114.112.240] [10.114.112.240]) by relay11.aps.necel.com with ESMTP; Tue, 3 Mar 2009 17:18:57 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id EFFB152E259; Tue,  3 Mar 2009 17:18:56 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112026>

I can use "git log --date=iso" to get YYYY-MM-DD format for dates, or
"git log --date=local" to force the dates to use my local time zone, but
if I use _both_ of these options together, it uses only the last one,
and ignores any preceding --date (even those in this case, the two
--date options affect orthogonal properties of dates).  Is there a way
to get YYYY-MM-DD format dates, but in my local time-zone?

Thanks,

-Miles

-- 
I'd rather be consing.
