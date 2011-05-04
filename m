From: "Mikhail T." <mi+thun@aldan.algebra.com>
Subject: How to fork a file (git cp ?)
Date: Wed, 04 May 2011 13:56:29 -0400
Message-ID: <4DC1934D.6070608@aldan.algebra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 20:06:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHgTR-0005F1-E8
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 20:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab1EDSGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 14:06:51 -0400
Received: from smtp11.lnh.mail.rcn.net ([207.172.157.101]:48432 "EHLO
	smtp01.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755170Ab1EDSGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 14:06:50 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 May 2011 14:06:50 EDT
Received: from mr17.lnh.mail.rcn.net ([207.172.157.37])
  by smtp02.lnh.mail.rcn.net with ESMTP; 04 May 2011 13:57:05 -0400
Received: from smtp01.lnh.mail.rcn.net (smtp01.lnh.mail.rcn.net [207.172.4.11])
	by mr17.lnh.mail.rcn.net (MOS 4.2.3-GA)
	with ESMTP id AVZ84204;
	Wed, 4 May 2011 13:57:04 -0400
Received-SPF: None identity=pra; client-ip=209.6.61.133;
  receiver=smtp01.lnh.mail.rcn.net;
  envelope-from="mi+thun@aldan.algebra.com";
  x-sender="mi+thun@aldan.algebra.com";
  x-conformance=sidf_compatible
Received-SPF: None identity=mailfrom; client-ip=209.6.61.133;
  receiver=smtp01.lnh.mail.rcn.net;
  envelope-from="mi+thun@aldan.algebra.com";
  x-sender="mi+thun@aldan.algebra.com";
  x-conformance=sidf_compatible
Received-SPF: None identity=helo; client-ip=209.6.61.133;
  receiver=smtp01.lnh.mail.rcn.net;
  envelope-from="mi+thun@aldan.algebra.com";
  x-sender="postmaster@utka.zajac";
  x-conformance=sidf_compatible
X-Auth-ID: anat
Received: from unknown (HELO utka.zajac) ([209.6.61.133])
  by smtp01.lnh.mail.rcn.net with ESMTP; 04 May 2011 13:56:59 -0400
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.9.2.13) Gecko/20101229 Lightning/1.0b2 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172753>

I need to add a new thing to our project. The thing will be similar to what 
already exists. I'd like to "derive" the new files from the existing ones -- 
without altering them and by preserving the change-history.

This is not a separate branch -- the "forked" files will co-exist. I'd call this 
git-cp (analogous to git-mv), but it does not exist...

Any ideas? Thanks!

    -mi
