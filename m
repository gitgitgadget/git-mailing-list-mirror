From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Print diffs of UTF-16 to console / patches to email as
 UTF-8...?
Date: Fri, 22 Oct 2010 11:18:51 -0500
Message-ID: <20101022161851.GH9224@burratino>
References: <1287763608.31218.63.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Oct 22 18:22:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9KOB-0004Qa-3V
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 18:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757730Ab0JVQWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 12:22:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34331 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757544Ab0JVQWk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 12:22:40 -0400
Received: by pwj3 with SMTP id 3so317019pwj.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 09:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=R36Nc+gk3EnYoKcu250B1pShrASQPF/Z3/Ziz0Kg9v4=;
        b=DL/5y21Ov7BohM4Zh5hP8JYvrU0WSgD8AOtvFvUPcZFF9HfuFfoGRi8pQ72b8/ljEk
         1nuYDlXPhFVC0Tq6C5OV6JV/0F9Kif/bSG52K0wiDnoiH0er7HeNlcg1WgtT3qwTq3J9
         51N6R+NdThbSYC9J4126AFDG6RhGYWC/Y2OT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fGOp1jRRFqU4dGSaN6UekNCpyWKOwwIrhM7aDHl+oHiFQNNhnE51xCmvKGoq5Ezt2K
         5AADpz3cIlDFFYcfyzVbiKN3bqmJhzZofFbjzObHETQyaYt0KIdq+za4eSUNgle7R2Is
         jS2EHJapnk0XkuX69UyCfZUzSrUE8ru3ppQCU=
Received: by 10.229.241.207 with SMTP id lf15mr558076qcb.42.1287764559160;
        Fri, 22 Oct 2010 09:22:39 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id n7sm2748387qcu.4.2010.10.22.09.22.37
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 09:22:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287763608.31218.63.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159709>

Hi,

Drew Northup wrote:

>         This is part of my ongoing work to treat UTF-16 as text (in
> other words, the crlf options will work and .gitattributes hacks won't
> be required to display diffs, etc).

What's wrong with .gitattributes for this use case?  I would think a
clean/smudge filter would produce very good behavior from most git
commands.

If speed is the issue, maybe a built-in clean/smudge filter would
address that?
