From: "Sam Liddicott" <sam@liddicott.com>
Subject: Re: let git-diff allow patch to delete empty files?
Date: Thu, 06 Nov 2008 08:30:24 -0000
Organization: Liddicott.com
Message-ID: <4912AB20.4070608@liddicott.com>
References: <49118FEE.30408@liddicott.com> <20081106060940.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 09:32:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky0IH-0002Tq-KF
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 09:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbYKFIbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 03:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbYKFIbU
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 03:31:20 -0500
Received: from timbuctoo.liddicott.com ([206.123.89.57]:50496 "EHLO
	timbuctoo.liddicott.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbYKFIbT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 03:31:19 -0500
Received: from [192.168.0.180] (82.153.158.114 [82.153.158.114])
	by timbuctoo.liddicott.com; Thu, 06 Nov 2008 08:30:31 -0000
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100217>

* Nanako Shiraishi wrote, On 05/11/08 21:09:
> Quoting "Sam Liddicott" <sam@liddicott.com>:
>
>   
>> In some cases "patch" cannot apply diff's generated using git-diff, I've
>> had a "git diff" output look like this when an empty file was removed as
>> the only change:
>>     
>
> Even if you do not use git to manage your changes, you can use "git apply" from outside of a git repository as a replacement for "patch".
>
>   
Good tip, thanks.

In this case it is rpmbuild that is doing the patching, and making git a
build-requires would not be popular.

Sam
