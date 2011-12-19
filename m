From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: How can I do an automatic stash when doing a checkout?
Date: Mon, 19 Dec 2011 18:24:58 +0100
Message-ID: <4EEF736A.4070802@ira.uka.de>
References: <jcki8u$oip$1@dough.gmane.org> <84ty4ycdcc.fsf@cenderis.demon.co.uk> <jckvpk$i8v$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: DeMarcus <demarcus@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 18:24:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcgwo-0006Kg-4f
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 18:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab1LSRYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 12:24:18 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:48643 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752217Ab1LSRYR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2011 12:24:17 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1Rcgwd-0002NW-5H; Mon, 19 Dec 2011 18:24:16 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1Rcgwc-0000z5-2t; Mon, 19 Dec 2011 18:24:10 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <jckvpk$i8v$1@dough.gmane.org>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1324315456.164467000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187461>

On 18.12.2011 16:10, DeMarcus wrote:
>> You probably don't want to use stash. Just commit whatever partial work
>> you've done.
>>
>
> It feels strange doing a commit of partial work. Some of the files may
> not even be supposed to be checked in.

You have heard of "git commit --amend" ? Makes partial commits really 
easy to work with.
