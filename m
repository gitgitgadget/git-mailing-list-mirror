From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make 'make' quieter while building git
Date: Tue, 6 Mar 2007 10:16:12 +0100
Message-ID: <81b0412b0703060116m166e2da7saeab82c67536558e@mail.gmail.com>
References: <20070306063501.GA24355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 10:17:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOVn9-00040k-Fp
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 10:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933173AbXCFJQS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 04:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933174AbXCFJQS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 04:16:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:41151 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933173AbXCFJQP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 04:16:15 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2403336nfa
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 01:16:14 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YDnmjMObqy4wOY/xpnDZPZ1urdworw1Q8xv84O7jYyXORSWT/hO1lefLT52GE6Qd15RwsWdtQ+hmGH0Ox40ziRq83Dobo1OhdCT5ht/lVT+hoY3jtNOe1VWJR41lQfdDtguUZIWHOmPTcJfCKIh71Ju2gmgLggQA4+DzrhT3N/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fr1KmeytOLN6CkCsi/y3VzVSjvl1eT6A6SjsoZ9CDDOJyjxQ9wxUMC8RkawE18njf7uPEfIw9IufKRenjYgoBAnlnMLizkEURWeenTwbrJQo70cPB4K1kSb4IdDIb9NexiHVazbrVB4WXQPhP0KnWnDNqPhU+Z9g+A4vcofHbNs=
Received: by 10.78.149.15 with SMTP id w15mr756166hud.1173172572153;
        Tue, 06 Mar 2007 01:16:12 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Tue, 6 Mar 2007 01:16:12 -0800 (PST)
In-Reply-To: <20070306063501.GA24355@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41563>

On 3/6/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> ...
>     CC builtin-grep.c
> builtin-grep.c:187: warning: 'external_grep' defined but not used

Can I suggest printing the resulting object file instead of source?
It is useful if you want rebuild just one file by mouse-copy-paste it
into command line (the source file name for editor in case of
error is already in error message).
