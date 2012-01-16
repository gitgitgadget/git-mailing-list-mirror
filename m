From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Mon, 16 Jan 2012 12:07:19 +0100
Message-ID: <4F1404E7.9040805@ira.uka.de>
References: <loom.20120112T193624-86@post.gmane.org> <4F1028AD.9080701@ira.uka.de> <4F106DDF.4040408@unclassified.de> <4F1085EC.9010708@ira.uka.de> <4F128AD0.5020101@unclassified.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?B?Q2FybG9zIE1h?= =?UTF-8?B?cnTDrW4gTmlldG8=?= 
	<cmn@elego.de>
To: Yves Goergen <nospam.list@unclassified.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 12:07:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmkPN-000346-7w
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 12:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab2APLHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 06:07:19 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:50782 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753931Ab2APLHS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2012 06:07:18 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1RmkP8-0007vI-Fc; Mon, 16 Jan 2012 12:07:15 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1RmkP6-0004zR-6K; Mon, 16 Jan 2012 12:07:08 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <4F128AD0.5020101@unclassified.de>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1326712035.755950000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188628>

On 15.01.2012 09:14, Yves Goergen wrote:
> On 13.01.2012 20:28 CE(S)T, Holger Hellmuth wrote:
>> Is it possible that Visual Studio changes them while you are comitting?
>
> No. Those files may only be modified while open.
>
>>> I renamed the file and created a new one with the same name. Is it so
>>> simple to crash the Git repository?
>>
>> Who said anything about crash? git simply doesn't care whether a change
>> is because of a rename. It isn't special or different to any change you
>> can make to a file
>
> Well, there is a tracked file about which Git says it's untracked. How
> would you describe such internal inconsistency? Maybe corruption would
> fit better.

The original point I was trying to make was that git rename is made out 
of the rather simple operations git add <newname> and git rm <oldname>. 
Not a seldom used function but the basic operations of the vcs. It must 
be one heck of a corner case or a bit flip in the hardware.

The most likely place where the corruption could be is the index. This 
is actually a simple file located in .git\ that can be recreated by 
deleting that file and doing "git reset". I would shut down tortoise-git 
(i.e. the explorer) before doing this and use the command line.
