From: Rolf Wester <rolf.wester@ilt.fraunhofer.de>
Subject: How to safely remove a blob
Date: Tue, 15 Feb 2011 09:13:03 +0100
Message-ID: <4D5A358F.2050906@ilt.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 09:27:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpGFb-0003T7-3B
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 09:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476Ab1BOI1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 03:27:05 -0500
Received: from relay01-haj2.antispameurope.com ([83.246.65.51]:44622 "EHLO
	relay01-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754462Ab1BOI1E (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 03:27:04 -0500
X-Greylist: delayed 835 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Feb 2011 03:27:04 EST
Received: by relay01-haj2.antispameurope.com (ASE-Secure-MTA, from userid 1000)
	id B7D9A941DF; Tue, 15 Feb 2011 09:13:03 +0100 (CET)
Received: from kso.ilt.fraunhofer.de (eeltc2.llt.RWTH-Aachen.DE [137.226.44.2])
	by relay01-haj2.antispameurope.com (ASE-Secure-MTA) with SMTP id 443A9941C5
	for <git@vger.kernel.org>; Tue, 15 Feb 2011 09:13:03 +0100 (CET)
Received: from ksi.ilt.fraunhofer.de (ksi.ilt.fraunhofer.de [153.96.180.2])
	by kso.ilt.fraunhofer.de (8.13.5+/8.13.5) with ESMTP id p1F8D3Ir010984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Tue, 15 Feb 2011 09:13:03 +0100 (CET)
X-Received: ilt.fraunhofer.de-policy  from ksi.ilt.fraunhofer.de (localhost [127.0.0.1])
	by ksi.ilt.fraunhofer.de (8.13.5+/8.13.5) with ESMTP id p1F8D3jo024681
	for <git@vger.kernel.org>; Tue, 15 Feb 2011 09:13:03 +0100 (CET)
Received: from [10.60.122.222] (suse895.fhg-ilt1.ilt.fraunhofer.de [10.60.122.222])
	by ksi.ilt.fraunhofer.de (8.13.5+/8.13.5) with ESMTP id p1F8D3vI024678
	for <git@vger.kernel.org>; Tue, 15 Feb 2011 09:13:03 +0100 (CET)
X-Authentication-Warning: ksi.ilt.fraunhofer.de: Host suse895.fhg-ilt1.ilt.fraunhofer.de [10.60.122.222] claimed to be [10.60.122.222]
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.4) Gecko/20100608 Lightning/1.0b2 Thunderbird/3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166823>

Hello,

in one of my git repos I found an 102 MB object that probably came in there more or less occasionally.
Its a blob and I would like to remove it safely. I tried to figure out how to do it but I was
not very successful. I guess simply deleting the file could corrupt my repo or at least the clones of
that repo.

I would be very appreciative for any help.

With kind regards
Rolf

-- 
------------------------------------
# Dr. Rolf Wester
# Fraunhofer Institut f. Lasertechnik
# Steinbachstrasse 15, D-52074 Aachen, Germany.
# Tel: + 49 (0) 241 8906 401, Fax: +49 (0) 241 8906 121
# EMail: rolf.wester@ilt.fraunhofer.de
# WWW:   http://www.ilt.fraunhofer.de
