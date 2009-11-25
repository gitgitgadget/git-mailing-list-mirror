From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git repository mesh?
Date: Wed, 25 Nov 2009 12:54:32 +0100
Message-ID: <vpqy6lues5j.fsf@bauges.imag.fr>
References: <fcaeb9bf0911242007t1294bddej87b48691ea283e21@mail.gmail.com>
	<vpqaaybf37f.fsf@bauges.imag.fr>
	<fcaeb9bf0911250000u395c0153q43c8c7a60ca9b876@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 12:54:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDGSN-0002Tl-4q
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 12:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934471AbZKYLyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 06:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934397AbZKYLyf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 06:54:35 -0500
Received: from mx1.imag.fr ([129.88.30.5]:53307 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934241AbZKYLye (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 06:54:34 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nAPBqnfw020329
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Nov 2009 12:52:49 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NDGS9-0006ys-1B; Wed, 25 Nov 2009 12:54:33 +0100
In-Reply-To: <fcaeb9bf0911250000u395c0153q43c8c7a60ca9b876@mail.gmail.com> (Nguyen Thai Ngoc Duy's message of "Wed\, 25 Nov 2009 15\:00\:28 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 25 Nov 2009 12:52:50 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAPBqnfw020329
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1259754772.2416@Uak0Wb+tk8NFSCwlgVxNlg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133632>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Nov 25, 2009 at 2:55 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> Never used Mercurial but the idea of "git in" and "git out" to see how
>>> many commits ahead/behind would be nice.
>>
>> In Git, you'd run "git fetch" to get everything locally, and then
>>
>> git log ..origin/master => what origin/master has that you don't
>> git log origin/master.. => what you have that origin/master doesn't
>>
>> (and you can define aliases for that)
>
> But I have many origins (any repository could be origin). "git status"
> also have this kind of information, but only for "origin".

Then, fetch from all of them and:

  git log ^HEAD repo1/master repo2/master repo3/master

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
