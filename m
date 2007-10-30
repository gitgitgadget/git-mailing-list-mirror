From: "Mike Snitzer" <snitzer@gmail.com>
Subject: Re: Problem with git-cvsimport
Date: Tue, 30 Oct 2007 16:06:09 -0400
Message-ID: <170fa0d20710301306o6b3798f9k72615eb811d871f2@mail.gmail.com>
References: <470B491F.9020306@jentro.com>
	 <200710091447.50501.wielemak@science.uva.nl>
	 <470B8049.1090308@samba.org>
	 <47065A5D-D170-4D11-A802-85376F97F8D2@orakel.ntnu.no>
	 <470C3A3A.2070809@alum.mit.edu>
	 <F1176033-1C6E-43F3-9F47-3BDD5EC88A14@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eyvind Bernhardsen" <eyvind-git-list@orakel.ntnu.no>,
	"Thomas Pasch" <thomas.pasch@jentro.com>, git@vger.kernel.org,
	"Jan Wielemaker" <wielemak@science.uva.nl>,
	"Gerald (Jerry) Carter" <jerry@samba.org>,
	dev <dev@cvs2svn.tigris.org>
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 30 21:07:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImxMc-0006Cc-5a
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 21:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbXJ3UGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 16:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756098AbXJ3UGN
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 16:06:13 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:51470 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158AbXJ3UGL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 16:06:11 -0400
Received: by an-out-0708.google.com with SMTP id b36so287977ana
        for <git@vger.kernel.org>; Tue, 30 Oct 2007 13:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=J1NFVK3F3H/UUrA3W3mwU6Ezrkx2kwI3M8yW6n2TrMY=;
        b=gX0548GJFqo/dgR+PVqwxvuMY4m7MV/WKXSgCP8I3poydeJW1Llw1u2Z0cFWh7NcHbF4BM/dG713vvz5ImOcopA0/5dRX+84//iLWF+YoSRPC57tD34UNbKv508NKCna/lR0jdEjtoBmJx6/P0uBLM9I6sqBUchtpn27ICFOxa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GyumMqJaKxbZCPfcT0XuMaBniDCId4zh6rg5MNfewoDllcPvvZ4D0epyeobwmCB592y3xAVhBHB3pm97v6YIFdKUFJdzlUmcM2xDOYIAmPHFKz3k2kuj/jIINzL/Rpu1h6gs2jGpGDqZgvAb4dfxm1dGPzTWEuBTp9N0ajThKfM=
Received: by 10.143.33.19 with SMTP id l19mr1899109wfj.1193774769449;
        Tue, 30 Oct 2007 13:06:09 -0700 (PDT)
Received: by 10.142.222.3 with HTTP; Tue, 30 Oct 2007 13:06:09 -0700 (PDT)
In-Reply-To: <F1176033-1C6E-43F3-9F47-3BDD5EC88A14@orakel.ntnu.no>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62748>

On 10/10/07, Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no> wrote:
...
>
> Thanks for making cvs2svn the best CVS-to-git conversion tool :)  Now
> if it would only support incremental importing...

Michael,

I second this question: is there any chance incremental importing will
be implemented in cvs2svn?

I've not used cvs2svn much and when I did it was for svn not git; but
given that git-cvsimport is known to mess up your git repo (as Eyvind
pointed out earlier) there doesn't appear to be any reliable tools to
allow for incrementally importing from cvs to git.

Are others using a tool for reliably importing from cvs to git?
