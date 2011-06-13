From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: git diff --added (Re: Command-line interface thoughts)
Date: Mon, 13 Jun 2011 21:47:18 +0200
Message-ID: <4DF66946.8000101@ira.uka.de>
References: <201106051311.00951.jnareb@gmail.com> <201106101844.16146.jnareb@gmail.com> <4DF25D50.5020107@ira.uka.de> <201106102035.42525.jnareb@gmail.com> <4DF29EA5.60502@ira.uka.de> <20110613034347.GA4222@elie> <buotybu2wx7.fsf@dhlpc061.dev.necel.com> <7vmxhlrk3m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miles Bader <miles@gnu.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 21:48:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWD7B-0003sd-Tt
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 21:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab1FMTr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 15:47:56 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33500 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752045Ab1FMTr4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2011 15:47:56 -0400
Received: from dslb-088-066-038-210.pools.arcor-ip.net ([88.66.38.210] helo=[192.168.2.231])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 465 
	id 1QWD6t-0004Un-RP; Mon, 13 Jun 2011 21:47:49 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
In-Reply-To: <7vmxhlrk3m.fsf@alter.siamese.dyndns.org>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1307994469.642884000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175729>

Am 13.06.2011 14:28, schrieb Junio C Hamano:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>> Do you think it would be valuable to introduce --added as a synonym
>>> for --cached and slowly steer documentation to encourage the latter
>>> in place of the former?

No. Apart from Junios reason more options won't help that much because
git is already loaded with options (git diff for example has 49). Don't
misinterpret this as a suggestion to remove options, just that an option
in this sea of options must be very obvious to help the casual user.
And "git diff --added" is not telling with what it compares the "added"
files, which means you either know the concept or you have to read the
man page whenever you need to use it. Until you fix it in your memory,
which may be never because you don't use it often enough.

> It is an entirely different issue that "cached" is _not_ the best way to
> spell "index-only", though.

Yes, and the one and only word that would be right here (apart from
spelling it out with index-only) is "index", while "index" as used in
git stash and git apply should have been something like 'with-index'. At
least to me '--something' suggests 'something-only' much more than
'something-too'

Since this is not possible anymore, we are stuck with 'cache' and
essentially a diff-command that will never be user-friendly. That is why
I still think that an alternate usage with 'git diff wtree index' would
be beneficial, especially with a corresponding 'git put'.

Holger.
