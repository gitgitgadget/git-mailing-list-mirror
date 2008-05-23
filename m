From: "Adam Mercer" <ramercer@gmail.com>
Subject: Re: git cvsimport error
Date: Fri, 23 May 2008 15:01:24 -0500
Message-ID: <799406d60805231301l18c288ebt86a028e1ef795d9d@mail.gmail.com>
References: <799406d60805211214r6315268ard77678eb2ec5d732@mail.gmail.com>
	 <799406d60805211239n42c39ea6iaa41a9ab379cafaa@mail.gmail.com>
	 <63BEA5E623E09F4D92233FB12A9F794301FC8B2D@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:02:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzdSy-0002JH-4O
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103AbYEWUBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753922AbYEWUBZ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:01:25 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:9442 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbYEWUBY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:01:24 -0400
Received: by rv-out-0506.google.com with SMTP id l9so993369rvb.1
        for <git@vger.kernel.org>; Fri, 23 May 2008 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nz0yau/38csJhCE7axc1r51cAUo6w7nY0j9exlTyes0=;
        b=RF6hPSQbbQvvhQwtX3LR7vIP7M2Ces2CjB1vTCI975Jm4BXHFLCsHdQNHZ+6q/B53vFkFZmcNGI1ToOfPwmbZctISlpVfADukrXmXSX28HpZXCDrxzY35QC/HnYISgPIbXx3J3XA40GSQdiUtvjLG5J5OS27r3R1qa8qDwo8QMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UIF2La9NvuncL72YFSnmS5qtQzEl+yGdZ3QztKyZbd0Mcr0V7qND+M0UwOadddIePAYyVXRNsgjEvtDNf1phPMyAnqyLUrQdThzb81EG01qCsowVfl/7RqO8v5XRJnjythWjiviyOh/Ming+Jj0D45SNCbOMLvPLY3UIKrCL+vM=
Received: by 10.141.171.6 with SMTP id y6mr838608rvo.143.1211572884062;
        Fri, 23 May 2008 13:01:24 -0700 (PDT)
Received: by 10.141.203.9 with HTTP; Fri, 23 May 2008 13:01:24 -0700 (PDT)
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794301FC8B2D@emailmn.mqsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82729>

On Wed, May 21, 2008 at 2:51 PM, Craig L. Ching <cching@mqsoftware.com> wrote:

> Not a cvsps expert, but I'm at the same point as you in converting a
> repo ;-)  Would the -d option on cvsps do what you want?

It should but I can't get it too work, the ldbd.py,v file is OK from
2003/05/06 07:39:52, so after consulting the man pages for both
git-cvsimport and cvsps I ran the following

$ git cvsimport -v  -p "-d" -p "2003/05/06 07:40:00"
-d:local:/Users/ram/test_cvs -C glue.git glue

yet git/cvsps still tries to retrieve the bad revisions, prior to the
above date. I'm clearly missing something?

Cheers

Adam
