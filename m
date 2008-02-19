From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: Re: Solaris test failure -- FAIL 61: invalid bool (set)
Date: Tue, 19 Feb 2008 18:17:42 -0500
Message-ID: <8ec76080802191517k5f070d45l497063d93e080272@mail.gmail.com>
References: <8ec76080802191322t2417ea48y1537011f1031dff8@mail.gmail.com>
	 <alpine.LSU.1.00.0802192220440.7826@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 00:18:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRbjC-0003Ai-Jb
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 00:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbYBSXRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 18:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbYBSXRr
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 18:17:47 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:62227 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbYBSXRq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 18:17:46 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1920622wxd.4
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 15:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9ij3VHq8gejkMhKTTCW3ysfKujTYSm8dvajsdIoPkZY=;
        b=HmTQUkK/oXX/yuhqWg+ewUp6iT4B15OGx5yQXtkEBG/ifyseSskGcPbEob6bEEvnoH8D8wr1bLic4X5e2ae1yDHCvAhkEsBrNrjhJAehqF1ZsUljLdxm9cU4PKdYUAFbNos/ufbGO9ctvaWdimuqcLSLj00klr9ZSQDUCcr7DrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QZ5ztUmAmTXvvLC4Rcd9MboXlXJOfj/ycO/iI4Pgh8/7NJ973Zuj+pxMKcWj80retSU15eFE7XhNE+9rUtHbjfAk7W/RjDdXnRW9RRvxgSKAN8ZNqOu78OLtf59qUNQF3EtZs20x8k5P7RaFIdKKVSPQEFDqmyOSGnbTPgcxKo8=
Received: by 10.141.75.6 with SMTP id c6mr5124730rvl.272.1203463062693;
        Tue, 19 Feb 2008 15:17:42 -0800 (PST)
Received: by 10.141.195.19 with HTTP; Tue, 19 Feb 2008 15:17:42 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802192220440.7826@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74472>

Yes, it's git-1.5.4.2.  Sorry for the omission.

output from  $ sh t1300-repo-config.sh -i -v (had to use bash instead
of sh, hope that's ok):

*   ok 60: invalid bool (--get)

* expecting failure:

        git config --bool bool.nobool foobar
t1300-repo-config.sh: line -176: 18181 Segmentation Fault      (core
dumped) git config --bool bool.nobool foobar
* FAIL 61: invalid bool (set)


                git config --bool bool.nobool foobar
xs5-trd-p1.grn:warmstro>

Thanks,
Whit


On Feb 19, 2008 5:21 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 19 Feb 2008, Whit Armstrong wrote:
>
> > Does anyone have experience with this test failure in t1300-repo-config.sh:
> >
> > * FAIL 61: invalid bool (set)
> >
> >
> >                 git config --bool bool.nobool foobar
> > *   ok 62: set --bool
> >
> > * failed 1 among 70 test(s)
>
> That is not very instructive.  Can you call the test with
>
>         $ sh t1300-repo-config.sh -i -v
>
> ?
>
> > make[1]: Leaving directory `/home/warmstro/download/git-1.5.4.2/t'
>
> Ah, I guess it is 1.5.4.2.
>
> Ciao,
> Dscho
>
>
