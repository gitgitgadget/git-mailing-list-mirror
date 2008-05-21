From: "Adam Mercer" <ramercer@gmail.com>
Subject: Re: git cvsimport error
Date: Wed, 21 May 2008 14:39:52 -0500
Message-ID: <799406d60805211239n42c39ea6iaa41a9ab379cafaa@mail.gmail.com>
References: <799406d60805211214r6315268ard77678eb2ec5d732@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 21:40:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyuB4-0007Oy-Qf
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 21:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758354AbYEUTjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 15:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757915AbYEUTjz
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 15:39:55 -0400
Received: from gv-out-0910.google.com ([216.239.58.187]:20464 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756541AbYEUTjy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 15:39:54 -0400
Received: by gv-out-0910.google.com with SMTP id e6so895961gvc.37
        for <git@vger.kernel.org>; Wed, 21 May 2008 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=liK++ugLY4eP3yPHIbCNo/qZafIY+EVRTVeHngs7NMo=;
        b=Lfu+ktnecVvobtVlIzZLwiZGjeOCAjhjV53u2+SnOVu5tlVpjyVmEtHzcidRZBlofLoeZXhyu6od0hfT4GD9MBU2+zO3gjF7K3AEAZwAAfTK2/v9OY8p3okjy6EoXh8XoQ1B1/i4zJycZUiXgkrLvKCJ96n98iiv89Cgvr1pRf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IQPVX2SubYUR+eqCXp4fqAqcDnvCl2itmTqYzKJbtajO+KX+Wx4BbO/3ocR+BsCf2Pwwxta27EAsxddVM/rTnQEGjXkNOk8rMtDxJ63TxfQRffWj8klbfiRjBbLscRCCjAzrP0f+YRjcG52YN4b/PrjGLX6yQo3Yk96ivcHF21Y=
Received: by 10.151.156.17 with SMTP id i17mr751776ybo.234.1211398792328;
        Wed, 21 May 2008 12:39:52 -0700 (PDT)
Received: by 10.150.144.5 with HTTP; Wed, 21 May 2008 12:39:52 -0700 (PDT)
In-Reply-To: <799406d60805211214r6315268ard77678eb2ec5d732@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82571>

On Wed, May 21, 2008 at 2:14 PM, Adam Mercer <ramercer@gmail.com> wrote:

> Fetching glue/ldbd.py   v 1.1
> Unknown: error
> [ram@mimir ~]$

Done some digging with cvsps itself and it looks like the lbdb.py,v
file has become corrupted from a very early version...

Is there a way that I can tell git to ignore the early revisions?

Cheers

Adam
