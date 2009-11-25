From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git repository mesh?
Date: Wed, 25 Nov 2009 19:23:29 +0100
Message-ID: <vpqfx82a2fy.fsf@bauges.imag.fr>
References: <fcaeb9bf0911242007t1294bddej87b48691ea283e21@mail.gmail.com>
	<vpqaaybf37f.fsf@bauges.imag.fr>
	<fcaeb9bf0911250000u395c0153q43c8c7a60ca9b876@mail.gmail.com>
	<vpqy6lues5j.fsf@bauges.imag.fr>
	<fcaeb9bf0911250416u7e363ab2yf9334bad09f957fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 19:26:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDMZa-0004cx-Mm
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 19:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758999AbZKYS00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 13:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758996AbZKYS00
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 13:26:26 -0500
Received: from imag.imag.fr ([129.88.30.1]:54357 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758960AbZKYS0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 13:26:25 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nAPINUDQ023538
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Nov 2009 19:23:30 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NDMWX-0004rK-OP; Wed, 25 Nov 2009 19:23:29 +0100
In-Reply-To: <fcaeb9bf0911250416u7e363ab2yf9334bad09f957fb@mail.gmail.com> (Nguyen Thai Ngoc Duy's message of "Wed\, 25 Nov 2009 19\:16\:38 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 25 Nov 2009 19:23:30 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133657>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On 11/25/09, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Then, fetch from all of them and:
>>
>>   git log ^HEAD repo1/master repo2/master repo3/master
>
> Very nice. Thanks I did not know about "^HEAD".

Read "not HEAD", this means "remove the ancestry of HEAD in the output".

See "man git-rev-parse" for details.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
