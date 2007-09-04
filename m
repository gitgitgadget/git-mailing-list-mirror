From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH] Functions for updating refs.
Date: Tue, 04 Sep 2007 16:28:35 +0200
Message-ID: <46DD6B93.10005@eudaptics.com>
References: <46DD6020.4050401@gmail.com> <Pine.LNX.4.64.0709041444070.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 16:28:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZOc-0004WG-JG
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbXIDO2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbXIDO2p
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:28:45 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:22019 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbXIDO2p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:28:45 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ISZOS-0000tV-D5; Tue, 04 Sep 2007 16:28:41 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 76EF56B7; Tue,  4 Sep 2007 16:28:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709041444070.28586@racer.site>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.367, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57577>

Johannes Schindelin schrieb:
> On Tue, 4 Sep 2007, Carlos Rica wrote:
>> +int update_ref_or_die(const char *action, const char *refname,
>> +				const unsigned char *sha1,
>> +				const unsigned char *oldval, int flags)
> 
> Should this not be "void"?  And should it not use update_ref_or_error()?

It should not use *_error() directly because then it would print two error 
messages in a row.

-- Hannes
