From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [REPLACEMENT PATCH 2/2] Add "--early-output" log flag for interactive GUI use
Date: Sat, 3 Nov 2007 20:52:40 +0100
Message-ID: <e5bfff550711031252g448fd886s2bd3903318829e2b@mail.gmail.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	 <18217.41899.54812.227152@cargo.ozlabs.ibm.com>
	 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
	 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
	 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
	 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Paul Mackerras" <paulus@samba.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 20:52:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoP39-0008Vi-TX
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 20:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914AbXKCTwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 15:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755440AbXKCTwl
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 15:52:41 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:52598 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067AbXKCTwk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 15:52:40 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1118949rvb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jEmXA5ZazPtlWvRefNhYuDZvX2d3sDh9WEU31HthyFs=;
        b=ekZcGCJkz9Eb3ONH2PS6NzK0UKBRjfjk+Hwl8xFppRq2DOJtq9JuLu9ClAgGsMWUwnHjoXvE68ImMdMqFjVtigFK5Xc6kQCKV5WK6345lOew0TX8c1Pt0OwwrXbP4EE7ffUH1gl0ipfDEoNqpzFsqX8oCzRbXaVB+i+hANARlpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QDZJmzSu1RNQmoP+v09Cm92L6w6Pq5RdKHgNXMHwPyLZKoCB5MXDXciRrlahMqvDYF1A1rweXxbGLghCahk5IGdS9l+4Xpo55DKbnxaXJondBUmz9/BrXn2kwL/1BjAUgn7WV2XJwAmBHP9WV6f+36H+L97svnVsNAo2K4mR9+U=
Received: by 10.140.188.10 with SMTP id l10mr1562906rvf.1194119560463;
        Sat, 03 Nov 2007 12:52:40 -0700 (PDT)
Received: by 10.141.203.3 with HTTP; Sat, 3 Nov 2007 12:52:40 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63305>

On 11/3/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> Try it out, with
>
>         git log --early-output=2
>
> and look at what happens

It works for me! tomorrow I will try to teach qgit to play with this new toy.

BTW there are some warning around that disappear adding

extern void sort_in_topological_order(struct commit_list ** list, int lifo);

somewhere in commit.h

Marco
