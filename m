From: Olaf Hering <olaf@aepfle.de>
Subject: let git grep consider sub projects
Date: Tue, 7 Oct 2014 10:29:14 +0200
Message-ID: <20141007082914.GA2729@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 10:29:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbQ96-0007aR-Nw
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 10:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbaJGI3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 04:29:21 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:33507 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbaJGI3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 04:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1412670555; l=495;
	s=domk; d=aepfle.de;
	h=Content-Disposition:Content-Type:MIME-Version:Subject:To:From:Date;
	bh=ByRMeU5syUl48e2zX87EGbZpZLI=;
	b=p1Sv1WPh3RlF7OMnlWnS8vyWJ1GjBPJ3rHHe02LNCo2Fjb4DsJsQIh6m3gR7cLLX0Vz
	NulX+o1GtNs1YWuYdFs90DdDE3PQ2wdD1wTWz/RUgfer5YTskWgUuZNGezu3Duau2z9Xr
	P2OBE3T/LQQTFE1qxfgnlrWn3MonwdNcBu4=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfstVolSR8Cl8fNabDQrlSrQo8jPq2gOVbkBPuE3yQ==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:11b7:1201:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 35.9 AUTH)
	with ESMTPSA id N009b1q978TFrNM
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	for <git@vger.kernel.org>;
	Tue, 7 Oct 2014 10:29:15 +0200 (CEST)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id D15095016D; Tue,  7 Oct 2014 10:29:14 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257919>


How can I teach 'git grep $string' to also consider subprojects?

The build system of xen.git clones 4 other trees into a directory in its
source tree during build. It would be nice if my 'git grep' searches
also in these cloned subdirs. Somehow there must be some knowledge
because 'git clean -dfx' leaves them alone, while 'git clean -dffx'
wipes everything.

Olaf

PS: Sometimes I miss a 'git clean -dfx --also-sub-repos' useful to
really clean everything before starting over.
