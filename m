From: Santi <sbejar@gmail.com>
Subject: Re: [PATCH] Document that "git add" only adds non-ignored files.
Date: Sat, 20 May 2006 11:54:07 +0200
Message-ID: <8aa486160605200254yef22fadj@mail.gmail.com>
References: <8aa486160605191402k2863e5edk@mail.gmail.com>
	 <7vfyj5ispx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 11:54:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhOA0-0004Vm-Ef
	for gcvg-git@gmane.org; Sat, 20 May 2006 11:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWETJyI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 05:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWETJyI
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 05:54:08 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:13706 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932305AbWETJyH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 05:54:07 -0400
Received: by wx-out-0102.google.com with SMTP id s6so631764wxc
        for <git@vger.kernel.org>; Sat, 20 May 2006 02:54:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S7BPOF3yor6PL75rzhZ8wytFiqBVTRmYmOZkKEUVZhp5EVmceXJPh8uiIV0aBb3PxBnXut2h7GM21DjQkymJu7ASvIBFUTRhmRoLh3OCMcx/NrT/vhhnxsOLOJoVkBMzBpjKekehG7dbXaqrMEI7R4o9OT+W4GauPLJtCBBb8yk=
Received: by 10.70.17.10 with SMTP id 10mr3093840wxq;
        Sat, 20 May 2006 02:54:07 -0700 (PDT)
Received: by 10.70.20.2 with HTTP; Sat, 20 May 2006 02:54:07 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vfyj5ispx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20374>

2006/5/19, Junio C Hamano <junkio@cox.net>:
> Thanks for the reminder, but I wonder if it is good to update
> the description of this command, and ls-files to use the
> same wording for consistency.  We seem to use <pathspec> to mean
> "this is not necessarily a filename -- we glob", so that may be
> a good candidate (we do not have <pathspec> in glossary yet --
> we would need to add).

I changed it to match with the new usage string in the buildin-add.c.

>
> Please don't touch description for diff-* family -- right now,
> they say <path>, because they do not glob.  If we decide that it
> is a good idea to glob (which I suspect we don't for the
> low-level stuff, but we probably do for the "git-diff" wrapper),
> we would update the code and the description at the same time.
>

OK.

Santi
