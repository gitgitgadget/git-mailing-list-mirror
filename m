From: SungHyun Nam <goweol@gmail.com>
Subject: Re: 'git add' regression in git-1.7?
Date: Fri, 19 Feb 2010 14:04:46 +0900
Message-ID: <hll65c$87a$1@ger.gmane.org>
References: <hll45t$50o$1@ger.gmane.org> <32541b131002182042p610fce4ex96efbffea9afe2ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 06:05:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiL3T-0003U1-Gm
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 06:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777Ab0BSFFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 00:05:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:36121 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752Ab0BSFFI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 00:05:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NiL35-0003Lw-J8
	for git@vger.kernel.org; Fri, 19 Feb 2010 06:05:07 +0100
Received: from 210.181.13.12 ([210.181.13.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 06:05:07 +0100
Received: from goweol by 210.181.13.12 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 06:05:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 210.181.13.12
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ko; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <32541b131002182042p610fce4ex96efbffea9afe2ed@mail.gmail.com>
X-Stationery: 0.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140407>

Avery Pennarun wrote:
> On Thu, Feb 18, 2010 at 11:30 PM, SungHyun Nam<goweol@gmail.com>  wrote:
>> 'git add' does NOT add files in ignored path.
>>
>> When the .gitignore file contains:
>>     tmp/
>> If I do:
>>     git add tmp/test.txt
>> Nothing happens.
>
> Try using:
>       git add -f tmp/test.txt

Thanks, it works.

Well, before sending the previous email, I checked the
RelNotes-1.7.*.txt,  and could not find such a change by searching
'git add'.  So, I thought it's a regression.

Regards,
namsh
