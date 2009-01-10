From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Main branch being maintained with 'git am', how do mere mortals interact without too much conflicts?
Date: Sat, 10 Jan 2009 09:47:17 -0500
Message-ID: <eaa105840901100647y70b53ae0w495af69b7281cae7@mail.gmail.com>
References: <87vdsntnyd.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junichi Uekawa" <dancer@netfort.gr.jp>
X-From: git-owner@vger.kernel.org Sat Jan 10 15:48:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLf8m-0005uK-87
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 15:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbZAJOrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 09:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753383AbZAJOrT
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 09:47:19 -0500
Received: from rn-out-0910.google.com ([64.233.170.188]:17100 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbZAJOrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 09:47:19 -0500
Received: by rn-out-0910.google.com with SMTP id k40so6732242rnd.17
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 06:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=zMIcQ4jW/DpM9YWoupoxF6sEXl5M0XQE337cZLQHlwo=;
        b=BZf6ZyaufSfdH8L/+PsNX0mmbwQBrJ7sIU7Qw3XbLFaBhU5HHt/WLVYnIXZ6THL4lc
         2+vG/V2Z+L6gFz/vnT/BeBvSyfSEwJUwGsTo2Ge1sBnmy1AU0Fkpgp4vv3Dw72j4/ZAu
         60Ev3aRbAZ0bD27ev4gTg7QCmVtn8jnB8Vplg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=C2d4LEO/BN4K5CmresHmai7XQFleUXvI9F/RMAJhgsrb7ZMAH5Cf4jm13ODgNgYEPB
         krk242wxE56TkLKlHYH1i8n46ZOufH4BZc/4WrSeaVAMeCs6FIvANk6JXhjFeyxG6KLL
         x/yMO3hkNYTvkM+PwM7PHQ1GgaroAaffx+Bsk=
Received: by 10.65.105.18 with SMTP id h18mr3281472qbm.112.1231598837436;
        Sat, 10 Jan 2009 06:47:17 -0800 (PST)
Received: by 10.64.210.7 with HTTP; Sat, 10 Jan 2009 06:47:17 -0800 (PST)
In-Reply-To: <87vdsntnyd.dancerj%dancer@netfort.gr.jp>
Content-Disposition: inline
X-Google-Sender-Auth: 98428ff80a5ca279
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105117>

On Sat, Jan 10, 2009 at 6:11 AM, Junichi Uekawa wrote:
> I am thinking of recommending the users to create a branch
...
> and throw away their branches when they are included upstream.

Yes, with a patch based workflow, this is almost required; all of the
commits will at least have different committer information.

There's nothing wrong with this approach.

> Something tells me the problem is that I'm probably using a workflow
> that resembles SVN too much, and users aren't used to branches yet.
> Has anybody found this to be a problem, or better yet, is there a
> better workflow?

If you need the commits to be identical, and you don't mind your email
consisting of a binary blob attachment, you can ask your contributors
to send you a bundle instead of a series of patches. "git help bundle"
for details.

Peter Harris
