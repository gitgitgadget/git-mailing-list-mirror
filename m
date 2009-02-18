From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] test suite: correct export var=val usage
Date: Tue, 17 Feb 2009 19:37:38 -0500
Message-ID: <76718490902171637j55f97a7fg2a0ead846b88d3e6@mail.gmail.com>
References: <7vr61w3dug.fsf@gitster.siamese.dyndns.org>
	 <1234911188-36941-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.DEB.1.00.0902180046290.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 01:39:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZaSy-000412-W0
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 01:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbZBRAhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 19:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbZBRAhk
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 19:37:40 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:63539 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZBRAhj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 19:37:39 -0500
Received: by rv-out-0506.google.com with SMTP id g9so1765924rvb.5
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 16:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e4vAV4UeUBNYqrVB3PS8itqAPsX/pHt1wy2zXYCnJW4=;
        b=xLfZaLGm5whq7D/mBOS4hk85sKqdnJ5wqF7tssJYdueWNpUOn7qHajFcQRsXV/EqBy
         +Ifgp9nuegWXR/Gtql1P6uc2K9BXvFsr3VVAAQun3doOu9A2S6zmLGHU71eePyGO2oM6
         7DeP8CsbPyOPiXo9o73G33mXpG/7eCZBqEHUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BHaQukIwtzI7ANINjoAlkwIUhbi211unbrkqbDsia4TnUtgdW97GfWATQ71K4Qd2BU
         JNjx6QutlHJtaZUneMnT/gd4jqe7X7wDZA9JgjvAJtP7AuNJsJ1ZdhGV6JI2gUGJFqYU
         LsGQLYHEEB7pvKAcZ7eD4l3x+IQLdNDp3HRKA=
Received: by 10.141.116.17 with SMTP id t17mr3563243rvm.239.1234917458716; 
	Tue, 17 Feb 2009 16:37:38 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902180046290.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110487>

On Tue, Feb 17, 2009 at 6:47 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 17 Feb 2009, Jay Soffian wrote:
>
>> +     (MSG=1 GIT_NOTES_REF=refs/heads/bogus
>> +      && export MSG GIT_NOTES_REF &&
>
> Hmm.  Why does the "&&" at the start of a line strike me as odd.  Ah, yes,
> it is because no code around it uses that style.
>
> *grins*

Sometimes authors catch their own mistakes, but you have to slow down
on the reply button to notice. It's not like I didn't mail out the
correction less than a minute afterwards.

*double-grins*

And in case your curious how that happened, it was because I had a
single line, realized it was too long, and hit return in the wrong
place. Unfortunately I didn't catch my mistake till after I mailed it
out.

So there. (sticking tongue out at Dscho)

j.
