From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v2 1/2] git-show: fix 'git show -s' to not add extra
 terminator after merge commit
Date: Tue, 13 May 2014 23:15:12 +0300
Message-ID: <20140513201511.GC6857@wheezy.local>
References: <20140512230943.GC32316@wheezy.local>
 <20140512231029.GD32316@wheezy.local>
 <5371B434.7010506@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:15:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJ6e-0005cQ-GB
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbaEMUPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:15:17 -0400
Received: from p3plsmtpa07-02.prod.phx3.secureserver.net ([173.201.192.231]:37268
	"EHLO p3plsmtpa07-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751596AbaEMUPP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2014 16:15:15 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa07-02.prod.phx3.secureserver.net with 
	id 1YF91o00T3gsSd601YFC8x; Tue, 13 May 2014 13:15:15 -0700
Content-Disposition: inline
In-Reply-To: <5371B434.7010506@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248812>

On Tue, May 13, 2014 at 07:57:08AM +0200, Johannes Sixt wrote:
> Am 5/13/2014 1:10, schrieb Max Kirillov:
>> --- a/t/t7007-show.sh
>> +++ b/t/t7007-show.sh
>> @@ -25,6 +25,7 @@ test_expect_success 'set up a bit of history' '
>>  	git checkout -b side HEAD^^ &&
>>  	test_commit side2 &&
>>  	test_commit side3
>> +	test_merge merge main3
>>  '
> 
> Broken &&-chain.

Thank you, will fix it.

-- 
Max
