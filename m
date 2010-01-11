From: Leo Razoumov <slonik.az@gmail.com>
Subject: Re: How to check new commit availability without full fetch?
Date: Mon, 11 Jan 2010 11:22:21 -0500
Message-ID: <ee2a733e1001110822t1b04c1ccg9b6eb5489b69783d@mail.gmail.com>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
	 <alpine.LFD.2.00.1001101501520.10143@xanadu.home>
	 <7v8wc5itlc.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1001101556490.10143@xanadu.home>
	 <ee2a733e1001101736p2f395de6ka05044fe7cca624d@mail.gmail.com>
	 <alpine.LFD.2.00.1001102055070.10143@xanadu.home>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 17:22:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUN2I-0006d3-5D
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 17:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab0AKQWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 11:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500Ab0AKQWY
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 11:22:24 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:37187 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab0AKQWX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 11:22:23 -0500
Received: by ewy19 with SMTP id 19so14443580ewy.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 08:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Um45hOcjuviPJxAHNJZPezeTEQquA+YGENIlzwXh61c=;
        b=cCz6viowh2bl3noSRICG+mTMIK9lQY3GMqOCv277Js9eaumLLVGa3zL6a6HrMQic79
         PIET7jtk1TpDxoVgvjFULw691w/a8J3/zBnfFYJyXdF3bRINkXgRzHwUmWDBgRotXp1J
         KNAscGW2ZQEUz8x3cyfjU7Q72FHY/VzFWMZEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=Qbtj/uQ6Vddkxl73OACpus/TqTlmWcERInLRLnleMzXdtfbD19+8zt7+zyR9UDvecG
         LIcv8SrpvtZCeMJaqJuE2hFavLrQwwdhQ4weMrDiB1w1Ml6/xHh0gSc7ymK5BrheV5Bk
         TqUF3Or+rxlXFCYBNqyQzV/ekqxZuDXymDDuU=
Received: by 10.216.89.210 with SMTP id c60mr2589731wef.149.1263226941273; 
	Mon, 11 Jan 2010 08:22:21 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001102055070.10143@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136639>

On 2010-01-10, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> You still don't answer my question though.  Again, _why_ do you need to
>  know about remote commit availability without fetching them?
>

I use git to track almost all my data (code and otherwise) and spread
it between several computers. I end up with several local repos having
the same local branches. It happens once in a while that I fetch into
a given remote/foo from several local foo branches from different
machines and the operation fails. It happens because the commits have
not been yet consistently distributed among the repos. To do the
forensics and figure out who should update whom first I need a quick
and non-destructive way to fetch dry-run.

--Leo--
