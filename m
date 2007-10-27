From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [POSSIBLE BUG] 'git log' option --no-color adds bogus empty line
Date: Sat, 27 Oct 2007 12:01:31 +0200
Message-ID: <e5bfff550710270301j5b5bb946w3ab6dd89d0543171@mail.gmail.com>
References: <e5bfff550710270210g6d363b40of597c3160124fb85@mail.gmail.com>
	 <472306BA.5060409@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Gilger" <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Sat Oct 27 12:01:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IliUJ-0007GY-Ov
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 12:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbXJ0KBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 06:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbXJ0KBi
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 06:01:38 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:43981 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbXJ0KBh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 06:01:37 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1030962rvb
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RUFvtL6WxP6tUdzfbvrdlRV+dKvkJTcxaz+iMuoXfsg=;
        b=s1sWpwgiQqCCVKlgu078BhxKJ7ZtzUQwu7gidbD7ajsNCB7cx+W+yuwnharkeTHqd/832LlcnARgYhNyiPiWtW6MWY17DBuAQVBiWS3ZOxmKZoKiHEIE5uDWPDEhtCD4jZtiL4tTMbjZwlCl0iCerqftCtGHSnSv1eEJ0UjiouU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cgn9fKFeSO3y33kIkIa/ckcWeeL+Eug17H1pZdHqb3K0k6FTMPBPxMmJeOZ2mtuLroVjogbHsIBMCZfx7GvvZuAPRCD+GlSTH+9DIKACZAY+DuAzvscvvERPyCOk3pDR+0MwtOT+rXJO+QZJladLjI973+86CUCEiM84eY9bNOg=
Received: by 10.140.126.14 with SMTP id y14mr1947234rvc.1193479296832;
        Sat, 27 Oct 2007 03:01:36 -0700 (PDT)
Received: by 10.141.203.3 with HTTP; Sat, 27 Oct 2007 03:01:31 -0700 (PDT)
In-Reply-To: <472306BA.5060409@hackvalue.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62482>

On 10/27/07, Johannes Gilger <heipei@hackvalue.de> wrote:
> Marco Costalba wrote:
> > Form git tree:
> >
> > $ git log -n 1 8d863c98b2f9b0d37 | wc
> >       7      28     246
> >
> > $ git log --no-color -n 1 8d863c98b2f9b0d37 | wc
> >       8      28     247
> >
> > $ git --version
> > git version 1.5.3.2.124.g648db
>
> Hi,
>
> using git version 1.5.3.4.383.gd90a7 i can't confirm this, the two
> outputs are of the same length here.
>

Yes. With the latest git everything works as expected.

Sorry fo rthe noise!

Marco
