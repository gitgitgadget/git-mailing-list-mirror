From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: clone from url with email address as username?(escaping @ symbol)
Date: Tue, 29 Sep 2009 16:32:58 +0200
Message-ID: <fabb9a1e0909290732h5119170ew133d906b67e49f99@mail.gmail.com>
References: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com> 
	<fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com> 
	<vpq1vlp962h.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ben Bennett <benbennett@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 29 16:33:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msdld-0003wV-Jw
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 16:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbZI2OdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 10:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbZI2OdQ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 10:33:16 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:40747 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbZI2OdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 10:33:16 -0400
Received: by ewy7 with SMTP id 7so5468266ewy.17
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=L5ufUj+kyWpW2zom5CS2AkWmUhzg/zLHAj+IqZd53/o=;
        b=s9ohJby/plU2JXM8dQpzfs/1r37GMlj9N06qz54Mb9sfnm7xZRQZQnO6voV8dZQ/aW
         oytFkNMdClgZlHFsvSr2l7Srw8jXFxOa/j6OzO28W9Nr8Tx36bk56jdKjgRRBlTg7MKT
         NUsf1DsJ6bn/jTefAlkVHpXvM1xK7wjOEGzfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mIaoV2Xlgo5v9VexycS16uu25PZ4ox8UMVsbFbOPKANp0+HPviqjOKPRUjFuu696Yu
         c4n/BXefoDWdt8lvx6d03ZrIiwI0AOp2vgLwgAsa+gf0rggurrxzm5/6wLSVztaREw7q
         L2xacBaFRYKFVXzpdcvkYGMMETacHNqqtmIqA=
Received: by 10.216.53.14 with SMTP id f14mr992251wec.196.1254234798571; Tue, 
	29 Sep 2009 07:33:18 -0700 (PDT)
In-Reply-To: <vpq1vlp962h.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129307>

Heya,

On Tue, Sep 29, 2009 at 16:30, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> The question is which @ is the login/server separator, and which one
> is included in the login. A quick test with

I think it only makes sense that this would work, since any @ can
never be part of the server name (since it's not an allowed
character), so I'm still curious why Ben wants to escape his @.

-- 
Cheers,

Sverre Rabbelier
