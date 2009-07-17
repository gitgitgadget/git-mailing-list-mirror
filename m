From: Antony Stubbs <antony.stubbs@gmail.com>
Subject: Re: cvs import and internal plumbing commands
Date: Sat, 18 Jul 2009 09:44:08 +1200
Message-ID: <7590CBC0-25BA-41D4-9BB5-40550A6CDDF6@gmail.com>
References: <B9FEA72A-882C-4CF9-97A3-A353F282ACBB@gmail.com> <20090716100121.GA6742@coredump.intra.peff.net>
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 17 23:45:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRvFD-0001Yn-Eh
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 23:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757885AbZGQVoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 17:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757883AbZGQVoJ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 17:44:09 -0400
Received: from mail-px0-f185.google.com ([209.85.216.185]:51639 "EHLO
	mail-px0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520AbZGQVoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 17:44:09 -0400
Received: by pxi15 with SMTP id 15so768234pxi.33
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 14:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=dcTqpfPetY1oSJoJ291tAjkxvl7o5esyLW+MCSCGYHk=;
        b=Fr8KTW5faaRwMynE91y9HSaYjTf38zzIJgbwcvJuU2U81cpL0nXkzaXJpeHylavJkW
         E/FWWmO9axzEYBCkH6p9k5XrhAeY6HNAAwfGRSvW3n8u6uT8/aCDqzgD5hhQoH09H1r/
         yZ3RglPMRPOUgw6kmELUNPJU1FsRc8O29TE94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=ElCrGKaLvFMRDbqMv+CiDluAec9uTjjdObxPRZItb+1MAANcz5J6mefbCwQ9cJAO46
         Dw77v4VOKc0mRCEc8F7YRbgb9T9af5ck2GfmEtaiWA73V1Icd9ESlKwS0MibNMuj0kVk
         +5BYwFWTaNSTfIENIeI2xF2z1rvk1q1HcMYNY=
Received: by 10.114.154.14 with SMTP id b14mr1125997wae.208.1247867048696;
        Fri, 17 Jul 2009 14:44:08 -0700 (PDT)
Received: from ?121.90.28.174? ([121.90.28.174])
        by mx.google.com with ESMTPS id l28sm3640391waf.19.2009.07.17.14.44.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Jul 2009 14:44:07 -0700 (PDT)
In-Reply-To: <20090716100121.GA6742@coredump.intra.peff.net>
X-Mailer: iPhone Mail (7A341)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123490>

On 16/07/2009, at 10:01 PM, Jeff King <peff@peff.net> wrote:

> On Sun, Jul 05, 2009 at 02:43:01PM +1200, Antony Stubbs wrote:
>
>> I've got a new install from mac-ports and am having trouble with cvs
>> import not finding the plumbing commands.
>>
>> It seems that cvsimport still uses all the old style git-hash-object
>> type commands, instead of the new " git hash-object" command style.
>> And on my system, I don't have any of the old style commands.
>
> The old style commands should be in the execdir (e.g.,
> /usr/local/libexec/git-core). That directory should be placed at the
> beginning of the PATH when you run "git cvsimport".
>
> If you run "git --exec-path", what directory does it print? If you  
> go to
> that directory, is it filled with dashed git commands?
>
> -Peff

Ok cool, I'll have a look when I get home.

But should we not migrate it for the future anyway? An at least that  
way it would work by default, in this environment?

Cheers,
Antony

www.sharca.com
