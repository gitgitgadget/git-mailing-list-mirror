From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Nov 2009, #04; Tue, 17)
Date: Wed, 18 Nov 2009 17:12:57 +0100
Message-ID: <4B041D09.8090009@viscovery.net>
References: <7v7hto46ce.fsf@alter.siamese.dyndns.org> <fcaeb9bf0911180643w5e659340jd845aa202e6feca3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 17:13:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAn9a-0001bx-Pg
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 17:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757110AbZKRQM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 11:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755851AbZKRQM4
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 11:12:56 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:13478 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755835AbZKRQM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 11:12:56 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NAn9N-0004Vz-F9; Wed, 18 Nov 2009 17:12:58 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2E27E9F88; Wed, 18 Nov 2009 17:12:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <fcaeb9bf0911180643w5e659340jd845aa202e6feca3@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133188>

Nguyen Thai Ngoc Duy schrieb:
> On 11/18/09, Junio C Hamano <gitster@pobox.com> wrote:
>>  * nd/sparse (2009-08-20) 19 commits.
>>
>>  The latest update I didn't look at very closely but I had an impression
>>  that it was touching very generic codepath that would affect non sparse
>>  cases, iow the patch looked very scary (the entire series already is).
> 
> I wonder if there is any other approach for sparse checkout? I'll see
> if I can improve it, but with a series touching unpack logic, diff
> core, .gitattributes/.gitignore, it's hard to get it right and
> obvious.

Just FYI: I run some of my installations with this series, but without
using sparse checkout to see if there are regressions. Nothing came up so
 far.

-- Hannes
