From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Question about commit message wrapping
Date: Tue, 13 Dec 2011 14:14:17 +0100
Message-ID: <4EE74FA9.2020908@ira.uka.de>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com> <m3zkf1hnh9.fsf@localhost.localdomain> <E085218D-9287-4F82-B34C-8379742F818A@sidneysm.com> <201112102030.15504.jnareb@gmail.com> <CAH5451kGn72tLAwdvQFBjSyHSL0rUmaPZrbL7Z-KfHWN-HAuCQ@mail.gmail.com> <CAH6sp9NwyxZi6KR4U96=sWdiqCseyTLEDoHdw=y9hUx2kHwOpg@mail.gmail.com> <4EE62DB9.8030406@ira.uka.de> <op.v6edibfz0aolir@keputer> <4EE6C31C.60909@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Frans Klaver <fransklaver@gmail.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?B?U2lkbmV5IFNhbiBNYXJ0w61u?= <s@sidneysm.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 13 14:13:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaSAt-0005W7-DB
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 14:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab1LMNNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 08:13:34 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:58545 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753452Ab1LMNNd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2011 08:13:33 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1RaSAb-0007k8-SZ; Tue, 13 Dec 2011 14:13:29 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1RaSAb-0003Xg-LM; Tue, 13 Dec 2011 14:13:21 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <4EE6C31C.60909@alum.mit.edu>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1323782009.867532000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187017>

On 13.12.2011 04:14, Michael Haggerty wrote:
> On 12/12/2011 11:16 PM, Frans Klaver wrote:
>> Wrapped code as in auto-wrapped? Or as in manually wrapped? Python
>> programmers have significant white space, but you can still hard wrap
>> stuff, as long as the next statement is properly indented.

I meant as in auto-wrapped and also not as a permanent change but 
something done to a long line on output to the screen.

> FWIW I think automatic wrapping of commit messages is a bad idea.  I
> wrap my commit messages deliberately to make them look the way I want

Which you still can do (since hard line endings would not be ignored). 
On displays wider than your line limit you will still see it exactly 
like intended. Only on narrow displays your commit message would look 
bad, admittedly even worse than cut-off lines.

> them to look.  The assumption of an 80-character display has historical
> reasons, but it is also a relatively comfortable line-width to read
> (even on wider displays).  And given that commit messages sometimes
> contain "flowable" paragraph text, sometimes code snippets, sometimes
> ASCII art, etc, no automatic wrapping will work correctly unless
> everybody agrees that commit messages must be written in some specific
> form of markup (or lightweight markup).  And I can't imagine such a
> thing ever happening.

With that assumption everyone could be happy with automatic wrapping of 
lines on screen output. You can hard wrap and it will look exactly as 
intended. In the same commit message you could also just write a 
paragraph without hitting the return-key at all and have a commit 
message that looks good in web browsers and too narrow gitk windows.
