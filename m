From: "Gerald Gutierrez" <ggmlfs@gmail.com>
Subject: RE: git with custom diff for commits
Date: Tue, 18 Dec 2007 13:51:38 -0800
Message-ID: <000201c841c0$2e5e08e0$762a14ac@na.acco.com>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com><Pine.LNX.4.64.0712172300510.9446@racer.site><vpq1w9kaphg.fsf@bauges.imag.fr><Pine.LNX.4.64.0712172310090.9446@racer.site><7vbq8o6gxw.fsf@gitster.siamese.dyndns.org><vpqk5ncz8fn.fsf@bauges.imag.fr><7vodco1him.fsf@gitster.siamese.dyndns.org><000001c841b5$89fcef00$762a14ac@na.acco.com> <7vzlw7ybx7.fsf@gitster.siamese.dyndns.org> <000101c841b7$5f1d1060$762a14ac@na.acco.com> <Pine.LNX.4.64.0712182124410.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Matthieu Moy'" <Matthieu.Moy@imag.fr>, <git@vger.kernel.org>
To: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 22:51:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4kL0-0007sa-EQ
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 22:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbXLRVub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 16:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbXLRVua
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 16:50:30 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:60774 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbXLRVu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 16:50:29 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4297344wah.23
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 13:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:references:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        bh=rlt9quS/iVEWLRDrtEZRzyM44NZm9SyliWUbAX/vk/4=;
        b=L1PFflbGzxZgOz3UfTl6flRUgYCwLCwbCLMy1YgjKpogoVb+lGEpfDJi0oPdcR1XytXIgdq0uj3HLrxC82LtzE4yhq/bN7aLRAev8HUyl+nW7NXu6Hvc6J2odmSIFYyrGt69fhZ5MwBtG5t4c4NBQgKuLpXE916fqWSUJGmS0W8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:references:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=MoDaRNC9eeGg1VN6czK1QUnkmXdHzpj/F9xrsJDt7hX2ZLnzSiOFtq8jiyZ2lSwyPnDwksXBZc1I/QOk/9vCtxRfIvnQOyYSJSLBDTU3rCghoJq4ztFy9ut6fd08p5kZV+RSGkZK67kMalUuH38hDSpcQ6RbjLOlJKP1vJ5JYFM=
Received: by 10.115.76.1 with SMTP id d1mr4804302wal.108.1198014628845;
        Tue, 18 Dec 2007 13:50:28 -0800 (PST)
Received: from BURGXGUTIERNB ( [63.87.154.251])
        by mx.google.com with ESMTPS id y78sm38992025pyg.2007.12.18.13.50.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Dec 2007 13:50:27 -0800 (PST)
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.64.0712182124410.23902@racer.site>
Thread-Index: AchBvMcYz19UHL/jSbaVtjBZVy1yFgAAHZfg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68823>

 
> -----Original Message-----
> From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de] 
> Sent: Tuesday, December 18, 2007 1:27 PM
> To: Gerald Gutierrez
> Cc: 'Junio C Hamano'; 'Matthieu Moy'; git@vger.kernel.org
> Subject: RE: git with custom diff for commits
> 
> Hi,
> 
> On Tue, 18 Dec 2007, Gerald Gutierrez wrote:
> 
> > Yes, but wouldn't it be slick to actually teach git's 
> internal diff to 
> > do things like GNU diff can, like the ignore option -I, case 
> > insensitivity, etc. I thought that's what the external diff 
> capability 
> > is for, but it is not so.
> 
> I disagree.  Your statement is misleading when you say you 
> want the internal diff to do things like GNU diff can.
> 
> What you want to do _in fact_ is not only modify the diff 
> _output_, but the commit _input_.
> 
> And I am not so keen on such filters.  If I do not want to 
> commit,  I do not change it to begin with.  Yes, your 
> mysqldump is a special case here.  
> But it is special anyway, as it is not source code.

I don't understand how it is a benefit to have "git commit" and "git diff"
do different diff functions. It confuses me. A scenario: I keep doing git
diff's and it says there is no difference, but then git commit keeps telling
me there is.

While I understand it was built for the kernel and everybody likes the plain
text format, it is not a stretch of the imagination to have files that are
semantically identical but have byte-wise differences. OpenDocument files,
image files, XML, etc. Cases can be made either way that "the same" means
semantically or byte-wise. It's perfectly fine that the default is
byte-wise. But, if the user takes the time to build a custom diff, then
wouldn't it be reasonable to assume that user means for git to do semantic
comparisons for diff, commit and other git functions, even if there are
inconsequential byte-wise differences in the file itself?

Gerald.
