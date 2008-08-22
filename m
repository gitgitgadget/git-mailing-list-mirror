From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] Extend "checkout --track" DWIM to support more cases
Date: Fri, 22 Aug 2008 19:33:44 -0400
Message-ID: <76718490808221633y1da9d790j53df67f5c968915e@mail.gmail.com>
References: <20080820185028.GA16626@blimp.local>
	 <alpine.DEB.1.00.0808202151320.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20080820200440.GF16626@blimp.local>
	 <alpine.DEB.1.00.0808202213340.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20080820202952.GH16626@blimp.local>
	 <7vd4k3nx7m.fsf@gitster.siamese.dyndns.org>
	 <20080821172320.GA5119@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 01:34:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWg9Z-0004XB-Bh
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 01:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbYHVXdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 19:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbYHVXdp
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 19:33:45 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:57871 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbYHVXdp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 19:33:45 -0400
Received: by yx-out-2324.google.com with SMTP id 8so429350yxm.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 16:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nVVPQbN7TELCRXnV+ATAJ39L6/+rETVfLOKIA86/XX0=;
        b=LFxBRcFUrcpczPgZtY/piKooy06kT3JsJPawmMZLLP8n7z0ccwkjWImjYTZKA+mxOf
         CL/70frCYL79YrVhAlF7Me/AtL3ouYlpO+6tKJgUhSD6EVxk6KT3lhimyGkp9d50Qa0f
         3XYkbSVFrxuZq9X1oaf3T43X39UKIyeQK5GiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jyHLHioaso8AkQVZo31nhR6JiNU5asdYLgU+ZnEf1Jf2JAIbtmLF7f4FfTziC5T9XZ
         JYIiTW99zTrvFLNmUfalm7nRYLwgy1I/PqtJjczGyCmd5VD5aqqZnnVvd4C87AGDAJ5l
         UhfigY5Th1ch918raLDh+jThufs7NZpvZI9xg=
Received: by 10.150.229.16 with SMTP id b16mr2724062ybh.133.1219448024232;
        Fri, 22 Aug 2008 16:33:44 -0700 (PDT)
Received: by 10.150.149.15 with HTTP; Fri, 22 Aug 2008 16:33:44 -0700 (PDT)
In-Reply-To: <20080821172320.GA5119@blimp.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93402>

On Thu, Aug 21, 2008 at 1:23 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> +If no '-b' option was given, the name of the new branch will be
> +derived from the remote branch, by attempting to guess the name of the
> +branch on remote system and use it. The algorithm will remove a
> +prefixed refs/ and the part after refs/ up to a slash (that part
> +usually being a branch namespace, which makes it confusing to use for
> +branch names). If the part after refs/ was remotes/, than a part past

s/than/then/

j.
