X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git-diff opens too many files?
Date: Mon, 20 Nov 2006 22:32:05 +0700
Message-ID: <fcaeb9bf0611200732y777868c5lb9d9061a4522de97@mail.gmail.com>
References: <fcaeb9bf0611200212s6ddb0518k24f85223acfed08b@mail.gmail.com>
	 <Pine.LNX.4.63.0611201620070.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 15:32:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mVOrArXwpumFmT9j64UifjsHKhQYJcU+hY748EaXJPR/jGI0gO2cZdhQAcT9cVRIBpzaxDVYka5CQ1stgH69rsmPSRt3/BCxE8u541ielSBI6cDtjutePNLch9THO/ZDUx19GYFNIzmAGNhDN04gVPe6dEG773WMHCGIuPAuVi4=
In-Reply-To: <Pine.LNX.4.63.0611201620070.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31917>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmB80-0008Th-Gr for gcvg-git@gmane.org; Mon, 20 Nov
 2006 16:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965916AbWKTPcI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 10:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965918AbWKTPcI
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 10:32:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:47823 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965916AbWKTPcH
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 10:32:07 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1212135ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 07:32:06 -0800 (PST)
Received: by 10.78.185.15 with SMTP id i15mr1426457huf.1164036725381; Mon, 20
 Nov 2006 07:32:05 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Mon, 20 Nov 2006 07:32:05 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On 11/20/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 20 Nov 2006, Nguyen Thai Ngoc Duy wrote:
>
> > I got this error in a quite big (in files) repository:
> > error: open("vnexpress.net/Suc-khoe/2001/04/3B9AF976"): Too many open
> > files in system
> > fatal: cannot hash vnexpress.net/Suc-khoe/2001/04/3B9AF976
> >
> > The repository contained about 67.000 files and probably all were modified.
> > git version 1.4.4.rc1.g2bba
>
> What was the command line? "git diff" really is a wrapper around different
> programs...

"git diff" from working directory with no argument. The real command is

git diff |LANG=C grep '^-'|LANG=C grep -v '^--'|LANG=C sort|LANG=C uniq -c

(I squeezed blank lines, so I wanted to check that it just did that,
nothing else)

> Ciao,
> Dscho
>
>


-- 
