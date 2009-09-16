From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: System wide gitattributes
Date: Wed, 16 Sep 2009 17:46:04 +0530
Message-ID: <f46c52560909160516w1d888a23yedd1fafae515bfbe@mail.gmail.com>
References: <4AB0D0EB.5080105@andrena.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?David_F=F6rster?= <david.foerster@andrena.de>
X-From: git-owner@vger.kernel.org Wed Sep 16 14:16:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MntQl-0003hV-J3
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 14:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758769AbZIPMQD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Sep 2009 08:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbZIPMQC
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 08:16:02 -0400
Received: from mail-px0-f176.google.com ([209.85.216.176]:44286 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758769AbZIPMQB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2009 08:16:01 -0400
Received: by pxi6 with SMTP id 6so3951715pxi.21
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 05:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SGzozMus9WPEMAdSh+ljCKpZvrC1DbgYQPU4HL6EzJE=;
        b=wogBTQ9WUCgBHFRah3ty+sbI7gIxG3jQik4mPFSPQMVu7x6jSQfAguH0mpbSlMWu9u
         iclLDmxBmLjGpqX9ZZ+0TfUmS8xkQzge01tAjJVDWZCqCSV0JUkvJYGe/ssXL15vVcGU
         P1phikC0ctOAhtjE0rmahzzH/O7vUg+Mg8DUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=urlyYieau9ZURaO5/CzaAjemy3s/tiak8lz9wWYCvdAq43KKF9mb4mBNVg3RHfGcjg
         P/Re02nqQH9yJ+VtFfFSaTZlt4RqWaLAKP/j/T1lf0PCrfSaPm/treXS7zfzhD9bwu/3
         xo6NGnuEhZBU4K+gBSVWY+pddCFuFPAYFbRpc=
Received: by 10.115.134.17 with SMTP id l17mr15969245wan.44.1253103364456; 
	Wed, 16 Sep 2009 05:16:04 -0700 (PDT)
In-Reply-To: <4AB0D0EB.5080105@andrena.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128648>

2009/9/16 David F=F6rster <david.foerster@andrena.de>:
> Hi there,
>
> from the documentation I understand that things like external diff to=
ols can
> be set up in a gitattributes file per repository (or subfolder).
>
> Why is there no support for a ~/.gitattributes file? This would be ve=
ry
> handy, for example to always get a textual diff of OpenDocument files=
=2E
>

They are there; see

http://www.kernel.org/pub/software/scm/git/docs/git-config.html#FILES
