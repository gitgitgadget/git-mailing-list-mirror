From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: push fails -- temporary sha1, no such file / corruptiion ???
Date: Wed, 22 Jul 2009 15:04:28 +0800
Message-ID: <be6fef0d0907220004n70c583f9u1852871df7686ed1@mail.gmail.com>
References: <1248229319591-3297467.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: lytles <srlytle.list@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 09:04:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTVsT-0003to-Ha
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 09:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbZGVHEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 03:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbZGVHEa
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 03:04:30 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:51501 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbZGVHE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 03:04:29 -0400
Received: by gxk9 with SMTP id 9so6308356gxk.13
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 00:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=q9F2yS86Q4uvxlsxFL3A7i7EQ4sF2HeY6Hd6gJjzOnU=;
        b=YKCcHvMYWrGH2CJfo+gL1v6c95wexylqKlyjgLqGtYvny64lJZt49VQ+Ngha7OSR6E
         s8myHNfO5QNrSXQf4o5mwTjfpchiuN7Q/Pz+koHn+XzxOzJtBbg5CP+tjMHBFXTJd+9U
         TswgKugGBM+tpNBiF3YkpcwYuxfFDuuUX/CZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vxp/p989QTDQCfnk4VZobB1870di1MGj9+l09QJfY0nIa4npjCLG0nvGg3fy6hd5/N
         MjTe5EtEXrH6U/OQNOYZ1Cc7/RUr0G72u9OZLMAlD0YPqfzTzdi4FzKGZP+BJL1c768I
         8gc8lrw+dYLaUSethgPvdmLy50VamDE3/4Pxw=
Received: by 10.231.14.4 with SMTP id e4mr204926iba.33.1248246268997; Wed, 22 
	Jul 2009 00:04:28 -0700 (PDT)
In-Reply-To: <1248229319591-3297467.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123740>

Hi,

On Wed, Jul 22, 2009 at 10:21 AM, lytles<srlytle.list@gmail.com> wrote:
> the "object/2f" varies with attempts to push from different remote repos,
> but it's always an "object/??". multiple attempts to push from the same
> remote repo always results in the same "object/??"

have you checked the permissions on your remote repo, particularly the
objects/ directory?

This is just a shot in the dark. I used to have pushes failing due to
stricter permissions on the remote side.

-- 
Cheers,
Ray Chuan
