From: greened@obbligato.org (David A. Greene)
Subject: Re: Git subtree stumbles over annotated tags
Date: Sat, 21 May 2016 18:02:41 -0500
Message-ID: <87iny7ovzi.fsf@waller.obbligato.org>
References: <56E19809.5040305@googlemail.com>
	<56EAA5DC.1040801@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Gregor Jasny <gjasny@googlemail.com>
X-From: git-owner@vger.kernel.org Sun May 22 01:02:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Fv1-00047v-31
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 01:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbcEUXCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 19:02:44 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:57750 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751551AbcEUXCn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 19:02:43 -0400
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.86)
	(envelope-from <greened@obbligato.org>)
	id 1b4Fur-0004Dc-W7; Sat, 21 May 2016 18:02:42 -0500
In-Reply-To: <56EAA5DC.1040801@googlemail.com> (Gregor Jasny's message of
	"Thu, 17 Mar 2016 13:41:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295239>

Gregor Jasny <gjasny@googlemail.com> writes:

> Hello,
>
> On 10/03/16 16:51, Gregor Jasny wrote:
>> today I discovered that it's a bad idea to "git subtree pull" from an
>> annotated tag. This issue got discussed in those two threads:
>>
>> http://comments.gmane.org/gmane.comp.version-control.git/247503> http://comments.gmane.org/gmane.comp.version-control.git/248395>
>> I was under the impression that it is fixed in recent versions of git
>> but my homebrew 2.7.0 still behaves badly. If I run the attached script
>> to reproduce the issue I get the following error message:
>
> For the record: this bug was already fixed in November:
> https://github.com/git/git/commit/5d65fe312e22594b7fec7349945fb0072987716b#diff-59f70cbe935ec223e3df413b94cab740
>
> Would it make sense to cherry-pick it into 2.7.x?

I wouldn't object to it if you can prepare the patch but git-subtree is
under heavy development and I don't have the free cycles to maintain a
"release" version of it.

                      -David
