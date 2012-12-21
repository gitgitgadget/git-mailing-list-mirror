From: "Yngve Nysaeter Pettersen" <yngve@opera.com>
Subject: Re: Opera release Git-splitter, a sub-modularizing tool for Git
Date: Fri, 21 Dec 2012 13:43:01 +0100
Organization: Opera Software ASA
Message-ID: <op.wpn2xz07vqd7e2@damia.oslo.osa>
References: <op.wpiovoj5qrq7tp@acorna.invalid.invalid>
 <50D454D2.5030403@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Dec 21 13:43:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm1wp-0001kQ-Mn
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 13:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327Ab2LUMnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 07:43:12 -0500
Received: from smtp.opera.com ([213.236.208.81]:35280 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801Ab2LUMnL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 07:43:11 -0500
Received: from damia.oslo.osa (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id qBLCh5vp013485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Dec 2012 12:43:06 GMT
In-Reply-To: <50D454D2.5030403@drmicha.warpmail.net>
User-Agent: Opera Mail/11.64 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211968>

Hi,

On Fri, 21 Dec 2012 13:23:46 +0100, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

> Yngve N. Pettersen (Developer Opera Software ASA) venit, vidit, dixit
> 18.12.2012 15:51:
>> Hello all,
>>
>> Today Opera Software released the "Git-splitter", a small tool for
>> sub-modularizing code in a git repo, with complete commit history, under
>> the Apache 2.0 license.
>>
>> It's functionality is similar to "git-subtree", but also include a  
>> command
>> for reversing the process.
>
> Is there something keeping you technically from adding a join command to
> git-subtree?

Probably not, but within the process I was working I did not want to merge
the branch with the recreated history for that path into the existing
codebase (I don't like duplicate histories) so I used rebasing to move the
new commits over, instead, and therefore did not need a join command.

Feel free to add a join command, if you want one.

>> The code is hosted on GitHub:
>> <https://github.com/operasoftware/git-splitter>
>>
>> We have announced the release as part of another announcement of  
>> released
>> code at the Opera Security Group home page:
>> <http://my.opera.com/securitygroup/blog/2012/12/18/tls-prober-source-released-under-apache-2-0-license>
>>


-- 
Sincerely,
Yngve N. Pettersen
********************************************************************
Senior Developer		     Email: yngve@opera.com
Opera Software ASA                   http://www.opera.com/
Phone:  +47 96 90 41 51              Fax:    +47 23 69 24 01
********************************************************************
