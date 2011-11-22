From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: How to deal with mixed tree?
Date: Tue, 22 Nov 2011 12:35:51 +0100
Message-ID: <4ECB8917.8010305@ira.uka.de>
References: <CA+9ZNic-9U0nP1NGL0shUijnxdhaoEHwyxWM8rOzR2B6Qjq6zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Tue Nov 22 12:54:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSovn-0007mS-3F
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 12:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075Ab1KVLyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 06:54:11 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:60374 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756822Ab1KVLyK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2011 06:54:10 -0500
X-Greylist: delayed 1136 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Nov 2011 06:54:10 EST
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1RSod0-00081h-7b; Tue, 22 Nov 2011 12:35:12 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1RSocz-0006Cj-Cu; Tue, 22 Nov 2011 12:35:05 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <CA+9ZNic-9U0nP1NGL0shUijnxdhaoEHwyxWM8rOzR2B6Qjq6zQ@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1321961712.313398000
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1321962849.154614000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185790>

On 22.11.2011 12:21, Pascal Obry wrote:
> A project P1 is under Git.
>
> A project P2 is under Subversion.
>
> P2 in fact replace a sub-directory (say SD) in P1. The project P2 is a
> replacement (extension) of the code in P1.
>
> How to deal with this?

Remove SD in P1, make a logical link from P2 to SD, add SD to 
.git/info/exclude

(see "Bug report - local (and git ignored) file silently removed after 
checkout" on the mailing list why exclude is better than .gitignore at 
the moment)
