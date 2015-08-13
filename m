From: Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v4] gitk: Add a "Copy commit summary" command
Date: Thu, 13 Aug 2015 21:02:33 +0200
Message-ID: <55CCE9C9.5070209@drbeat.li>
References: <1437218139-7031-1-git-send-email-dev+git@drbeat.li> <20150813073708.GA17652@fergus.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:03:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxmY-00058N-K2
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbbHMTDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:03:14 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:49507 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192AbbHMTDN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:03:13 -0400
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id D5EFFC3442;
	Thu, 13 Aug 2015 21:03:10 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from mcmini.bolli (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id B3E3CC33DD;
	Thu, 13 Aug 2015 21:03:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150813073708.GA17652@fergus.ozlabs.ibm.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275885>

On 13.08.15 09:37, Paul Mackerras wrote:
> On Sat, Jul 18, 2015 at 01:15:39PM +0200, Beat Bolli wrote:
>> When referring to earlier commits in commit messages or other text, one
>> of the established formats is
>>
>>     <abbrev-sha> ("<summary>", <author-date>)
>>
>> Add a "Copy commit summary" command to the context menu that puts this
>> text for the currently selected commit on the clipboard. This makes it
>> easy for our users to create well-formatted commit references.
>>
>> The <abbrev-sha> is produced with the %h format specifier to make it
>> unique. Its length can be controlled with the gitk preference
>> "Auto-select SHA1 (length)", or, if this preference is set to its
>> default value (40), with the Git config setting core.abbrev.
>>
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> 
> Thanks, applied.
> 
Please also apply the follow-up patch in this thread [1]. It fixes menu
entry numbers that were changed by this patch.

Thanks,
Beat


[1] http://article.gmane.org/gmane.comp.version-control.git/275729
