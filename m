From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH] HEAD, ORIG_HEAD and FETCH_HEAD are really special.
Date: Fri, 07 Sep 2007 14:36:15 +0200
Message-ID: <46E145BF.4070403@eudaptics.com>
References: <1189115308.30308.9.camel@koto.keithp.com>	<7vsl5r8jer.fsf@gitster.siamese.dyndns.org>	<1189133898.30308.58.camel@koto.keithp.com> <7vd4wu67qs.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 14:36:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITd4e-00010Q-Bs
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 14:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965302AbXIGMgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 08:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbXIGMgZ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 08:36:25 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:20282 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965175AbXIGMgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 08:36:25 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ITd4O-00005G-9w; Fri, 07 Sep 2007 14:36:21 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B5ED454D; Fri,  7 Sep 2007 14:36:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vd4wu67qs.fsf_-_@gitster.siamese.dyndns.org>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.353, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58034>

Junio C Hamano schrieb:
> But he has a stray .git/master file,
> perhaps created by hand by mistake (it would be very interesting
> to find how that file got there in the first place),

It is easy to get one there if, in a brave moment, you try

    git update-ref master $some_other_ref

instead of the correct

    git update-ref refs/heads/master $some_other_ref

-- Hannes
