From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: Guided merge with override
Date: Tue, 17 Jun 2008 08:15:50 +0930
Message-ID: <93c3eada0806161545m5c6e1073q5522ce31f72be9f0@mail.gmail.com>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com>
	 <20080616092554.GB29404@genesis.frugalware.org>
	 <48563D6C.8060704@viscovery.net>
	 <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jun 17 00:46:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8NTL-0002ba-6Z
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 00:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041AbYFPWpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 18:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757023AbYFPWpw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 18:45:52 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:29482 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbYFPWpv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 18:45:51 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3548340fkq.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lsEHHzq2+tYP3tgoqlRjV+aLfU43zzl3gw9dWGXyTJ4=;
        b=q4UYDr/0lHExWOd3VlH7NkcOaT8rtSbG21Ssd9rpx85NiAoScbeh2DgFw7n7bZ5ou+
         oDoJPDuxuVYTV+6FIZXj880ygTSBAD/9efAA5WgFjXtkVfRFHfBqg07Y0rOXSA1nRcIb
         7RI7BXHsT5IO35hMj/D3pzRUafmTWJSDLbIvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=B6a3C0HIenZJtbFcdgVIryUhFNpoQ7vO4HfeG8kyrQw34kkXSYdS0JaH/ku6fqBcOr
         SZPChy/F64knV+gBef8qCLxw842r93EAvhzrFWJesXEPunijPNBs12Yc0jdhl2Bx48nY
         GDeH2UhCyFEJYk7CWyAM4nTu/50nJMn+6+iFw=
Received: by 10.82.126.5 with SMTP id y5mr406841buc.89.1213656350159;
        Mon, 16 Jun 2008 15:45:50 -0700 (PDT)
Received: by 10.82.107.11 with HTTP; Mon, 16 Jun 2008 15:45:50 -0700 (PDT)
In-Reply-To: <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85245>

Thanks everybody,

On 6/17/08, Sverre Rabbelier <alturin@gmail.com> wrote:
> On Mon, Jun 16, 2008 at 12:16 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>  > The solution depends on whether *all* files in B should be taken, or only
>  > those files in B where there's a merge conflict. I don't know an easy way
>  > to do the former, but the latter I'd do like this:
>  >
>  >        $ git diff --name-only | xargs git checkout B --

This looks like a manageable approach and better than the scripting I was
thinking about -- ie. scan the conflict files with perl and fix them!

Cheers,
Geoff

>
>
> Wouldn't something similar work but do a 'git ls-files' and filter it
>  on files that have a merge conflict?
>
>  --
>  Cheers,
>
>
>  Sverre Rabbelier
>


-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
