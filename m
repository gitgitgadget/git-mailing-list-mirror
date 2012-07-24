From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn SVN 1.7 fix, take 2
Date: Tue, 24 Jul 2012 18:12:25 -0500
Message-ID: <20120724231225.GB16333@burratino>
References: <500F17A3.60307@pobox.com>
 <7vipdcesk6.fsf@alter.siamese.dyndns.org>
 <500F2A73.4000502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 01:12:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StoHQ-0000Uz-Lt
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 01:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239Ab2GXXMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 19:12:35 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:38707 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047Ab2GXXMe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 19:12:34 -0400
Received: by ghrr11 with SMTP id r11so129734ghr.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 16:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=onQUVtPBQiqpmV82ylgMw98gSb9OZfEUxYWh+lOEkac=;
        b=wvgiJk3jC348I3jKO4khpINbqCm43XABcHeqwfolEl2/EEd4AZYQtRf05puNW3mX4f
         9oI73LGmGu2OGW19dNGYeg4fB3LmxVETJg42jdKYWLcmpOW/uG7x+ylo/4jte2zA+u3S
         452zfDqF/KUHkmB+w2eEgJSoWRYQVv74wH20yUbAYFbE52bEfh+B8cHbye3odRKlgUCT
         XLm+MTwqSn55d6ervm6G7GqpWWJ2dfVWbJCCEFMOn1+onfiUAJvo6/aHdV6EXyuBFD0J
         SL805h4i8GHeqcNVDmLy6EhOUoCUtDVd3vLkpXreTswzytAlWZXWoLSgVqRkwQaX/7jZ
         Wehg==
Received: by 10.42.189.73 with SMTP id dd9mr19240538icb.49.1343171553252;
        Tue, 24 Jul 2012 16:12:33 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id pb3sm6338808igc.17.2012.07.24.16.12.29
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 16:12:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <500F2A73.4000502@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202085>

Michael G Schwern wrote:

> While I use git heavily I'm not invested in working on it.  I work on a lot of
> projects.  I'd like to be able to do the work, submit it, work through review,
> and get out without joining another mailing list and studying their culture.

An alternative approach would be to _just_ explain how your patch
series works, and then say

	"Ok, here is the git branch.  Have fun with it.  If someone wants to
	incorporate it, that's great.  Let me know if you have any questions."

That's totally fine.  Then someone else can submit the patches and
help to massage the patches into a form that is ready for application
on your behalf.

> Is there a document I could look at for submitting a large body of work, or
> could I help improve SubmittingPatches to document the process better?

I thought SubmittingPatches did describe how to send patch series.
Could you point to the section that was lacking?  Or are you just
still in disbelief that people review each patch in a thread, one by
one, sending emails to each other?

Grateful but impatient,
Jonathan
