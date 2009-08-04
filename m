From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: disable branch modification
Date: Tue, 4 Aug 2009 18:50:51 +0200
Message-ID: <81b0412b0908040950j1aa8ca04t68061a79c96f6522@mail.gmail.com>
References: <24550469.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ishaaq Chandy <ishaaq@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 18:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYNEA-0006mc-G8
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 18:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933061AbZHDQu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 12:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933056AbZHDQu6
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 12:50:58 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35636 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933054AbZHDQux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 12:50:53 -0400
Received: by bwz19 with SMTP id 19so3194458bwz.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z1SxH/3T2B1m2hRTl+G6n8k5mMI2UA/h1wZHardU3Ko=;
        b=TOmirl+mHbV/j+GNrRJ+MIDrX+ktg2keLkW+9EudxDwPOt1yA7shZycinUTi1tyAgf
         NOPzEJDRmz92qgLvOmmGd5xAdRU6vmk6ewElaB2PvLQ0c4bu0+QC4ftX1vIn3OyFAoZ/
         1KM/9yP4x028VYL+huSp8/dCoV0h5O5Utkoh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o6yuOzvZXUypZTI3X2G3NP+JSSHM2cB0S0iMCo0fR4CenZZlW0GFsT3Uv9km1JtWSH
         NbalErkakqEDKAv8x4ZEvuqdM4v4bXZHVtcCJLHvmCIcZkbQ49fNsVzkbNlGqEbDKxXf
         mBvxCkxsFVa4Ro+ewUSe09/g4k+gEnP84kF1g=
Received: by 10.204.70.75 with SMTP id c11mr6052305bkj.128.1249404651851; Tue, 
	04 Aug 2009 09:50:51 -0700 (PDT)
In-Reply-To: <24550469.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124794>

On Sat, Jul 18, 2009 at 20:16, Ishaaq Chandy<ishaaq@gmail.com> wrote:
> 1. Create new branches on it
> 2. Delete existing branches from it

You cannot have these.

> 3. push non-fast-forward commits to it.
>
> I think I'll need to write a pre-receive hook for this, but before I embark
> on this, any helpful pointers would be appreciated.

Look in the mailing list archives for pre-receive, update and SSH,
there were some good examples of update and pre-receive posted.
Also, there is contrib/hooks/update-paranoid in Git repo. It
implements an ACL per SSH user.
