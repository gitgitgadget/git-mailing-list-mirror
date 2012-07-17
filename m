From: Jeroen Meijer <jjgmeijer@hotmail.com>
Subject: possible bug in autocompletion
Date: Tue, 17 Jul 2012 11:10:39 +0200
Message-ID: <BLU0-SMTP405CDB35308082B180185A6B4DB0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 11:17:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr3tr-00020N-LL
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 11:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686Ab2GQJQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 05:16:55 -0400
Received: from blu0-omc3-s10.blu0.hotmail.com ([65.55.116.85]:15812 "EHLO
	blu0-omc3-s10.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752699Ab2GQJQy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2012 05:16:54 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jul 2012 05:16:54 EDT
Received: from BLU0-SMTP405 ([65.55.116.72]) by blu0-omc3-s10.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 17 Jul 2012 02:10:43 -0700
X-Originating-IP: [217.119.224.51]
X-Originating-Email: [jjgmeijer@hotmail.com]
Received: from [10.180.1.56] ([217.119.224.51]) by BLU0-SMTP405.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 17 Jul 2012 02:10:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
X-OriginalArrivalTime: 17 Jul 2012 09:10:42.0237 (UTC) FILETIME=[0A7B3ED0:01CD63FC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201596>

We have a tag name with some special characters. The tag name is 
'Build%20V%20${bamboo.custom.jiraversion.name}%20Build%20721'. In 
somecases where autocompletion is used an error is given, such as 'bash: 
Build%20V%20${bamboo.custom.jiraversion.name}%20Build%20721: bad 
substitution'. This can be invoked by typing 'git checkout B' and then 
pressing tab.
Of course; the tag is useless but still I guess this is a bug in the 
autocompletion of git.

Regards,

Meijuh
