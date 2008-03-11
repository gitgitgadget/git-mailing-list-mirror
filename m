From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 01/10] "git read-tree -m" and the like require worktree
Date: Tue, 11 Mar 2008 22:41:23 +0700
Message-ID: <fcaeb9bf0803110841h54899919kba1bfa15ccc06843@mail.gmail.com>
References: <cover.1204453703.git.pclouds@gmail.com>
	 <20080302103316.GA8902@laptop>
	 <alpine.LSU.1.00.0803111400430.3873@racer.site>
	 <fcaeb9bf0803110757i5f31c6b9w3b0e65af401e3ca0@mail.gmail.com>
	 <alpine.LSU.1.00.0803111605530.3873@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 16:42:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ6c8-0006vG-H1
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 16:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbYCKPl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 11:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbYCKPl0
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 11:41:26 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:63213 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbYCKPlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 11:41:25 -0400
Received: by fk-out-0910.google.com with SMTP id z23so2311285fkz.5
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6WKkN0RKzurHz37xx/6x+AyqEZcFDPahlXqVT8FIUes=;
        b=mTpiMElHeXOZdF4yaOEgSNOUrepFGNdIhzni1oDg8w0x2onC8ZjltEF760sZt/gNr9jJrx9W1cpVTS/6whgU4AVKcE2oqHXGD8h5BLnaZyrTIjndD30XGKyMXqjFEU3vOnmG79X74AmhUDITiyE1WtxZCrmYuEZJEt3jQlZdAho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GtsAiNdqaFHuaUx79jkqn1J8diWVU4BvpozuwEyXWgBnxbtpvTXLSjc80BGpZhlOx3H9dMSGP1tcZhazoVBU66r/2VaLB99frw34sN5RVb9celuLkAog35cpIMAoark68Q7sBkvJeJBfmfiA4tN/8bcB90Hcuor2Ns1Z7H7wA+I=
Received: by 10.82.115.8 with SMTP id n8mr16756276buc.10.1205250083796;
        Tue, 11 Mar 2008 08:41:23 -0700 (PDT)
Received: by 10.86.81.4 with HTTP; Tue, 11 Mar 2008 08:41:23 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803111605530.3873@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76870>

On Tue, Mar 11, 2008 at 10:06 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Tue, 11 Mar 2008, Nguyen Thai Ngoc Duy wrote:
>
>  > On Tue, Mar 11, 2008 at 8:02 PM, Johannes Schindelin
>  > <Johannes.Schindelin@gmx.de> wrote:
>  >
>
> > >  How about
>  > >
>  > >         git read-tree -m without -i requires work tree
>  > >
>  > >  Hmm?
>  >
>  > I thought that was the patch was about. Did I write the patch so bad? :(
>
>  I meant as a replacement for your commit subject (which I found pretty
>  hard to understand, harder than the patch itself).

Yes it is absolutely a better subject. Thanks.
-- 
Duy
