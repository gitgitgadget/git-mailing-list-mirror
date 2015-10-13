From: Francois-Xavier Le Bail <devel.fx.lebail@orange.fr>
Subject: Re: How to rebase when some commit hashes are in some commit messages
Date: Tue, 13 Oct 2015 10:50:40 +0200
Message-ID: <561CC5E0.7060206@orange.fr>
References: <561C1132.3090606@orange.fr> <vpqsi5fx2gr.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 13 10:51:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlvIZ-0002xX-7t
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 10:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbbJMIu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 04:50:57 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:38566 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbbJMIuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 04:50:55 -0400
Received: from [127.0.0.1] ([213.178.77.178])
	by mwinf5d17 with ME
	id UYqg1r00T3qpEb103YqtPn; Tue, 13 Oct 2015 10:50:53 +0200
X-ME-Helo: [127.0.0.1]
X-ME-Auth: ZGV2ZWwuZngubGViYWlsQHdhbmFkb28uZnI=
X-ME-Date: Tue, 13 Oct 2015 10:50:53 +0200
X-ME-IP: 213.178.77.178
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqsi5fx2gr.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279489>



On 12/10/2015 22:21, Matthieu Moy wrote:
> Francois-Xavier Le Bail <devel.fx.lebail@orange.fr> writes:
> 
>> Hello,
>>
>> [I try some search engines without success, perhaps I have missed something].
>>
>> For example, if I rebase the following commits, I would want that if
>> the commit hash 2222222... become 7777777...,
>> the message
>> "Update test output for 2222222222222222222222222222222222222222"
>> become
>> "Update test output for 7777777..."
>>
>> Is it possible currently? And if yes how?
> 
> AFAIK, it's not possible other than by editing the message by hand.

It seems to me useful to be able to do it. Can we hope a new option?
