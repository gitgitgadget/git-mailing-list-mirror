From: Rudinei Goi Roecker <rudineigr@itflex.com.br>
Subject: Re: Git config not working correctly with included configurations
Date: Tue, 12 Apr 2016 09:13:57 -0300
Message-ID: <assp.09101f0ea6.570CE685.8060005@itflex.com.br>
References: <570CDB33.9020300@itflex.com.br>
 <570CE289.2000808@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 12 14:14:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apxD7-0000S1-7V
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 14:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933615AbcDLMOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 08:14:04 -0400
Received: from uni.itflex.com.br ([177.200.204.249]:48356 "EHLO
	mail.itflex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933604AbcDLMOB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 08:14:01 -0400
Received: (qmail 12273 invoked by uid 49); 12 Apr 2016 12:13:57 -0000
Received: from 127.0.0.1 (rudineigr@itflex.com.br@127.0.0.1) by web.itflex.com.br (envelope-from <rudineigr@itflex.com.br>, uid 89) with qmail-scanner-2.05 
 (clamdscan: 0.95.2/9450.  
 Clear:RC:1(127.0.0.1):. 
 Processed in 0.009701 secs); 12 Apr 2016 12:13:57 -0000
Received: from unknown (HELO ASSP.nospam) (rudineigr@itflex.com.br@127.0.0.1)
  by web.itflex.com.br with ESMTPA; 12 Apr 2016 12:13:57 -0000
Received: from rudineigr.itflex.lan ([192.168.47.195] helo=rudineigr.itflex.lan)
	by ASSP.nospam with ESMTPS(AES128-SHA) (ASSP 1.10.1); 12 Apr 2016 09:13:57 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
In-Reply-To: <570CE289.2000808@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291257>

I tried changing to ~/.gitconfig.user and 
/home/<user_name>/.gitconfig.user, still causes the same problem

On 12-04-2016 08:56, stefan.naewe@atlas-elektronik.com wrote:
> Am 12.04.2016 um 13:25 schrieb Rudinei Goi Roecker:
>> I'm having a problem with included configurations in ~/.gitconfig, when
>> using this command:
>>
>> git config --global user.email
>>
>> It doesn't return anything, in commits it works as intended. The
>> configuration looks like this:
>>
>> ~/.gitconfig
>> [include]
>>     path = .gitconfig.user
> Maybe you want to use
>
>       path = ~/.gitconfig.user
>
> here.
>
>> # ... more configurations
>>
>> ~/.gitconfig.user
>> [user]
>>     name = My Full Name
>>     email = myemail@example.com
> HTH,
>    Stefan
