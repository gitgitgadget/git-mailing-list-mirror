From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: That improved git-gui blame viewer..
Date: Tue, 12 Jun 2007 13:58:25 +0200
Message-ID: <e5bfff550706120458o3b969c70rc065f67777ab1805@mail.gmail.com>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
	 <20070611064203.GG6073@spearce.org>
	 <alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org>
	 <7vveduqxxr.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com>
	 <7vbqflll55.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 13:58:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy517-0006X8-M0
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 13:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbXFLL60 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 07:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbXFLL60
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 07:58:26 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:12699 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149AbXFLL60 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 07:58:26 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1621960nzf
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 04:58:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZWdxdGxMr/w1AKeoZLpGdJfv1PaPYxoppDUa3cbJuptqAiVIpuAuVoo3llYSj7N9CS43NeMHS3KHBnF5qSsI8r0OooJaEHwpfRtrgR0kjbowiTMhJYN0hZ48quCq6FD7PW4+f0gNFjuhuBB9FPKAeXOyBitCbpKYfFFgGZUOceI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Te5pDoT7Ezc5afomEmPvYWlrGEqIRjatatlTJ7zQuHiexlgfvSuhdhevZUtRWIK3ea2fmtfMYW1hG03CWFqzRaFnz+1rYFVkArUSZ4VGRZ8nQfpP/xPDUHT54tygBppWiaCSccJJNb5vrI+YKXbUmkrb9nMyyV0qje7kkfmMY6I=
Received: by 10.115.49.16 with SMTP id b16mr6545795wak.1181649505299;
        Tue, 12 Jun 2007 04:58:25 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Tue, 12 Jun 2007 04:58:25 -0700 (PDT)
In-Reply-To: <e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49950>

On 6/12/07, Marco Costalba <mcostalba@gmail.com> wrote:
>
> So the complexity of annotating *all* the files revisions grows only
> linearly with the revision list size.
>

Going from newest to oldest, after having elaborated all the diffs
between revisions you have the newest file correctly annotated.

Going from oldest to newest, after having elaborated *in the same way
as above* all the diffs between revisions, you have _all_ the files
correctly annotated.
