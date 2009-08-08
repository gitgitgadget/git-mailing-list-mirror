From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: Re: [PATCH 4/9] add missing long option to 'git grep' bash
 competion
Date: Sat, 8 Aug 2009 22:07:39 +0200
Message-ID: <20090808220739.663bb1f7@eleanor>
References: <9f50533b0908080156h23415740lb94cbd9f2c6a165d@mail.gmail.com>
	<7vskg2dr3o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 08 22:12:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZsHU-0007FL-A7
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 22:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbZHHUMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 16:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbZHHUMf
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 16:12:35 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:57369 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbZHHUMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 16:12:34 -0400
Received: by ewy7 with SMTP id 7so1910565ewy.18
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=tLkSJIXCybFv7wDbmlFZhDklTcFt8d/avV66HoaOuds=;
        b=uEe7T2pWEKMA8MAUDJ9fvVOpWiFJWdO7kzuRELBlmROq+yNB+MJIITH0wOicVdmzBz
         pd4kAQbHCGf7iOp6OybS9h6L0ionT3HYxExonLKExyBiJVTp5UFly8pvMadTQPUdV4nU
         rNkj3NJ8jFr8CiPj7WHOI5Y47C4JixbCoAtwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=gmxxeghD6Z4mRDeTEny9eBuEVC9nIYDeQTWi9CO4Su5XqUt+v+Sgo3/h/EfnbCWJby
         zz3/h/573t8kXUwlGAHhMmMEt958V5eGBMZuwALYa9ASWwJlN4xiFU4uDBgj/0o+DwuD
         gjpSRfG0q/zcBH1KdEZvC/OwXfGpGmHLO7znA=
Received: by 10.210.35.16 with SMTP id i16mr3148892ebi.35.1249762354484;
        Sat, 08 Aug 2009 13:12:34 -0700 (PDT)
Received: from eleanor (cxr69-1-87-88-216-137.dsl.club-internet.fr [87.88.216.137])
        by mx.google.com with ESMTPS id 7sm6649645eyb.20.2009.08.08.13.12.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 13:12:34 -0700 (PDT)
In-Reply-To: <7vskg2dr3o.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125304>

> > according to the 'git-grep' man page, the following long options are
> > missing from the 'git grep' bash completion :
> > --null
> > --color
> > --no-color
> 
> I do not think completion's purpose should be to offer everything
> available under the sun, so "according to manpage these are missing" can
> never be a good justification for patches in this series.
When I saw that completion for the long options of 'git checkout' was
mising, I just start looking around the docs to see if there wasn't other
git commands with some missing completions. I see now it was a wrong way
to update the git bash completion. I will soon come back with a new set
of (more reasonnable) patches.

Emmanuel 
