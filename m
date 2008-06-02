From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [JGIT PATCH 00/12] Extensions in core needed by PackWriter
Date: Tue, 03 Jun 2008 00:58:10 +0200
Message-ID: <48447B02.3040505@gmail.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com> <alpine.DEB.1.00.0806022313270.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: robin.rosenberg@dewire.com, spearce@spearce.org,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 03 00:59:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Izu-0001MJ-EI
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 00:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbYFBW6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 18:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754212AbYFBW6V
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 18:58:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:6657 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbYFBW6T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 18:58:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so864358fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 15:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=cOotK1NARmOB2lkIIHZ+SyzfU7Nei9e6Xy11UH5wI1E=;
        b=VlGnwX+h5MqrLB0a/m+4mG2xVcr7hqoZfHBHfz4/e11As2iTcOD+TLt07zBU881HyPUnFaBLg8udoixtK2DYIV0eRboe7GqxjYfTIdG33/CYytK5PqGkSWg3drCAKyDxFfZAG/1wgP31hrElQHH/vxmnV1EXDZuWnxJppdvlg4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=vTFCQbSibkcRcTIX2OtC5DM+Sw8JeuskzeoIpPvBhWgrAmg3jCi9gOJD4/PNrHOjgNYepQCkIFTm+k22bzTQ5Rp1+A3iNkRc9iS+rRtURguw/Y0wKf0kx80ZdeUBroPU0RXjjQt0AUJlGocrb8gdctEXKv4NRkZ1DpTEzXQUp14=
Received: by 10.86.54.3 with SMTP id c3mr4411436fga.55.1212447498141;
        Mon, 02 Jun 2008 15:58:18 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id l19sm5046641fgb.7.2008.06.02.15.58.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 15:58:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080313 Iceape/1.1.9 (Debian-1.1.9-3)
In-Reply-To: <alpine.DEB.1.00.0806022313270.13507@racer.site.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83589>

Johannes Schindelin wrote:
(...)
> You mean line-wrapping, right?  Is there a different 
> recommended column/line ratio for JGit than for Git?  Because some of your 
> later patches introduce lines longer than 80 columns/line.

Not only line-wrapping in fact. egit/jgit use it's own eclipse formatting template 
that define more than line-wrapping, even some spaces in javadocs as you may have seen.
Actually I don't know is it 80 columns/line (but I suspect it may be), as I just use 
this formatter associated with project by simply pressing some keyboard shortcut. 
Maybe I simply missed some formatting, which patch do you mean? Some things however 
look strange after auto-formatting. While it may even look ugly for somebody I 
wouldn't try to change that by hand, to make other commiters lifes easier allowing 
them also just press "format" button ;)

>>   Add getType() method to RevObject hierarchy
> 
> Was the idea not to use instanceof to be able to have multiple "types" per 
> object?  I.e. a commit object is of type commit, but also of type 
> object...

I'm not sure whether I understand you, but probably it was not what you mean. The 
only idea behind that was to refactor instanceofs to polymorphic getType() calls. It 
allows us mapping, indexing by type, using switches... without tones of code.


> BTW I really like the iterator implementation.

Thanks for looking in.

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
