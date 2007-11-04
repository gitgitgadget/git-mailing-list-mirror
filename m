From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH qgit] Add support for --early-output option of git log command
Date: Sun, 4 Nov 2007 19:15:40 +0100
Message-ID: <e5bfff550711041015i739ff6efpcbd6b5ec704e8c10@mail.gmail.com>
References: <e5bfff550711040225ne67c907r2023b1354c35f35@mail.gmail.com>
	 <34C93069-06F8-44DA-A18F-EE36BB457ABC@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Michael J. Cohen" <michaeljosephcohen@mac.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 19:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iok0p-0006YD-Ca
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 19:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbXKDSPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 13:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753582AbXKDSPl
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 13:15:41 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:61350 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbXKDSPk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 13:15:40 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1308095rvb
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 10:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/ipwFCa5yHmnWZ0DblMZkdYGhyvo81Lg0IrOBZj60hE=;
        b=p7JpWd/D/Xn6Pu1A67Q55Y677r/x4k2NJWHrfity+HBxiULH2EN46TUmIA8zmVpglMwafco/WTNmSs5PZMJPZMCuOYIVKLRv2HV7puvOq71HxA7NpoW6f+RvrFo/PjuWEOeofcmrQFL5G4+Xk7RIP02NxeNcPd3mKLctI4eO2+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FaJT+0yr1UQQXYLA+G/TyPh5f9fQoFCN6Htn1YXGv+t2TlzyrQNRVbtRw35en59OYmthjAXT9uBEkaqfZgGo8eSmWovCU0h8C0DgcEGBkA+lNvLXbvMotPiktB/ZS7GcZILuArkiIDAYvlSbJZ1RbBmfV9+yJB7qQjAIazUWYBI=
Received: by 10.141.162.16 with SMTP id p16mr1960880rvo.1194200140254;
        Sun, 04 Nov 2007 10:15:40 -0800 (PST)
Received: by 10.141.203.3 with HTTP; Sun, 4 Nov 2007 10:15:40 -0800 (PST)
In-Reply-To: <34C93069-06F8-44DA-A18F-EE36BB457ABC@mac.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63424>

On 11/4/07, Michael J. Cohen <michaeljosephcohen@mac.com> wrote:
> On Nov 4, 2007, at 5:25 AM, Marco Costalba wrote:
>
> >       bool populateRenamedPatches(SCRef sha, SCList nn, FileHistory* fh,
> > QStringList* on, bool bt);
>
> **** malformed patch at line 137: QStringList* on, bool bt);
>
> looks like it was wrapped...
>

Sorry, it's a problem with gmail, please tell me if you want me to
resend as attachment or you fix the patch yourself.

Marco
