From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: Can I forbid somebody to pull some branch or tag from my repo with git protocol?
Date: Wed, 17 Dec 2008 12:53:13 +0100
Message-ID: <bd6139dc0812170353y5d78f03ao1c0619c9bd68f309@mail.gmail.com>
References: <856bfe0e0812170103w1007cf4fs1e83e506c6dd909@mail.gmail.com>
	 <7v1vw7p3r8.fsf@gitster.siamese.dyndns.org>
	 <856bfe0e0812170115p73d72495ve81046127e68c281@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Emily Ren" <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 12:54:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCuz3-0006oH-MP
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 12:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbYLQLxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 06:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbYLQLxP
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 06:53:15 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:43125 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbYLQLxO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 06:53:14 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1530272yxm.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 03:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=OgWoPKHHkzg87Hi1OBoMP/f1GIz9hTxob6fl+9zJYtw=;
        b=gVO8NrMgbrNEcsuSU1RM11JdgdKMu4b3vMudWCRLnFVl+mZEgbJa2vjsXujNV6mdkO
         J/MW8dQCZ/623Asn3aKpj2w6JMatUVbH1W9byyeOMPWIP4DOHipWZSl0YPtt4fqz0mnT
         T3vfSlEpmaK0Anw7HU/FEjKUS9lyB2yjJXoCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=x3gIhinf/ehOY1j0kYeOC6ccSwgLx8QgXdGoExNBXaQk13HqIJSkPbyDW9IzLb6W5J
         IJkrToBq9ejrQsdtJqJzy3avnoUX7kTK+F1pSw3fj96R3GEd+G1LfNiwjeoIJJOOQIFF
         5miHLGFjnDF9Oq68c1gk/LHeJLuoo/3VX3LM0=
Received: by 10.151.112.3 with SMTP id p3mr1199519ybm.216.1229514793227;
        Wed, 17 Dec 2008 03:53:13 -0800 (PST)
Received: by 10.151.13.13 with HTTP; Wed, 17 Dec 2008 03:53:13 -0800 (PST)
In-Reply-To: <856bfe0e0812170115p73d72495ve81046127e68c281@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: f1ef39fa14acc7f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103335>

On Wed, Dec 17, 2008 at 10:15, Emily Ren <lingyan.ren@gmail.com> wrote:
> I want some group can pull these branches or tags from my repo, while
> other's can't, Need I maintain two repositories ?

I think gitosis should be able to do that? Otherwise you could look
into hosting sites like github or gitorious, I think they have at
least some form of access control, yes?

-- 
Cheers,

Sverre Rabbelier
