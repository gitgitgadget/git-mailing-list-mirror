From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit: lost all my patches again
Date: Thu, 4 Oct 2007 09:06:22 -0400
Message-ID: <9e4733910710040606j75caa6bcn1e97e59c1285eb4b@mail.gmail.com>
References: <9e4733910710032229m38fb4e47k5aa0b2b2e0eb2251@mail.gmail.com>
	 <20071004083304.GB17778@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 15:07:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdQPR-0006Qq-7M
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 15:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbXJDNGZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 09:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbXJDNGZ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 09:06:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:11320 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048AbXJDNGY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2007 09:06:24 -0400
Received: by wa-out-1112.google.com with SMTP id v27so193570wah
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 06:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=C6cBXCpUxpVm4Wd/jtcBbgPgbNFCvF6nZzue+B5VAT8=;
        b=U+A5h9hahc3F1G8+Gaxx8W/faaMNRH1aMkPVDWrzhpLMjz02muHchkj3MYWX0xThjryPKkoZgmTK4QCknfy1viFo0iAxmzU/t8g+HAnTAjL6gWwpluGw7VCO8QqOkJz3cYX8052ISwOg5N038pkeyn+ONBDGdPySPJsfZx0pBdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gXQXPAjHvWJ7hx7iD4mbOIQTOWiN9UOzziEiior0g4KvAk2FwihBUBK5h3WaZSziwx/ZidvrwFhcXdb6H3RZuxlUo+KJTTTbOaRruM8QR1Z8qV0zY9mWlXetvErhEATIm11uBfnFtAAL7xjIFZ437tlwiz65RUqeE0AiZp0ha7k=
Received: by 10.114.53.1 with SMTP id b1mr7173971waa.1191503182932;
        Thu, 04 Oct 2007 06:06:22 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Thu, 4 Oct 2007 06:06:22 -0700 (PDT)
In-Reply-To: <20071004083304.GB17778@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59947>

On 10/4/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Mmmph. This is not the only StGit command that's apparently not safe
> to run from a subdirectory. See e.g. https://gna.org/bugs/?9986.
>
> I plan to do some StGit hacking this weekend. I guess subdirectory
> safeness ought to be at the top of my list ...

Isn't a rollback log fairly easy to implement? Is there a single SHA
after each operation? If so just record the commands and the sha to
rollback.

I have also messed things up more than once using 'git merge linus'
instead of 'stg rebase linus'. Should 'git merge' have a check to see
if stg is active and refuse to run?

--=20
Jon Smirl
jonsmirl@gmail.com
