From: "James Kingston" <james.kingston@gmail.com>
Subject: Re: newbie with broken workflow
Date: Fri, 4 Apr 2008 09:08:26 -0500
Message-ID: <9d27c6320804040708l6eace184q9677ca75729b4eef@mail.gmail.com>
References: <9d27c6320804031445p3fc80115n59218673dd587795@mail.gmail.com>
	 <alpine.LNX.1.00.0804031957010.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Apr 04 16:09:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhmbP-0001aS-6U
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 16:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbYDDOI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 10:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbYDDOI2
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 10:08:28 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:34086 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbYDDOI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 10:08:27 -0400
Received: by wa-out-1112.google.com with SMTP id v27so49040wah.23
        for <git@vger.kernel.org>; Fri, 04 Apr 2008 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lKZd1fjSKbA/55uNNPeUzyuH2wAlspahM1FMAn5XRaE=;
        b=TqF5go24i2vjUh5Aaxcs9ViDL92jvSz97/aOK5h0LKSmiaIpr/RZoyu9lqUKjataIr2ZDOxiikLHEqlmnutpliDHGabaLB6HPZpwL6lFrzBh15XDhzAhXqcPLEyedfpwe7kiFaYPRHSqYcpc5vlhM1KvubloOloCE9gJahdYze4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VnUsUqQWDyArQ3Q9P8z1czB8ZctW4mSuEvoIM+ZXrP7AfJ/PsauqjGRUhhjz1zks3+O0C3j/CYmVWDj6t4kwRHESrw0juP9E+zVqi8cXZqBBefuDIUDNfdCqTZf7ZlnrY6Hn2EXarzRVV2kWi+fLQnrKa6h6bj7iLMrtSDt0+Zw=
Received: by 10.115.32.8 with SMTP id k8mr1988838waj.89.1207318106334;
        Fri, 04 Apr 2008 07:08:26 -0700 (PDT)
Received: by 10.114.57.6 with HTTP; Fri, 4 Apr 2008 07:08:26 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0804031957010.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78804>

On Thu, Apr 3, 2008 at 7:05 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>  /c/wd/cc> cd /c/cc
>  /c/cc> git pull ../wd/cc
>
>  But wouldn't that fail, because the files are read-only?

Actually, I just tried and it worked beautifully.  The directory is
writable, so git replaces rather than modifies the files.  Then I can
use CCRC to search for hijacked files, check them out in one swoop
with the option to keep my modifications, then check them all in as a
group.
