From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH/RFC v2] Do not strip empty lines / trailing spaces from
 a commit message template
Date: Sun, 08 May 2011 14:28:56 +0200
Message-ID: <4DC68C88.7030604@gmail.com>
References: <4DC65888.7090309@gmail.com> <1304850662-6424-1-git-send-email-billiob@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:29:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ36t-00071p-JY
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab1EHM3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 08:29:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:38349 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753207Ab1EHM3J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:29:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QJ36g-0006wF-UW
	for git@vger.kernel.org; Sun, 08 May 2011 14:29:07 +0200
Received: from p5ddb0006.dip0.t-ipconnect.de ([93.219.0.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 May 2011 14:29:06 +0200
Received: from sschuberth by p5ddb0006.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 May 2011 14:29:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb0006.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <1304850662-6424-1-git-send-email-billiob@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173153>

On 08.05.2011 12:31, Boris Faure wrote:

> Templates should be just that: A form that the user fills out, and forms
> have blanks. If people are attached to not having extra whitespace in the
> editor, they can simply clean up their templates.
>
> Added test with editor adding even more whitespace.
>
> Signed-off-by: Boris Faure<billiob@gmail.com>
> Based-on-patch-by:Sebastian Schuberth<sschuberth@gmail.com>

Thanks for rebasing the patch and adding the test! I've run the whole 
test suite on Linux, and all tests pass for me (including the added one).

-- 
Sebastian Schuberth
