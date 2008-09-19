From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit RFC PATCH] tg mail: new command for mailing patches
Date: Fri, 19 Sep 2008 11:52:03 +0200
Message-ID: <36ca99e90809190252q45f01eb2xd02b62b88f0cf3a9@mail.gmail.com>
References: <1221815301-25090-1-git-send-email-kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Kirill Smelkov" <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Fri Sep 19 11:53:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgcfr-0005n7-4C
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 11:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbYISJwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 05:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbYISJwF
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 05:52:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:13831 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbYISJwE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 05:52:04 -0400
Received: by wx-out-0506.google.com with SMTP id h27so89234wxd.4
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 02:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PeN36njE9N3DMQ6GcTJW2p0x0HUPog4A/bzq+mO5Cm0=;
        b=Uo8CI1A9tHfT4kg//7Y+6nZO6fDSKpzFBoMY1/mNkzxYhfWHENlW1PaRwkU6eMNcMf
         1TOi5eXHTiy9lf0syKc+dIBIOKL84MD/59Npn16CC9TY5y4fgCb/qw99fWhDNNNWV197
         uKfjp6l1+klfuEjtyU80l1CMoCXi657IV8VGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JS7/CfbqbnATMniX9LqQfKXMKyMB+mjNdB69nL41g3vezffAIDL5Fx08b/7yRO4F+u
         mpjezGwhjG6D8+eB+yQktobS0TTCNqqaEnONsXtaig0wvLc6jj2G0h/0k+grtsyWgc9B
         rIkPESwXyB+1F48KZeGSoG7j6x2OZtvLwiCfk=
Received: by 10.70.49.9 with SMTP id w9mr5754670wxw.55.1221817923133;
        Fri, 19 Sep 2008 02:52:03 -0700 (PDT)
Received: by 10.70.36.14 with HTTP; Fri, 19 Sep 2008 02:52:03 -0700 (PDT)
In-Reply-To: <1221815301-25090-1-git-send-email-kirr@landau.phys.spbu.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96271>

On Fri, Sep 19, 2008 at 11:08, Kirill Smelkov <kirr@landau.phys.spbu.ru> wrote:
> Petr, since you've asked for help on this, here you are:
>
>    $ tg mail [NAME]
>
> a simple script to send one patch over email.
>
>
> All it does is
>
>    - call `tg patch` for actual patch preparation
>    - extract email addresses from whom and where to send a mail
That shouldn't be needed. git send-email parses Cc: headers and the
To: comes from 'git config topgit.to', so you can re-use this.

Bert
