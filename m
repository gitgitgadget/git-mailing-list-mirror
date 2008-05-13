From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Paginate project list
Date: Tue, 13 May 2008 18:46:06 +0200
Message-ID: <8c5c35580805130946m691b9389sad20d1949cbc896c@mail.gmail.com>
References: <200805011220.58871.jnareb@gmail.com>
	 <200805120903.25040.jnareb@gmail.com>
	 <8c5c35580805120843j9b401f8mfa104806880a51c2@mail.gmail.com>
	 <200805130855.08133.jnareb@gmail.com>
	 <8c5c35580805130939m1a1ef8e0yd72402f3c79190ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"J. H." <warthog19@eaglescrag.net>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 18:49:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvxek-0005Ad-9R
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 18:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbYEMQqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 12:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754790AbYEMQqS
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 12:46:18 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:35388 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbYEMQqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 12:46:16 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1627146ywe.1
        for <git@vger.kernel.org>; Tue, 13 May 2008 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jjkt1FnukQSDBtj+ZJmpJGj9ocjB+Gxt5jeCgKye/kg=;
        b=buEzHD7ohfjR0aZPEA130PT6ibuvLqz3nqg0wp3b2upfkWayj/t/pKIOFP/EfgxC6tBiarAtgxND8Rrq0DoRm23sIddfsDCLpbOs3y+yS2xtJZhbMjF5BJc3HVTwt9ppO6TcRHnB13cT3VXGit2YFwQn/kdmVM6zKlbgKywTA3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DWDtukb64l/qfvkPgC8Ekwetj1vV2K1+cn/lhFwWo8ydm4lFlGptFZOsMdh0G3ZE7DOyjQxwNRPL6YLeznhpxjmBSeEhfmJUAokLI1VFpaAdos2OYgvFdChUeE2RIRL5HEFQLGEprWOjljXq45vz+Y5hkCjZidS9fSBNu88dWIA=
Received: by 10.150.79.42 with SMTP id c42mr9837796ybb.162.1210697166373;
        Tue, 13 May 2008 09:46:06 -0700 (PDT)
Received: by 10.151.39.3 with HTTP; Tue, 13 May 2008 09:46:06 -0700 (PDT)
In-Reply-To: <8c5c35580805130939m1a1ef8e0yd72402f3c79190ea@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82033>

On Tue, May 13, 2008 at 6:39 PM, Lars Hjemli <hjemli@gmail.com> wrote:
>  $ time git-rev-list -n 100 master >/dev/null
>
>  real    0m0.006s
>  user    0m0.008s
>  sys     0m0.000s
>
>  $ time git-rev-list -n 100 --graph master >/dev/null
>
>  real    0m1.670s
>  user    0m1.636s
>  sys     0m0.032s

I forgot to mention: That's on a recent linux-2.6.git, using current 'next'.

-- 
larsh
