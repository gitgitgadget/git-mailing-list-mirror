From: Toby Corkindale <toby.corkindale@rea-group.com>
Subject: Re: Maintaining commit.template config through clones
Date: Tue, 22 Apr 2008 14:45:32 +1000
Organization: REA Group
Message-ID: <480D6D6C.7040708@rea-group.com>
References: <48070EA4.2050503@rea-group.com> <48072458.70005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 06:46:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoAOx-00069r-Il
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 06:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbYDVEp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 00:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbYDVEp5
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 00:45:57 -0400
Received: from mel-nat68.realestate.com.au ([210.50.192.68]:39433 "EHLO
	mel-nat68.realestate.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751266AbYDVEp4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2008 00:45:56 -0400
Received: from [192.168.53.6] ([192.168.53.6]) by mel-nat68.realestate.com.au with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 22 Apr 2008 14:45:32 +1000
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <48072458.70005@viscovery.net>
X-OriginalArrivalTime: 22 Apr 2008 04:45:32.0843 (UTC) FILETIME=[B2B31FB0:01C8A433]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80058>

Johannes Sixt wrote:
> Toby Corkindale schrieb:
>> I'm attempting to implement Git at our company, and we currently use a
>> commit template for CVS. I can convert this to a Git-formatted template,
>> and set it for use with git-config commit.template ....
>>
>> However, once the repository is cloned, this configuration option
>> vanishes from .git/config
>>
>> Is there a way to make configuration options sticky?
> 
> Create or edit $prefix/share/git-core/templates/config.

Thanks.
Will that keep the commit-template propagated even when the repo is 
cloned from another machine? (ie. using git: or ssh: methods)

tjc.

-- 
Toby Corkindale
Software developer
w: www.rea-group.com
REA Group refers to realestate.com.au Ltd (ASX:REA)

Warning - This e-mail transmission may contain confidential information.
If you have received this transmission in error, please notify us
immediately on (61 3) 9897 1121 or by reply email to the sender. You
must destroy the e-mail immediately and not use, copy, distribute or
disclose the contents.
