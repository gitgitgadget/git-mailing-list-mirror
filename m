From: "Bryan Donlan" <bdonlan@gmail.com>
Subject: Re: Apply patch on server w/o git
Date: Tue, 25 Mar 2008 14:41:04 -0400
Message-ID: <3e8340490803251141x6d199d8ch8828b396da202d81@mail.gmail.com>
References: <CA08AA77-A9EA-4490-B1BE-25E8B7402290@faithfulgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Joe Fiorini" <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 19:42:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeE5r-0008Py-TX
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 19:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbYCYSlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 14:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755105AbYCYSlI
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 14:41:08 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:21680 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbYCYSlH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 14:41:07 -0400
Received: by py-out-1112.google.com with SMTP id u52so5106472pyb.10
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=AYayOPU6q4wJdrgx1/oBuR185jqM8xlCCsX48nRLGLk=;
        b=KloeUWoIraWyrtxUBxLcDNHnR937uNs1pUpUsBEs14i2X5fnbQZeMTGfBvFTa1chLHdqN5bLTOiiD4ZoXrqBR2BP8lk9Ni0sYbqhgidBlfty9hInn5qk6YcWMptblWwfyeApQQQTgvEyY2mWvcNofIHryR4PYrF+uXZGN4OGdTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CXnzFxCP8L+Fw0UQ4uWMIAW7t7nU/AKkQH/ZCSynfUxXxPo15BKWX+mmrNWPnvyb/A2MEy/L1IZ/99cqnL0qy8Xm/CrqraQquybAUZEYQFRNcTEFa/XAklpJAZ6JV97mxKvfI9N+QeuegiAxP9I2YStjRtIQausoXvpQLolVfKk=
Received: by 10.65.73.16 with SMTP id a16mr17249388qbl.85.1206470464473;
        Tue, 25 Mar 2008 11:41:04 -0700 (PDT)
Received: by 10.64.49.9 with HTTP; Tue, 25 Mar 2008 11:41:04 -0700 (PDT)
In-Reply-To: <CA08AA77-A9EA-4490-B1BE-25E8B7402290@faithfulgeek.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78205>

On Tue, Mar 25, 2008 at 2:25 PM, Joe Fiorini <joe@faithfulgeek.org> wrote:
> I am trying to generate a diff patch on my local dev box.  I want to
>  upload this patch to a server (running Windows Server 2008) and apply
>  it to my staging code.  The catch is: I cannot install git on the
>  server to accept the patch.  Therefore, I would like to use a generic
>  patching tool (such as patch from the GnuWin32 tools).  I tried
>  generating a unified diff with the following command:
>
>  git diff -U > diff.patch
>
>  and then tried to apply it using:
>
>  patch -u -i ..\other_dir\diff.patch
>
>  and I got the error:
>
>  "patch unexpectedly ends in middle of line" ... "Only garbage was
>  found in the patch input"
>
>  It might be a problem with how I'm using patch, and if so, forgive
>  me.  If not, then how can I generate a generic diff format from git so
>  I can do what I want?
>
>  Thanks all!
>  Joe Fiorini

Just a guess, but the gnuwin32 tools might not like unix line endings.
Try opening and re-saving in wordpad (or vim :set ff=dos, or $insert
your favorite method here).
