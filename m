From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Creating CVS-style patch headers with git-diff
Date: Sat, 08 Jan 2011 12:49:43 +0100
Message-ID: <4D284F57.2000808@dbservice.com>
References: <AANLkTinmq=3kJmtSVutf7dHAQ0QL3fr9_E3hZ7gDe1JY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 12:49:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbXIv-0007Xq-Pj
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 12:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab1AHLts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 06:49:48 -0500
Received: from office.neopsis.com ([78.46.209.98]:54324 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab1AHLtr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 06:49:47 -0500
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.081,BAYES_00: -1.665,TOTAL_SCORE: -1.584,autolearn=ham
X-Spam-Level: 
Received: from calvin.local ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sat, 8 Jan 2011 12:49:44 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTinmq=3kJmtSVutf7dHAQ0QL3fr9_E3hZ7gDe1JY@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164818>

  On 1/8/11 12:23 PM, David Chanters wrote:
> Hi all,
>
> [ Please Cc me on any replies as I am not subscribed to this list, thanks. ]
>
> I am wondering if I can get git diff to create "CVS-style patches"?
> What do I mean by that?  Well, whenever I do:
>
> git diff
>
> I get patch headers in the form:
>
> diff --git a/foo.c b/foo.c
> index 57b9527..a2d947b 100644
> --- a/foo.c
> +++ b/foo.c
>
> This is fine for git, but if I then want to import the same patch into
> CVS I have to either edit the patch, or mess around with the -p option
> to patch(1).
What exactly do you need to change in the patch? Remove the index line? 
The '--git' string? Remove or change the a/, b/ prefix?
> I have seen that git-diff has options to change the a/ b/ headers --
> can anyone shed some light on this as to what I can do?

Are you maybe looking for the --no-prefix option?

tom
