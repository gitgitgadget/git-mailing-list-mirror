From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Mon, 17 Dec 2012 09:20:36 +0100
Message-ID: <50CED5D4.5040705@viscovery.net>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com> <1355726702-27974-2-git-send-email-chris@rorvick.com> <7vhanlnnz7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 09:21:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkVwc-0004FC-I4
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 09:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938Ab2LQIUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 03:20:44 -0500
Received: from so.liwest.at ([212.33.55.24]:13271 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768Ab2LQIUo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 03:20:44 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TkVwD-0002Km-Lu; Mon, 17 Dec 2012 09:20:37 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2574D1660F;
	Mon, 17 Dec 2012 09:20:37 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vhanlnnz7.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211657>

Am 12/17/2012 8:21, schrieb Junio C Hamano:
> Chris Rorvick <chris@rorvick.com> writes:
>>  'git checkout' [<branch>]::

Is <branch> really optional in this form?

BTW, what does plain 'git checkout' do? Just report ahead/behind information?

>> +
>> +	Update the index, working tree, and HEAD to reflect the
>> +	specified branch.
...
>> +'git checkout' [--detach] [<commit>]::

The title here is better spelled as two lines:

'git checkout' <commit>::
'git checkout' --detach <branch>::

I don't think that <commit> or <branch> should be indicated as optional here.

>> +
>> +	Update the index and working tree to reflect the specified
>> +	commit and set HEAD to point directly to <commit> (see
>> +	"DETACHED HEAD" section.)  Passing `--detach` forces this
>> +	behavior even if <commit> is a branch.
> 
> 	Prepare to work on building new history on top of <commit>,
>         by detaching HEAD at the commit and ...(likewise)...

-- Hannes
