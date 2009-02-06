From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Count the line of codes
Date: Fri, 06 Feb 2009 13:50:59 +0100
Message-ID: <vpqy6wjg24s.fsf@bauges.imag.fr>
References: <21868069.post@talk.nabble.com> <gmgs1u$lsv$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 13:57:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVQGm-0005Fk-8t
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 13:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbZBFMzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 07:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbZBFMzw
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 07:55:52 -0500
Received: from imag.imag.fr ([129.88.30.1]:58544 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbZBFMzv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 07:55:51 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n16Coxm7018439
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Feb 2009 13:50:59 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LVQAd-0005lS-EF; Fri, 06 Feb 2009 13:50:59 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LVQAd-0003Wv-Bs; Fri, 06 Feb 2009 13:50:59 +0100
In-Reply-To: <gmgs1u$lsv$1@ger.gmane.org> (Johannes Gilger's message of "Fri\, 6 Feb 2009 08\:23\:26 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 06 Feb 2009 13:50:59 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108696>

Johannes Gilger <heipei@hackvalue.de> writes:

> On 2009-02-06, zyk <zhengyuk@hotmail.com> wrote:
>>
>> Does anyone know if there is any tools available for counting the line of
>> codes in the project using GIT?
>
> wc -l *.c *.h for example would count the lines of all c-files and 
> their headers.

wc for the total number of lines in files, or
http://www.dwheeler.com/sloccount/ to get the number of lines of code
(excluding blank lines and such).

-- 
Matthieu
