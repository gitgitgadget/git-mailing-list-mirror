From: Jeremy Morton <admin@game-point.net>
Subject: Re: Allow git alias to override existing Git commands
Date: Tue, 10 Nov 2015 20:04:46 +0000
Message-ID: <56424DDE.2030808@game-point.net>
References: <56421BD9.5060501@game-point.net> <CAGZ79kZxQWVMe3N1ti8npyp9_4DUPAVy9Uk5a75Jwh3Eud2eZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 21:05:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwFAQ-0006Dz-Vm
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 21:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbbKJUFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 15:05:16 -0500
Received: from mail.gooeysoftware.com ([208.100.15.213]:34250 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbbKJUFP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 15:05:15 -0500
Received: from [192.168.1.3] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id 13ED618A00F2;
	Tue, 10 Nov 2015 14:01:20 -0600 (CST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <CAGZ79kZxQWVMe3N1ti8npyp9_4DUPAVy9Uk5a75Jwh3Eud2eZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281129>

On 10/11/2015 18:12, Stefan Beller wrote:
> On Tue, Nov 10, 2015 at 8:31 AM, Jeremy Morton<admin@game-point.net>  wrote:
>> It's recently come to my attention that the "git alias" config functionality
>> ignores all aliases that would override existing Git commands.  This seems
>> like a bad idea to me.
>
> This ensures that the plumbing commands always work as expected.
> As scripts *should* only use plumbing commands, the scripts should
> work with high probability despite all the crazy user configuration/aliases.
>

I just disagree with this.  If a user chooses to override their Git 
commands, it's their problem.  Why should Git care about this?  It 
should provide the user with the option to do this, and if the user 
ruins scripts because of their aliases, it is not Git's problem.  What 
you are doing is taking away power from users to use git aliases to 
their full potential.

-- 
Best regards,
Jeremy Morton (Jez)
