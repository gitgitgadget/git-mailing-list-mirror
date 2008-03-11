From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 07/10] builtin-archive: mark unused prefix "unused_prefix"
Date: Tue, 11 Mar 2008 23:21:57 +0700
Message-ID: <fcaeb9bf0803110921g754dfa54w517cad490476e59e@mail.gmail.com>
References: <cover.1204453703.git.pclouds@gmail.com>
	 <20080302103446.GA8983@laptop>
	 <alpine.LSU.1.00.0803111432370.3873@racer.site>
	 <fcaeb9bf0803110750rd70a303r3fc522b326ea93b@mail.gmail.com>
	 <76718490803110838p1cdc30a8vb9792d81ddf62a0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 17:23:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ7FS-0005lD-GA
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 17:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbYCKQWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 12:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbYCKQV7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 12:21:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:9090 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbYCKQV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 12:21:59 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2470039fga.17
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 09:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5CGVa6ay11IXTa+KUL2FyQasRG3/310/qwt2j3+4dZ8=;
        b=NOxeury3ibaUctTi8WYpGbEWPVEwYycv9nnBiqK3e+dqcoy+qYYU03FbQbzZtM6+KC8MB0BnQjy7+XnW9/4atg/whfVbKSIWlolhFTKrFzwdtaoDmKlPb0qz0acJ+eMtG9bypaOIOHvFm5bMtBr96M7xyeylLmED5CqFqONW93o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iB9XFDDKNjTfxT/1xetHML7xpemDkLjITIztNFgyNufosGprPiSm+DCbcsBk6dcMH3AJwFEqzvvoqq8VCO1jRnSOSuqHChMM6p8AERzw9HnLvbYdD2wCAOAqpUjSA4758njRHEKPk5xSRj3MsGJtfFFSM03Y+5Kg3/8hh/33ahs=
Received: by 10.86.73.17 with SMTP id v17mr37980fga.40.1205252517705;
        Tue, 11 Mar 2008 09:21:57 -0700 (PDT)
Received: by 10.86.81.4 with HTTP; Tue, 11 Mar 2008 09:21:57 -0700 (PDT)
In-Reply-To: <76718490803110838p1cdc30a8vb9792d81ddf62a0d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76877>

On Tue, Mar 11, 2008 at 10:38 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> I hate to make this request, but Gmail seems unable to decode messages
>  which are "Content-Disposition: inline" + "Content-Transfer-Encoding:
>  base64". The message body shows up completely blank in the Gmail web
>  interface. (I wonder if it is due to the footer that Majordomo appends?)

Funny that meesage was created by gmail.

>  I've reported this is a bug to Gmail, but since I imagine I'm not the
>  only one using Gmail to read this list, and since so far your messages
>  seem to be the only ones sent this way, can I ask that you configure
>  your MUA to not send messages this way, if possible?

If I does not misunderstand it, non-ascii characters make gmail encode
messages base64. I'll be careful next time removing all non-ascii (or
switch back to mutt).

>  Much appreciated,
>
>  j.
>
-- 
Duy
