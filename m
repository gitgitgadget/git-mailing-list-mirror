From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH] Functions for updating refs.
Date: Tue, 04 Sep 2007 17:08:54 +0200
Message-ID: <46DD7506.3090503@eudaptics.com>
References: <46DD6020.4050401@gmail.com> <Pine.LNX.4.64.0709041444070.28586@racer.site> <46DD6B93.10005@eudaptics.com> <Pine.LNX.4.64.0709041557590.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 17:09:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISa1W-0006i2-1s
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 17:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbXIDPI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 11:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429AbXIDPI5
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 11:08:57 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:25233 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368AbXIDPI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 11:08:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ISa1O-0002cP-Pa; Tue, 04 Sep 2007 17:08:54 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5A4006B7; Tue,  4 Sep 2007 17:08:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709041557590.28586@racer.site>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.376, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57593>

Johannes Schindelin schrieb:
> Hi,
> 
> On Tue, 4 Sep 2007, Johannes Sixt wrote:
> 
>> Johannes Schindelin schrieb:
>>> On Tue, 4 Sep 2007, Carlos Rica wrote:
>>>> +int update_ref_or_die(const char *action, const char *refname,
>>>> +				const unsigned char *sha1,
>>>> +				const unsigned char *oldval, int flags)
>>> Should this not be "void"?  And should it not use update_ref_or_error()?
>> It should not use *_error() directly because then it would print two error
>> messages in a row.
> 
> Well, my idea was to let _error() print the message, and just die().

How do you avoid that die() prints an error, too?

-- Hannes
