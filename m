From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 18/19] transport-helper: Use capname for gitdir
 capability too
Date: Wed, 8 Jun 2011 15:54:23 -0500
Message-ID: <20110608205423.GL27715@elie>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-19-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 22:54:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUPlz-0008Tu-Ev
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 22:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598Ab1FHUy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 16:54:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57522 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386Ab1FHUy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 16:54:28 -0400
Received: by iwn34 with SMTP id 34so753507iwn.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 13:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=K0wP1z7BFgCdeRA1+bPja7X9gVAs7yUlWPw3OfpZoKI=;
        b=qtX9Dk+8HyDB393AkcwSiRK1T7GgGhKO4ofQT+o83sa5QixN3OQii8DqUW7F+PO7F6
         pn+Bi+kVqzPJ20+/x9QCRcFS0F4r8l0gRj7xZgo/OMbiBX9xOTDDKvnCj1JYqK0UDJyx
         lpf0dftDG5GKhyGsvJnyYjhMGa/yezsfH6dmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AWrGivlQa7Sd+8e/7qIB9EHC/Zi7YSJWVckWg3z68jCTzA2U9hb4HUCXfYaHaBZS48
         Z/Seldr5R/dg6/2V21r+ZhtiiwX1NspndJSQ3FT7jdHgBAdQn8HgZpru5TAnKMq6/TRb
         RMPbY01oi8rwJJ+vIhpCgVQbHucw8jJE8EqV0=
Received: by 10.42.135.65 with SMTP id o1mr13133602ict.207.1307566467747;
        Wed, 08 Jun 2011 13:54:27 -0700 (PDT)
Received: from elie (adsl-69-209-61-87.dsl.chcgil.sbcglobal.net [69.209.61.87])
        by mx.google.com with ESMTPS id w11sm436604ibw.7.2011.06.08.13.54.26
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 13:54:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307558930-16074-19-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175458>

Sverre Rabbelier wrote:

> Also properly use capname in the refspec capability.
>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>

Thanks.  The old commit message said

	Previously the gitdir and refspec capabilities could not be listed as
	required or their parsing would break.

which seemed like a somewhat helpful thing to mention. :)  I suspect
the after-the-cut comment

	I suspect the reason the second hunk wasn't caught is because the
	series that added 'gitdir' as capability, and the one that added
	required capabilities were done in parallel.

would be helpful for future readers, too.
