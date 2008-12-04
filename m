From: "Jeremy Ramer" <jdramer@gmail.com>
Subject: Re: git-gui: Warn when username and e-mail address is unconfigured?
Date: Thu, 4 Dec 2008 13:54:00 -0700
Message-ID: <b9fd99020812041254l5d1fa383m4fcc3b40f6fabacb@mail.gmail.com>
References: <Pine.LNX.4.64.0812041141160.9969@ds9.cixit.se>
	 <b9fd99020812040805j1143c029yf0cc4c1c4a835759@mail.gmail.com>
	 <bd6139dc0812041104s26ae149foeafa489e65aeb584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Peter Krefting" <peter@softwolves.pp.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Dec 04 21:55:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8LEP-0005zz-47
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 21:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206AbYLDUyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 15:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755138AbYLDUyE
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 15:54:04 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:52241 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbYLDUyB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 15:54:01 -0500
Received: by wf-out-1314.google.com with SMTP id 27so4411478wfd.4
        for <git@vger.kernel.org>; Thu, 04 Dec 2008 12:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0dxBEX9qM6O0EsZIkVxMAi01Xi5XH3g7iKYcFk5tKL4=;
        b=j+O7WRpEqX7mp6he7hxGsJz5jc78x2QLgp+lnVCKFd2FvzM7NEEgVfNEAXXoRGEN/J
         UjPDT9SHVgO2ptT2SxCM+0EMVlmgy8ypgHhAlA5Uuqv8u5X+Efjxa0lCjWUMW7xUk6pc
         YFk53DNsN4TfRCg6FP7WyA5+EMvb9wL0lYMKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AkLIyJycofrkpkXza5dTlLV3GLr/m8coEMmpLAL8m2DgF7w3Xz80AYE9lSwPKzkxO+
         Qb+ZIyY72/8wn2r+N1BsR8ZQ7RdQrMXjVJWmCIkjpAK5K/W1CY+dkZ4VWrpGfFWTMGlA
         OL8eiNMBcAuGTaWCZnDchkdwlFak0UdxYlqIQ=
Received: by 10.115.73.20 with SMTP id a20mr9321116wal.1.1228424040550;
        Thu, 04 Dec 2008 12:54:00 -0800 (PST)
Received: by 10.114.57.17 with HTTP; Thu, 4 Dec 2008 12:54:00 -0800 (PST)
In-Reply-To: <bd6139dc0812041104s26ae149foeafa489e65aeb584@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102366>

On Thu, Dec 4, 2008 at 12:04 PM, Sverre Rabbelier <alturin@gmail.com> wrote:
> On Thu, Dec 4, 2008 at 17:05, Jeremy Ramer <jdramer@gmail.com> wrote:
>> That's strange. I am using git 1.6.0.4 on cygwin and I get a warning
>> message every time I start git gui.  I actually find this really
>> annoying and would like a way to turn this warning message off.
>
> git config --global user.name "Your Name"
> git config --global user.email "you@example.com"
>

I have done that.  I still get the warning message every time I start git gui.
