From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: .git as file pointing to directory?
Date: Thu, 04 Nov 2010 21:35:16 +0100
Message-ID: <4CD31904.5040308@web.de>
References: <AANLkTikB4p9=EQRsAJTe4-nAw5udz2pfcRd4WPsfms86@mail.gmail.com> <vpqpqulc52q.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad Larson <bklarson@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Nov 04 21:35:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE6X7-0004jh-HP
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 21:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880Ab0KDUfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 16:35:21 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:55083 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807Ab0KDUfS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 16:35:18 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 601AF17DE655F;
	Thu,  4 Nov 2010 21:35:17 +0100 (CET)
Received: from [93.246.52.145] (helo=[192.168.178.29])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PE6Wj-00030S-00; Thu, 04 Nov 2010 21:35:17 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <vpqpqulc52q.fsf@bauges.imag.fr>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19m4+lFPM2L31pnLmHNPmALG+aRXThiCMBfJxmq
	dWP+xkvb7Qp6xTW+OfBEyWXrP3sGxwfWa8RwmF+/4R+jhIOYIf
	HJoONBrl+0hDhOnmVwyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160761>

Am 04.11.2010 19:32, schrieb Matthieu Moy:
> Brad Larson <bklarson@gmail.com> writes:
> 
>> Sorry if this is obvious, I can't figure out what term to search for.
>>
>> At gittogether there was some talk about having .git be a file, not a
>> folder, with contents pointing to the real .git directory.  Similar to
>> a symlink, but supported in Windows.  Is there a specific name for
>> this feature?  Where can I find more details?  Which version of git
>> introduced this?
> 
> It has been discussed under the name "gitlink", which was
> unfortunately also used for something else in the subtree
> implementation, but AFAIK, it has never been implemented.

Hmm, AFAIK gitlinks are already in heavy use for submodule entries ...
