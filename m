From: "Alf Clement" <alf.clement@gmail.com>
Subject: Re: git-diff question
Date: Thu, 19 Jun 2008 17:55:37 +0200
Message-ID: <556d90580806190855j7f247854m725ed7e6efa48f0b@mail.gmail.com>
References: <556d90580806190448y2bfeebardb05c5b0b91e53a7@mail.gmail.com>
	 <m3tzfpmy2b.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9MV2-0001Ul-So
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 17:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbYFSPzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 11:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbYFSPzk
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 11:55:40 -0400
Received: from gv-out-0910.google.com ([216.239.58.187]:50130 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbYFSPzj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 11:55:39 -0400
Received: by gv-out-0910.google.com with SMTP id e6so128361gvc.37
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cQe/cqGz0P+kRE9DbVPtvKXd0xs2vT/cpuQMCAbvChQ=;
        b=fs5oTYew0r+GFBMRSvXy05VWQG5eNn/GeQ3rSR7Y0D5kAxFeSLVu/nghIs3nzjYGkF
         DQF1kPWYLfJfmOIdKvasFTKcKtCHbq4QSm1RfZJ2zx4qI6FdOolkJJv6bElMo5pLMLJ6
         MbQi0108FabKcTEZHTXTvhrR0J/q/Fo7lPXGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=t1YSUl4HGQ5pRRSpbmN8OEz7siVxk5wi8ZO0+hi+rWWeIcCx8VKsLODudbxrPx5AVn
         LzfKAQkLm0x929SCb3mB42bUJ6qf+DE5IalTMW99w94cId6ky1VrIlqOkEmXvyGFcoqM
         5tOcYfZEG9JxdX2C3WwX/G5QvZrUkgWXgH+VM=
Received: by 10.78.147.6 with SMTP id u6mr1111748hud.67.1213890937796;
        Thu, 19 Jun 2008 08:55:37 -0700 (PDT)
Received: by 10.78.144.6 with HTTP; Thu, 19 Jun 2008 08:55:37 -0700 (PDT)
In-Reply-To: <m3tzfpmy2b.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85485>

Hi,

regarding git diff --help:

 --diff-filter=[ACDMRTUXB*]
        Select only files that are Added (A), Copied (C), Deleted (D),
        Modified (M), Renamed (R), have their type (mode) changed (T),
        are Unmerged (U), are Unknown (X), or have had their pairing

and git diff reports mode changes...

CU,
Alf

On Thu, Jun 19, 2008 at 2:03 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Alf Clement" <alf.clement@gmail.com> writes:
>
>> $ git diff
>> diff --git a/Firmware/Firmware.ccscc b/Firmware/Firmware.ccscc
>> old mode 100755
>> new mode 100644
>> ....
>> returns a list of files where the mode was changed, which seems to be
>> correct. Also
>> modified files are flaged.
>> I wonder why
>> $ git diff --diff-filter=T
>> outputs nothing.
>
> Isn't 'T' about *t*ype change, i.e. change between ordinary file,
> symlink, directory and commit (submodule)?
>
>> I am running this under Cygwin.
>
> Or perhaps this is a cause.
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>
