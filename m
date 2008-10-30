From: "Stefan Karpinski" <stefan.karpinski@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Thu, 30 Oct 2008 03:55:28 -0700
Message-ID: <d4bc1a2a0810300355q42b35a35p2ba0e778691a0ab6@mail.gmail.com>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 11:57:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvVDD-0006B1-NU
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 11:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071AbYJ3Kze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 06:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755047AbYJ3Kzd
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 06:55:33 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:20349 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965AbYJ3Kza (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 06:55:30 -0400
Received: by an-out-0708.google.com with SMTP id d40so53675and.103
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 03:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QmLz/NGKPalc/WZHCTVCBaeyQfY42qOM7Xbo6mIiyGU=;
        b=eMfRpKDGSwNE26BSz8m2q7F7xZh8SlF0izfShTOAWevpIhOSrK5WPKg0KJ+RCu2ehN
         ONG3oovawCaiezc6sPDN/JOszq2YgKCI7DBFDy76z851VGxFZQR5zp4hteRTj6ldwfHv
         xzogQiAQbgrc91HAMJAfS81NV0pgp9PXTHvE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=h11Qeh3zN7sEzObMNABssv4d6hYlAVC0XLNyopowgJqX2suadU9wIFruwCy8XwXbu8
         5cYlbKM8+liSyyUQsaEWSWool6iArQC1bbKGzbwB3zxQCTNYXm4vxYFvZhqGIKJ4wvyO
         iY0Jx8CFffhta2MypAMb8CaTMfH+xPS2RfE1Y=
Received: by 10.100.13.2 with SMTP id 2mr461553anm.74.1225364129018;
        Thu, 30 Oct 2008 03:55:29 -0700 (PDT)
Received: by 10.100.231.7 with HTTP; Thu, 30 Oct 2008 03:55:28 -0700 (PDT)
In-Reply-To: <1225338485-11046-1-git-send-email-sam@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99457>

These proposed changes look great.

On Wed, Oct 29, 2008 at 8:48 PM, Sam Vilain <sam@vilain.net> wrote:

> +  * 'git unstage' would do what 'git reset --' does now

Would it make sense to deprecate using "git reset --" for this then?
It's always seemed confusing to me to have such disparate
functionality in the reset command.

> +  * 'git export' command that does what
> +    'git archive --format=tar --prefix=dir | tar x' does now

It would be nice if the "git export" command could "checkout" a
non-repo copy of a remote repo at a specific version. This would be as
simple as calling archive on the remote size and then unarchiving it
locally. But would of course take care of all the plumbing.

(Sorry for the resend, Sam.)
