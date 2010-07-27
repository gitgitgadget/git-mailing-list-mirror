From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: question (possibly) on git subtree/submodules
Date: Tue, 27 Jul 2010 05:48:09 -0700 (PDT)
Message-ID: <m3bp9tks6e.fsf@localhost.localdomain>
References: <xotjlj92i9gr.fsf@leonardo.pit.corp.google.com>
	<4C49C9C6.3080409@gmail.com> <loom.20100727T125434-697@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex <ajb44.geo@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 14:48:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdjZz-0008Sq-Cg
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 14:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542Ab0G0MsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 08:48:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44635 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab0G0MsL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 08:48:11 -0400
Received: by fxm14 with SMTP id 14so588199fxm.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=SLoPk3rDWaKhUXBbl95g7idoWsS5NMX8i41p+dYWCi8=;
        b=TI1Z0oDkND2xooFfAv3pURhcfWsScD84dIAy4iQo+PbMIPsjrMXVVfrLzGKLrxHZ7G
         DidY/XAVf3/ivcPI2Qbp+7bu9DsTEvLdJwbWAKFE/Ud0XUAAi1YjHrfrTFX435P+zMa3
         PSKPYegbkX2+TQBJde7F8xqiwzkOp2GGT3Dpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=MkPVkGjOrpeNXlqM0rJ+fJEFaNKDbNd56X7yZSqMFK7l3iSsYmXO5Z4AhuZ5ONzb/o
         J1b0fuj5jy/MKWCiFxWPRypy5Yu5Fv+GIWDsM5NhCxDApt7iuR3xNFzxu0J8/8tGlZnI
         njuYSnMqkalMUw4oKPst1aocKymcBZVFWEWZU=
Received: by 10.223.103.80 with SMTP id j16mr7935296fao.100.1280234889709;
        Tue, 27 Jul 2010 05:48:09 -0700 (PDT)
Received: from localhost.localdomain (abvi50.neoplus.adsl.tpnet.pl [83.8.206.50])
        by mx.google.com with ESMTPS id l12sm1889800fan.1.2010.07.27.05.48.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 05:48:09 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6RCla7i029375;
	Tue, 27 Jul 2010 14:47:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6RClLfX029371;
	Tue, 27 Jul 2010 14:47:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20100727T125434-697@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151936>

Alex <ajb44.geo@yahoo.com> writes:

> Chris Packham <judge.packham <at> gmail.com> writes:
> 
> > The short answer is no. Nothing git has currently will let you clone a
> > subset of files. 
> 
> Isn't that what 'sparse checkout' does?
> (http://www.kernel.org/pub/software/scm/git/docs/git-read-tree.html#_sparse_checkout)

No, 'sparse checkout' is only about checkout, i.e. the working area.
You still have all objects in repository, only part of tree (part of
project / repository) is not checked out, not present on disk as
files.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
