From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: That improved git-gui blame viewer..
Date: Wed, 13 Jun 2007 16:08:02 +0200
Message-ID: <e5bfff550706130708k601514c9o1ba2747582027699@mail.gmail.com>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
	 <7vveduqxxr.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com>
	 <7vbqflll55.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com>
	 <20070612135303.GT6073@spearce.org>
	 <7v645thto7.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706130411g151b76e3sa2e351aff5dbb35b@mail.gmail.com>
	 <e5bfff550706130544m40e2f210p2412ef7fde2867a1@mail.gmail.com>
	 <Pine.LNX.4.64.0706131344430.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 16:08:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyTWT-0000zm-KD
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 16:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185AbXFMOIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 10:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbXFMOIG
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 10:08:06 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:5416 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbXFMOIC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 10:08:02 -0400
Received: by wa-out-1112.google.com with SMTP id v27so249170wah
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 07:08:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RPEHBtQX5C4YR9I5O+ICdevdIvqr19XlYXOItfcj2trESYa7/pIqzVkuF6sjc8zaHRR8PlTkgsosIGU7ag3F4mBcZGtQEn/Q+iJlG+OTU5KJmIK5EwYPDiuvQf1727R1dGgemo6MjZUDAs14Mne2/7kT0GcFkwk74mkgtPE8m9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EvPBpBdMg6vXrwzyV5r1xoapBSwpa6aQqLvjTfqfTu4zRjAuDypvdej3YE+CwcsHjBMfhD0j8butB1VD9Pbn87b8U9l13wdGAIJqWPagf6J4AXnKZFe28IhOKb5O2Ncbgu4btJwthq5jfGvPkWa5nv6JaRcpmiojlz+OmYp+z9Y=
Received: by 10.115.59.4 with SMTP id m4mr629876wak.1181743682071;
        Wed, 13 Jun 2007 07:08:02 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Wed, 13 Jun 2007 07:08:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706131344430.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50060>

On 6/13/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > then running: git log --pretty=raw -z --parents --boundary HEAD > tmp.txt
>
> Isn't that a bit unfair? You should have passed "--pretty=raw" to
> rev-list, too.
>
> Since you already have that tree, could you try rev-list _with_
> "--pretty=raw", just for comparison?
>

Of course, here we are

running: git rev-list --pretty=raw --parents --boundary HEAD > tmp.txt

times are: 1,16s - 1,11s - 1,13s

BTW this performance gap seems to exsist only under Windows, under
Linux if I remember correctly (cannot test now) the difference is
smaller.


Marco
