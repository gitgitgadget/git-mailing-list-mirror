From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v5 1/2] filter-branch: stop special-casing $filter_subdir
 argument
Date: Wed, 11 Nov 2009 13:10:43 +0100
Message-ID: <4AFAA9C3.5080402@viscovery.net>
References: <4AE945D0.5030403@viscovery.net> <4AFA7624.5040400@viscovery.net> <4AFA7B9A.4090005@viscovery.net> <200911111124.52340.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Nov 11 13:10:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8C2I-0003I3-6e
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 13:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757414AbZKKMKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 07:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756862AbZKKMKl
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 07:10:41 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8179 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318AbZKKMKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 07:10:41 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N8C27-00083u-OK; Wed, 11 Nov 2009 13:10:43 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6678710541; Wed, 11 Nov 2009 13:10:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <200911111124.52340.trast@student.ethz.ch>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132645>

Thomas Rast schrieb:
> Johannes Sixt wrote:
>> Furthermore, --subdirectory-filter supplies its own '--', and if the user
>> provided one himself, such as in
>>
>>   git filter-branch --subdirectory-filter subdir -- --all -- subdir/file
>>
>> 	an extra '--' was used as path filter in the call to git-rev-list that
>> determines the commits that shall be rewritten.
> 
> There's some stray space here that should probably also be removed.

Oh, right. Junio, you can pick up the 2-patch series from

  git://repo.or.cz/git/mingw/j6t.git filter-branch

-- Hannes
