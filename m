From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH 2/3] push: add --current
Date: Mon, 20 Jul 2009 13:17:36 +0200
Message-ID: <9b18b3110907200417t2e916d9bqffdb168329d88bc4@mail.gmail.com>
References: <1248071820-18289-1-git-send-email-bonzini@gnu.org>
	 <1248071820-18289-3-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 13:17:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSqsM-0007IN-0V
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 13:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbZGTLRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 07:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbZGTLRh
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 07:17:37 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:43746 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbZGTLRh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 07:17:37 -0400
Received: by yxe14 with SMTP id 14so3499589yxe.33
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0u6rNxgPfZ6TwYGU/0smi8rhT+cKu1sQx5hUnvm15fE=;
        b=vkiNOjWx/itCwK9uG/Lk98BtvFtDbH8no+nEdxlgr6cDoccomJLANkHYDKREsRiHQ5
         k2Z0HBl/VDxG5wPFYDY1HkBbsi3tnDCDrFjPlaOpPyz0cmLucyWi2NJ3BFlmhZ5+wuAN
         TlzBNr2uxB3zDDTY3aU0Dgr6jT8AJzAhyVTok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tz1ab7ldHZC8elk7aN7UT5iqcmPVSJdLty3gxXvizjIJYm6BMjZIV/O9B9DtgQg5wp
         804WF6BXkwB1g67xRXfjxaopvq41ylYaPXjSl+BPDsGIv5/ntqPMNSq59PEzuvR4kIds
         r3YvnvvkCu18Qx2JByWFSxQS7Oh+WC6oL34VY=
Received: by 10.231.32.138 with SMTP id c10mr205691ibd.28.1248088656205; Mon, 
	20 Jul 2009 04:17:36 -0700 (PDT)
In-Reply-To: <1248071820-18289-3-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123586>

2009/7/20 Paolo Bonzini <bonzini@gnu.org>:
[snip]
> A secondary effect of --head is that, if there is no push.default
> specified, I make the default push refspec "HEAD".

I think you mean something like:

  A secondary effect of --current is that if there is no push.default
  configuration setting specified the default push refspec will be "HEAD".

The important point being you talk about --current but then mention
--head which I am guessing was a previous name for this option.

BTW, I like this option and I can imagine it will be a popular alias.
One of the more common questions I get asked from people about git is
what to do about all the "error" messages when pushing. I usually
explain that unless the error message concerns the current branch
which you wanted to push that they can be ignored. I look forward to
pointing out this option instead. Thanks. :-)

Cheers,
yves
-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
