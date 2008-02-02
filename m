From: Wink Saville <wink@saville.com>
Subject: Re: git-svn segmetation fault
Date: Sat, 02 Feb 2008 10:56:40 -0800
Message-ID: <47A4BCE8.5030308@saville.com>
References: <47A39DFD.9020905@saville.com> <47A3BE6F.6080304@saville.com> <20080202034258.GA27814@dervierte> <47A3E9A8.1060102@saville.com> <20080202160332.GA25945@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 19:57:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLNYK-0003vO-LR
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 19:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933133AbYBBS4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 13:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933099AbYBBS4q
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 13:56:46 -0500
Received: from an-out-0708.google.com ([209.85.132.245]:24174 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764678AbYBBS4p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 13:56:45 -0500
Received: by an-out-0708.google.com with SMTP id d31so378872and.103
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 10:56:43 -0800 (PST)
Received: by 10.100.9.20 with SMTP id 20mr10592039ani.43.1201978603457;
        Sat, 02 Feb 2008 10:56:43 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id c23sm8782773ana.15.2008.02.02.10.56.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Feb 2008 10:56:42 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20080202160332.GA25945@dervierte>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72299>

Steven Walter wrote:
> On Fri, Feb 01, 2008 at 07:55:20PM -0800, Wink Saville wrote:
>   
>>> Can you show the contents of .git/config ?
>>>   
>>>       
> [...]
>   
>> [svn-remote "svn"]
>>        url = https://async-msgcomp.googlecode.com/svn/trunk
>>        fetch = :refs/remotes/git-svn
>>     
>
> There's your problem.  The url line should only contain the SVN root.
> If you change it thusly:
>
>     [svn-remote "svn"]
>         url = https://async-msgcomp.googlecode.com/svn
>         fetch = trunk:refs/remotes/git-svn
>
> It will no longer segfault.  I had the same issue with a repository of
>   
> my own.
>   
<I did that but a rebase command resulted in: />

wink@ic2d1:$ git svn rebase
Unable to determine upstream SVN information from working tree history

<I've bee using git-svn for a few days without trouble. Do I need
the do another "git svn clone" using the base url rather than
pointing to the trunk? />
