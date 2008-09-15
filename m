From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Documentation: warn against merging in a dirty tree
Date: Mon, 15 Sep 2008 19:53:07 -0400
Message-ID: <32541b130809151653w27d7876fp35e0967d597ae2a9@mail.gmail.com>
References: <200809160048.31443.trast@student.ethz.ch>
	 <1221518994-26111-1-git-send-email-trast@student.ethz.ch>
	 <1221518994-26111-2-git-send-email-trast@student.ethz.ch>
	 <7vtzch7z7u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Thomas Rast" <trast@student.ethz.ch>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 01:54:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfNtf-0006hP-1F
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 01:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbYIOXxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 19:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753649AbYIOXxK
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 19:53:10 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:2414 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbYIOXxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 19:53:09 -0400
Received: by yw-out-2324.google.com with SMTP id 9so732716ywe.1
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 16:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ZTWEv9MF05U8MRyMZKSMc0Mvi5z2Q0c84CV9FGxm54g=;
        b=faDLUZK6PzX1jL7k0vKsI2c3du1iw/cD36c5Dz1MBX1x+1J0R2N7FTlDU3Fxb59icX
         J+NHXFsxu5saKq1++M+oCvFEpt3FexTFAi5IUjY0MoLwksPklkqrxoH4siiPMnqxWK9C
         ga7VbzCaXK9niCQUdwCZ+WaYzwOHjvo4nw9OQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lny1HpOetR9xmW1rqoc905UaJKsDymj31KzMPQSQkecfBU9ciGI3KlofTIIuRgjcCO
         IHFkD7DycRen/BR7+EeQy4CkJ9VzDHHfTa4rHlc4Kebn92RuwysAUr5S7+uhsKdN+uXf
         ymsCTlqTswXyJmHHTvDFq/nndKkPPxcudGLiw=
Received: by 10.150.145.20 with SMTP id s20mr352020ybd.197.1221522787627;
        Mon, 15 Sep 2008 16:53:07 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Mon, 15 Sep 2008 16:53:07 -0700 (PDT)
In-Reply-To: <7vtzch7z7u.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95960>

On Mon, Sep 15, 2008 at 7:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Merging in a dirty tree is usually a bad idea because you need to
>> reset --hard to abort; but the docs didn't say anything about it.
>
> Strictly speaking, you do not have to worry about anything if (1) all of
> your work tree changes are easily reproducible (Linus's keeping a new
> EXTRAVERSION in his Makefile, never staged nor committed is an often cited
> example), or (2) you know beforehand that a merge with the other party
> will not touch the part you have local changes that you care about.
>
> In other words, you need to know what you are doing, and a warning with
> "usually it is a bad idea" would be an appropriate thing to do.

But how do you abort a *failed* merge in a situation like Linus's
example?  "git reset --hard HEAD" would destroy the unstaged Makefile
change.

I would love to know the answer to this for my own work, and I guess
it would be relevant to the documentation too.

Have fun,

Avery
