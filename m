From: Nir Friedman <nirfri@hotmail.com>
Subject: FW: git over https and http 1.1
Date: Wed, 18 May 2011 16:34:27 +0300
Message-ID: <BLU0-SMTP122315AAE364595FDA4A30AC78F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 18 15:34:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMgtY-0006Ku-P5
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 15:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933155Ab1ERNed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 09:34:33 -0400
Received: from blu0-omc3-s30.blu0.hotmail.com ([65.55.116.105]:12220 "EHLO
	blu0-omc3-s30.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932880Ab1ERNed (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 09:34:33 -0400
Received: from BLU0-SMTP122 ([65.55.116.72]) by blu0-omc3-s30.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 18 May 2011 06:34:32 -0700
X-Originating-IP: [212.179.48.132]
X-Originating-Email: [nirfri@hotmail.com]
Received: from nirftp ([212.179.48.132]) by BLU0-SMTP122.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 18 May 2011 06:34:31 -0700
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AcwVWN09aQj9nCMISe6R+O7RzDs6tAAAW5XAAAF9cXA=
Content-Language: en-us
X-OriginalArrivalTime: 18 May 2011 13:34:31.0374 (UTC) FILETIME=[51685EE0:01CC1560]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173879>


 
Sorry for the double post.

Fast is - 15 seconds, around  50% less

This was checked on 	Ubuntu 	11.04
				Libcurl 	7.21.3

This problem didn't exist on windows clients.


-----Original Message-----
From: Daniel Stenberg [] 

On Wed, 18 May 2011, Nir Friedman wrote:

> I am using git with https as the transport protocol. Response times were 
> around 30 seconds before apache started processing the backend command.

Can you please be a bit more elaborate on exactly what took that much time? 
What is a "response time" in this context?

> I added the flags   [BrowserMatch "git"      downgrade-1.0
> force-response-1.0] to the apache conf file, and response times were fast.

How fast is "fast" compared to the previous 30 seconds?

> This seems to mean that the libcurl library is not dealing correctly with 
> HTTP 1/1 over SSL.

I don't think that's what it means but I have to little data to go on. What 
libcurl version are you using on what platform?

-- 

  / daniel.haxx.se
