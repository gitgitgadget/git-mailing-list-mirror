From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: [PATCH] Support wrapping commit messages when you read them
Date: Tue, 14 Feb 2012 13:10:59 +0100
Message-ID: <4F3A4F53.9030302@ira.uka.de>
References: <8DE6E894-B50D-4F7E-AE18-C10E7E40A550@sidneysm.com> <7vfwg99dom.fsf@alter.siamese.dyndns.org> <46957CEB-5E48-4C11-8428-9A88C3810548@sidneysm.com> <7vzkcmbcbq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?U2lkbmV5IFNhbiBNYXJ0w61u?= <s@sidneysm.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 13:10:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxHDL-0006RP-1P
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 13:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab2BNMK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 07:10:26 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:54694 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753315Ab2BNMKZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 07:10:25 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1RxHD5-0005TL-9J; Tue, 14 Feb 2012 13:10:22 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1RxHD3-00008M-L2; Tue, 14 Feb 2012 13:10:13 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <7vzkcmbcbq.fsf@alter.siamese.dyndns.org>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1329221422.516090000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190718>

On 13.02.2012 23:25, Junio C Hamano wrote:
> "Computers are good at automating" is true, and that is why real editors
> give an easy way to auto-wrap long prose in a paragraph while composing.
> But "computers are good at automating" is not a convincing justification
> to let the composer leave unreasonably long lines in the commit log object
> and force the reader side to line-wrap the mess only to fix it up.

Maybe this is more convincing: Only the reader side knows the 
line-length of the display or window.
