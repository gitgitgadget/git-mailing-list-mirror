From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GITK) v3 6/6] gitk: Explicitly position popup windows.
Date: Mon, 10 Nov 2008 15:15:54 +0300
Message-ID: <bb6f213e0811100415s212893eeu7702f8714ce4440f@mail.gmail.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
	 <1225652389-22082-7-git-send-email-angavrilov@gmail.com>
	 <18708.11537.229423.296701@cargo.ozlabs.ibm.com>
	 <200811091753.31198.angavrilov@gmail.com>
	 <18712.8025.148318.526469@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 13:17:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzVhe-0002fZ-SZ
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 13:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065AbYKJMPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 07:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754033AbYKJMPz
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 07:15:55 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:63955 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbYKJMPy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 07:15:54 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2449724rvb.1
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 04:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EFByMjAHKYNPQVtckT6FISP7/+/VnM/JtPKQHy1zohM=;
        b=it5ZvE4dKRe2wvOUSGAiyZfzWMsE/kJN3Baq7w5sX0OBePWtJIW5F0UzHungHXN+IS
         NweUBkiSAEoK7ceTQPiTUOibZ1rrarg5ellk/pgNcyXVp2XGyq2wYPXdfPBrzWYY4HuQ
         UPK4BCA9Px7Ksd6VLq8wfKGoKZPO28MHQSDPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kFedEjTTHaLvoJInn4Y/JmzSBtYJE6vraKtFTV/8M3r7BNh0FJeIpRAk7kyVYDiBNK
         e/ZrNtHh3dikYYDcLvbujPBtZAMpevY3WKIQOeQyPfk3fV1HAO4sL1DKaYFrMdrP86ZM
         2+MsPccIR90iLNnraNhxoDKdTtqjcaducJ4y8=
Received: by 10.143.163.10 with SMTP id q10mr2359604wfo.324.1226319354073;
        Mon, 10 Nov 2008 04:15:54 -0800 (PST)
Received: by 10.142.216.21 with HTTP; Mon, 10 Nov 2008 04:15:54 -0800 (PST)
In-Reply-To: <18712.8025.148318.526469@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100521>

On Mon, Nov 10, 2008 at 2:47 PM, Paul Mackerras <paulus@samba.org> wrote:
> Alexander Gavrilov writes:
>
>> I don't know about MacOS, but in Linux it does seem unnecessary, so:
>
> OK.  Do you mostly develop on windows or on linux?

I use Linux at home (using a VirtualBox to compile msysgit when I need
to), and Windows at work.

Actually, since last Thursday I also have to use MacOS at work for
some things, but I haven't figured out anything beyond the bare
minimum yet.

>> +    if {$::tcl_platform(platform) ne {windows}} return
>
> Any particular reason why you used $tcl_platform(platform) rather than
> if {[tk windowingsystem] != "win32"} like we do elsewhere in gitk?

No partucular reason, I simply copied that from git-gui.

Alexander.
