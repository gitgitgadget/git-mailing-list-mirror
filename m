From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH 1/2] Add test script for git-stripspace.
Date: Wed, 27 Jun 2007 07:54:46 +0200
Message-ID: <1b46aba20706262254t356fab01x5282cdd5942c4b79@mail.gmail.com>
References: <46801665.4050708@gmail.com>
	 <7v8xa6ruu4.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, krh@redhat.com
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 07:54:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3QUM-00068n-FF
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 07:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255AbXF0Fys (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 01:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755547AbXF0Fys
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 01:54:48 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:10502 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462AbXF0Fyr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 01:54:47 -0400
Received: by wa-out-1112.google.com with SMTP id v27so81974wah
        for <git@vger.kernel.org>; Tue, 26 Jun 2007 22:54:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gwgQu+YckpnILsqC8raT3cbLswYQj83jwnT9t8Ero557/Jru0wXmBllaj+GCrZPCdPGyFpdricZCL1azLZ8VthVW6dd5qZqcwtNotgrsjsfqPYP/abOXf6k/c38o+wShq3y2KLtu8pQGeJZHLJvG2s9sTqw8IciNKdvZgaYn0Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XUGpSFZ5Hp5FVcj0SfdvgL/sMEbJoRwsuqNMEs05nat6lZ/1PwvrK0YzM/igN/4XJy16cqwJZDm0PkB3kTRpq4pe40TFrteyweN2GzEsZpr+LSUT50WpPbHa87HX1aRWpq9nDxo8pfv6JwDx6LNHjst3hQqVTJz/NwLKw4wf4y8=
Received: by 10.114.26.1 with SMTP id 1mr156979waz.1182923686795;
        Tue, 26 Jun 2007 22:54:46 -0700 (PDT)
Received: by 10.114.61.17 with HTTP; Tue, 26 Jun 2007 22:54:46 -0700 (PDT)
In-Reply-To: <7v8xa6ruu4.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51018>

2007/6/27, Junio C Hamano <gitster@pobox.com>:
> Thanks.  That's extensive set of tests for a little utility.

I hope not being overtesting the program. In order to reuse the
function that does this job from the builtins, perhaps we need another
implementation doing the same in a memory buffer instead a file
stream. The tests save the need to feed manually the program in this
development, and clarify the expected behaviour for the utility.

> > new file mode 100644
> 100755?

> > +    cat expect | git-stripspace >actual &&
> Please don't cat a single file into a pipeline.
>         git-stripspace <actual >expect

Thank you for your corrections. I Will resend it with those fixed.
