From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Closing the merge window for 1.6.0
Date: Tue, 15 Jul 2008 11:51:34 -0400
Message-ID: <32541b130807150851v553bca5bo4f61351692c1bc56@mail.gmail.com>
References: <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
	 <7vzlokhpk7.fsf@gitster.siamese.dyndns.org>
	 <20080714085555.GJ32184@machine.or.cz>
	 <alpine.DEB.1.00.0807141256310.8950@racer>
	 <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org>
	 <alpine.LFD.1.10.0807141351540.12484@xanadu.home>
	 <7v3amcgujd.fsf@gitster.siamese.dyndns.org>
	 <20080715092023.GO10151@machine.or.cz>
	 <20080715150626.GA2925@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.0807151623120.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>, "Gerrit Pape" <pape@smarden.org>,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 15 17:52:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KImpR-0005Ay-8E
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 17:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbYGOPvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 11:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbYGOPvg
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 11:51:36 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:31920 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbYGOPvf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 11:51:35 -0400
Received: by qw-out-2122.google.com with SMTP id 3so167349qwe.37
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PcOVxKbs2Ks5RPUZ+q+m49EuVHIyKU96OXSORx+weuw=;
        b=YNlOPL3/zRXej+y+iRNhk+mboLg9EWKRa+KCASDfy+3AOCN6xT0o8rkberGJEAeHAU
         oAy6o0pMAAfbzc+uQws2t92ZSZei8RB6ZoKeRZnuOtBoSp1UtgszC0ox80dqR5h3Dje3
         h+P7t/sJ2SoDsYT1RApiWxXTEPtscP2hDSSMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NkzgSm+CkockO9JM3HHtDXYqEoBMCD0IYOO+uJold3TZYnhBNLpRLeXdBoTXgpCSsK
         NJVrSsBtQHnFIVnqEl7fO0A0c1yg5E19DyOaHHEFB3WjusVzoxVLxYMQj9sugXlFub+t
         3eTElZa8crTY5WY+50VATc89pi0XeNo8CW+tA=
Received: by 10.151.111.15 with SMTP id o15mr517791ybm.7.1216137094583;
        Tue, 15 Jul 2008 08:51:34 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Tue, 15 Jul 2008 08:51:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807151623120.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88574>

On 7/15/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  On Tue, 15 Jul 2008, Dmitry Potapov wrote:
>  > Those repos that think that access for Git 1.4 users is important for
>  > them can set indexformat=1.
>
> Unfortunately, you place quite a high maintenance burden on the repository
>  maintainers here.
>
>  From the time balance sheet, it does not look good at all: a few minutes
>  for Junio to change and commit, up to a few hours (because they missed it
>  in the release notes) for probably more than hundred repository
>  maintainers that are not subscribed to the Git mailing list.

To take this in a slightly different direction, what exactly is the
benefit of the new feature?  Apparently my git doesn't have it enabled
by default, and git works fine for me.  Am I missing out on something
that I should feel inferior about if my non-debian-etch running
friends(*) found out about it? :)

Have fun,

Avery

(*) Actually I compile my own git from source anyway.  I never want to
live without "git rebase -i" and "git add -p" ever again.  Life is too
short! :)
