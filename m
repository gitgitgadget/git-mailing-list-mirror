From: pi song <pi.songs@gmail.com>
Subject: Re: [PATCH2/2] Libify blame
Date: Tue, 17 Mar 2009 10:11:05 +1100
Message-ID: <1b29507a0903161611w735d3ed2l958eeec9295c7432@mail.gmail.com>
References: <49BE5466.5050202@gmail.com>
	 <fabb9a1e0903160649o6b576976jeb884e18713c154e@mail.gmail.com>
	 <20090316200418.GM3817@genesis.frugalware.org>
Reply-To: pi.songs@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: rene.scharfe@lsrfire.ath.cx
To: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 17 00:12:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjLz3-00041I-9u
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 00:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762224AbZCPXLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 19:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762202AbZCPXLJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 19:11:09 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:10826 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761997AbZCPXLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 19:11:07 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2166548wfa.4
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 16:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bVgmJpm2iNYOKAC+FhlfHasecWWF4e4G7cKI0ee84YU=;
        b=lxqIU11ocMe7FRMSYtPbsuY0FJ2NY9ZGowqJU1wwmImxCcLPpkBhMj9KJbh+Lmq307
         5VSKPpETObaEpGN2ygJHpU1M/YSjyh4+qKoKKeBttdmSqSx46cq1ZEMJpfuRWcF4ByvU
         mYoexuTvizCNnpV43xPwzXR5840N1G/Iqflh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=C6qhL1+O6L10lAkNDiuixwlJUke9kxbCvVUBOqZUohjR46Cj9oNLqE03JhnvAEzK/K
         uJeTK2qFqfqWR1gyfnQKx2tUp5H+sf3Obz03MU18rGZIZvV4xjXVoNjwFYio7oHbjcNF
         p4HowqnT4tLxhbky85ZdJeVdQYQaaVwpHOLHk=
Received: by 10.142.105.10 with SMTP id d10mr2373334wfc.71.1237245065258; Mon, 
	16 Mar 2009 16:11:05 -0700 (PDT)
In-Reply-To: <20090316200418.GM3817@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113403>

This was generated from git format-patch -M. After applying the patch,
you can look in git gui to confirm that I didn't change any logic.

Pi Song

On Tue, Mar 17, 2009 at 7:04 AM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Mon, Mar 16, 2009 at 02:49:31PM +0100, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> It would be nice if you could paste the output of "git diff -M" after
>> the triple-dash to show that it is indeed only a small change.
>
> Or just use git format-patch -M?
>
