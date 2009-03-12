From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: setting up tracking on push
Date: Wed, 11 Mar 2009 21:16:11 -0400
Message-ID: <76718490903111816s3da97379x74e4ced2eae96ab2@mail.gmail.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
	 <gp9jp7$uc3$1@ger.gmane.org>
	 <76718490903111758l4e4bd29et379e975deb8e99bd@mail.gmail.com>
	 <7vprgnlf3f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "John M. Dlugosz" <ngnr63q02@sneakemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 02:17:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhZYN-0004pD-3T
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 02:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbZCLBQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 21:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbZCLBQP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 21:16:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:47840 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbZCLBQO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 21:16:14 -0400
Received: by rv-out-0506.google.com with SMTP id g37so273066rvb.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 18:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a2QYmw2o741BXr4cuYZm2Ed5VTG7WtUk56e1odUSmvQ=;
        b=OAN+hvBYF0AAMRrO3h/0HT6zDSAY/H9DAnhWhK7U+Kp/xnNFw0qzv8ctBa/JqEpGOR
         lfmbYtseowAJQqdv8bjSXFSyUa5VtKFuFJ30BU43kQGKyxxYoLM5jRyZsQxzGMTic22C
         cTYdP4hWdwE8GjjpLsWpSe/Gz8GO7f7XCLUWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BOZ3Ek/L5MlJb5MfD6T9JKdN4uOajNTHHuQKKOoCeTcXhLQA+zPGfW3XIGid8Z6JqT
         trr8/Tb9U20WzpWdfuQk2UUmqKMyDKfIwJIi5AfgNcx8UHGKW6Ekd08jtWGsfg/tLkd/
         BBnE7PKSL2EEqUq83X1Uu3Jrr2zX7GC3PJ+C4=
Received: by 10.141.211.5 with SMTP id n5mr4678872rvq.279.1236820571965; Wed, 
	11 Mar 2009 18:16:11 -0700 (PDT)
In-Reply-To: <7vprgnlf3f.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112996>

On Wed, Mar 11, 2009 at 9:11 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> http://article.gmane.org/gmane.comp.version-control.git/54822/
>
> I do not think the description of remote-tracking in that article is
> correct. =C2=A0We use the word to call remote/origin/<name> that keep=
s copies
> of what we saw over there when we last observed.
>
> The way to mark local branches to merge with/rebase onto something el=
se
> by default is --track option to "git branch" and "git checkout -b", a=
nd
> that is often used to mark them to --track remote-tracking branches b=
ut
> they do not have to --track remote-tracking branches. =C2=A0They can =
--track
> local branches as well.

Yes, I noticed this as I re-read the thread. --track and --no-track
are unfortunately poorly named, but that's ancient history. I've
summarized the thread just before you sent this message. I'll update
my summary to note this point. :-)

j.
