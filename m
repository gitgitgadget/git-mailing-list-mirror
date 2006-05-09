From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: git-feed-mail-list.sh
Date: Tue, 9 May 2006 03:09:36 +0200
Message-ID: <4fb292fa0605081809r6aa76baai5eac9823183fc3fc@mail.gmail.com>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	 <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
	 <1147131877.2694.37.camel@shinybook.infradead.org>
	 <Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
	 <4fb292fa0605081755m22e8239cjda0b1ac74b84c0d9@mail.gmail.com>
	 <7vac9sc8m3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 03:09:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGjN-0000pd-Kn
	for gcvg-git@gmane.org; Tue, 09 May 2006 03:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWEIBJi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 21:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWEIBJi
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 21:09:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:36743 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751329AbWEIBJh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 21:09:37 -0400
Received: by nf-out-0910.google.com with SMTP id b2so1089518nfe
        for <git@vger.kernel.org>; Mon, 08 May 2006 18:09:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QT8N0wb4KgD2QRF3nhXtmEbW4Yt4Kfvg3HM0rAWXnr+bzyMF/TMeVtUaNVZ7PI401x+RUyWEjFyoRoeLYZnOv2Pb/jZetMNtBW18saMpB2qBk0gR3ZAm76EolPmkzOenDRQlH+lu/JGG10HIk/1IGsgaPJyMmvaeQ9/8c9AbBPM=
Received: by 10.48.3.17 with SMTP id 17mr1649603nfc;
        Mon, 08 May 2006 18:09:36 -0700 (PDT)
Received: by 10.49.2.19 with HTTP; Mon, 8 May 2006 18:09:36 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vac9sc8m3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19802>

On 5/9/06, Junio C Hamano <junkio@cox.net> wrote:
> "Bertrand Jacquin" <beber.mailing@gmail.com> writes:
>
> > Is there a way to track merge like that?
>
> The command line you quoted shows the relevant information for
> people who want to know what happened in that merge.
>
> Namely:
>
>  * it always shows the header and the message
>
>  * it shows the changes that are not trivial (i.e. merge parents
>    have overlapping different versions and manual resolution
>    resulted in something different from either parents).
>
> It is not a replacement for format-patch, but I think the commit
> mailing list is not for machines to receive and apply the
> received patches, but for humans to inspect, so it would be more
> suitable than a naive alternative of showing diff from all
> parents concatenated together.

That's right. And don't want to do that.

But I would like to send an email after merge to inform people that:

o tree ``a'' and ``b'' have been merged.
o made by John Doe at a time
o show a diffstat.
o show a --short-log=oneline from merge base.

--
Beber
#e.fr@freenode
