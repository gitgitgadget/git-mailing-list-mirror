From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Choosing a mergetool according to file type
Date: Fri, 26 Jun 2009 14:04:59 +0200
Message-ID: <vpqd48rw68k.fsf@bauges.imag.fr>
References: <C66A69E6.205F2%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Gregory Jefferis <jefferis@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 14:07:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKADN-0003WT-Oc
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 14:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464AbZFZMHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 08:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbZFZMHV
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 08:07:21 -0400
Received: from imag.imag.fr ([129.88.30.1]:55906 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbZFZMHV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 08:07:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n5QC4xKW021075
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2009 14:05:00 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MKAAt-0001x9-N2; Fri, 26 Jun 2009 14:04:59 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MKAAt-0000f6-Le; Fri, 26 Jun 2009 14:04:59 +0200
In-Reply-To: <C66A69E6.205F2%jefferis@gmail.com> (Gregory Jefferis's message of "Fri\, 26 Jun 2009 12\:04\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 26 Jun 2009 14:05:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122294>

Gregory Jefferis <jefferis@gmail.com> writes:

> Hi Johannes,
>
> On 2009-06-26 11:43, "Johannes Sixt" <j.sixt@viscovery.net> wrote:
>
>> I don't think that you can choose the merge tool by setting attributes.
>
> OK, that was my impression, but I wanted to check.

Never used it, but man gitattributes says

   Performing a three-way merge
       merge
[...]
              String
                 3-way merge is performed using the specified custom merge driver. The built-in 3-way merge driver can be explicitly specified by asking
                 for "text" driver; the built-in "take the current branch" driver can be requested with "binary".
[...]
       Defining a custom merge driver

Is it not what you're looking for?

-- 
Matthieu
