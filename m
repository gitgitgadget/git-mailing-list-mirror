From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 18/19] Refactor git_remote_cvs to a more generic 
	git_remote_helpers
Date: Fri, 30 Oct 2009 05:29:03 -0700
Message-ID: <fabb9a1e0910300529k6b4ea08bu4af144080d6bf704@mail.gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> 
	<1256839287-19016-19-git-send-email-srabbelier@gmail.com> 
	<200910300942.54101.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 13:29:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3qbh-0008TL-8q
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 13:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275AbZJ3M3T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 08:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755140AbZJ3M3T
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 08:29:19 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:25124 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbZJ3M3T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 08:29:19 -0400
Received: by ey-out-2122.google.com with SMTP id d26so4112eyd.19
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 05:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Y1M82xljbUvOvqihUnJ5mgmcIphxZJC+Su1Fe28nB74=;
        b=mkTzD7RcVBixnfvJ/HXu4uQ5rlVygZZsAtnZ5d4NX+oNqlXya5gVV6FjYUR4Qd0BJM
         6buRsxK7kOlFOCUvculkFx57keuZiI6wbp+qJ8fGTYHPJtvpIPYEyxy2u2y4ukECCDii
         NYr9NM+Ur11Hj8zFQcze7Mg/GOcMJtj0RCKnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BN7bC7DqwTKRYmgbNc/72OJtXnS6nNpZk/ew4JhjuxpU2rDD9J2f+5zsqqDeHXVR/1
         k8hETWPP+y9zZc9s64gTPurwMCATHBDewSCiCBCh5GaRTFPXbPIfPMs51hCYQZ5IjTYe
         of1H8LqdWVxeuLDOLKUx2RimBkL960ieF1/Ac=
Received: by 10.216.87.81 with SMTP id x59mr516439wee.147.1256905763113; Fri, 
	30 Oct 2009 05:29:23 -0700 (PDT)
In-Reply-To: <200910300942.54101.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131701>

Heya,

On Fri, Oct 30, 2009 at 01:42, Johan Herland <johan@herland.net> wrote:
>> +- git/git - Interaction with Git repositories
>
> Since this is Python documentation within a package, I'd rather refer=
 to the
> python modules as _modules_ and not files. I.e. please use '.' instea=
d of
> '/':

Ok, will do.

>> +- util - General utility functionality use by the other modules in
>> + =A0 =A0 =A0 =A0 this package, and also used directly by git-remote=
-cvs.
>
> Probably you should drop the direct reference to git-remote-cvs.

Ah, yes, my bad.

>> + =A0 =A0 test -d ../git_remote_helpers/build || {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 error "You haven't built git_remote_cvs =
yet, have you?"
>
> Please also s/git_remote_cvs/git_remote_helpers/ in the error message=
=2E

That's weird, I thought I did that, ah well, will fix.

> Otherwise, it all looks good :)

Thanks for the review.

--=20
Cheers,

Sverre Rabbelier
