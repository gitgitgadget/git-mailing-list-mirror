From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Repository data loss in fast-export with a merge of a deleted
 submodule
Date: Mon, 14 Nov 2011 08:06:51 -0700
Message-ID: <4EC12E8B.3050909@workspacewhiz.com>
References: <4EA9B0B5.6060005@workspacewhiz.com> <4EB2BBB5.3030908@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 16:05:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPy6c-0005Ol-Ai
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 16:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511Ab1KNPFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 10:05:49 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:56733 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab1KNPFt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 10:05:49 -0500
Received: (qmail 10627 invoked by uid 399); 14 Nov 2011 08:05:44 -0700
Received: from unknown (HELO ?192.168.1.109?) (jjensen@workspacewhiz.com@67.171.115.152)
  by hsmail.qwknetllc.com with ESMTPAM; 14 Nov 2011 08:05:44 -0700
X-Originating-IP: 67.171.115.152
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EB2BBB5.3030908@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185389>

----- Original Message -----
From: Joshua Jensen
Date: 11/3/2011 10:05 AM
> ----- Original Message -----
> From: Joshua Jensen
> Date: 10/27/2011 1:27 PM
>> We had a submodule that we deleted and then added back into the 
>> repository at the same location as the former submodule.  When 
>> running fast-export, the newly 'added' files for the merge commit are 
>> listed and then are followed with a:
>>
>> M ... path/to/submodule/file
>> D path/to/submodule
>>
>> On fast-import, the resultant repository becomes corrupt due to the 
>> Delete instruction above occurring AFTER the file 
>> adds/modifications.  The new repository does not match the old 
>> repository where the fast-export was performed.
>>
>> I am not familiar with the fast-export code.  Can anyone help out?
> Okay, I looked into this further, and I came up with a patch that 
> works for me.  Nevertheless, I do not understand exactly what is going 
> on here, so I would like to defer to someone else's patch to fix the 
> issue.
>
Hi.

__This is a genuine data loss problem in Git.__

I'm confused at the lack of response to this.  I first posted about the 
issue **2-1/2 weeks ago**, and there have been no responses  Does no one 
care?

In case no one received the messages, you can find them at [1] and [2].

-Josh

[1] http://www.spinics.net/lists/git/msg168295.html
[2] http://www.spinics.net/lists/git/msg168691.html
