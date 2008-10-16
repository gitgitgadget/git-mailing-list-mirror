From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: Re: commiting while the current version is in conflict
Date: Fri, 17 Oct 2008 01:07:27 +0200
Message-ID: <2d460de70810161607n470e9479h8f7885040cbf5428@mail.gmail.com>
References: <2d460de70810161510ha220593g4615a55b2c3e3b25@mail.gmail.com>
	 <20081016224808.GO536@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Oct 17 01:08:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqbxU-0002jU-N1
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 01:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758737AbYJPXHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 19:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758732AbYJPXHa
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 19:07:30 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:48233 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758724AbYJPXH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 19:07:28 -0400
Received: by yx-out-2324.google.com with SMTP id 8so66602yxm.1
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 16:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=m5l/5dCbZ27tkt4eTs9ksS7LvURRKdiCoL0rBhxjQx0=;
        b=en4PpXuR+pWmUZrL1zNy3SZ9EYOxOyiWqUrIc3XFkroxP3SdWqwZuJaKJ9PE+C9bKS
         8BF4/Ofh15t6YAePQMPr5Y0kFk0liEpgDCMf3OwE4tktTL5xqWvcBPj7krpfSoggVVtB
         Lm+YKrzWittBzty6aFscwC+YhF3/RGUbq2iHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=A/HtvMpyCI3EJzFu2AGUIeBuXAmLhhRWrLNcW35wXxxT2EarO53AXHgh3e3yjxnfFF
         tqa4SbAzoU1PxxhYnvNqWrzjEHbcImDBJJtAzaRPER1QebEDDCdnUKgFmoOHJRQ2TO68
         UsADc0ePwr0EWAfSSxJW+pUeF+LaN3cR8j/pE=
Received: by 10.100.127.15 with SMTP id z15mr4552620anc.10.1224198447406;
        Thu, 16 Oct 2008 16:07:27 -0700 (PDT)
Received: by 10.100.43.19 with HTTP; Thu, 16 Oct 2008 16:07:27 -0700 (PDT)
In-Reply-To: <20081016224808.GO536@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98433>

On Fri, Oct 17, 2008 at 00:48, Miklos Vajna <vmiklos@frugalware.org> wrote:

> Not sure, but in general blocking conflict markers by default would be a
> bad idea IMHO, several markup language (asciidoc, for example) makes use
> of the >>>, === and such character sequences.

Doesn't git keep metadata about conflicts, as well?


Richard
