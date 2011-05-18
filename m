From: Nir Friedman <nirfri@hotmail.com>
Subject: git over https and http 1.1
Date: Wed, 18 May 2011 15:30:18 +0300
Message-ID: <BLU0-SMTP195570CAA61AF8232B0295BC78F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 18 14:36:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMfzQ-0000Sq-B4
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 14:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933068Ab1ERMgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 08:36:31 -0400
Received: from blu0-omc3-s19.blu0.hotmail.com ([65.55.116.94]:27326 "EHLO
	blu0-omc3-s19.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933012Ab1ERMgb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 08:36:31 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 May 2011 08:36:31 EDT
Received: from BLU0-SMTP195 ([65.55.116.72]) by blu0-omc3-s19.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 18 May 2011 05:30:20 -0700
X-Originating-IP: [212.179.48.132]
X-Originating-Email: [nirfri@hotmail.com]
Received: from nirftp ([212.179.48.132]) by BLU0-SMTP195.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 18 May 2011 05:30:19 -0700
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AcwVV1cfgafkX8HlQ+ir+YJBkhbGDg==
Content-Language: en-us
x-cr-hashedpuzzle: Ajr5 AluG CHh7 D0GY ENmS EXLA EZkr Exzb FT5w FqtZ GoJ9 Icw7 IhtO JZqV J+7J LUH/;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{CD75C758-79AA-43BD-8956-94C6244335F6};bgBpAHIAZgByAGkAQABoAG8AdABtAGEAaQBsAC4AYwBvAG0A;Wed, 18 May 2011 12:30:15 GMT;ZwBpAHQAIABvAHYAZQByACAAaAB0AHQAcABzACAAYQBuAGQAIABoAHQAdABwACAAMQAuADEA
x-cr-puzzleid: {CD75C758-79AA-43BD-8956-94C6244335F6}
X-OriginalArrivalTime: 18 May 2011 12:30:19.0562 (UTC) FILETIME=[598C80A0:01CC1557]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173874>

I am using git with https as the transport protocol.
Response times were around 30 seconds before apache started processing the
backend command.
I added the flags   [BrowserMatch "git"      downgrade-1.0
force-response-1.0] to the apache conf file, and response times were fast.
This seems to mean that the libcurl library is not dealing correctly with
HTTP 1/1 over SSL. Is this the best fix?
If so, maybe appropriate documentation should be added to the git setup
docs.


-Nirf
