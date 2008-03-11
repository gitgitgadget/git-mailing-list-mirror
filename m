From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: Re: Solaris test failure for git-1.5.4.4 -- t0021-conversion.sh
Date: Tue, 11 Mar 2008 13:14:39 -0400
Message-ID: <8ec76080803111014w209e1ceep9baf6d5c8c7f6a20@mail.gmail.com>
References: <8ec76080803110533m14041aebhc779d117a5bb6112@mail.gmail.com>
	 <alpine.DEB.1.00.0803110954360.4428@alchemy.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Asheesh Laroia" <asheesh@asheesh.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 18:15:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ84R-00032e-2A
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 18:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbYCKROm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 13:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752193AbYCKROm
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 13:14:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:32768 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbYCKROl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 13:14:41 -0400
Received: by wr-out-0506.google.com with SMTP id 50so1429782wra.13
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Z+ei5xZhn/nCtQOS/AZfVzCJGvcTX6n4JCZ3F3v8Oas=;
        b=NTJoMQ/bkGpuOmbu7TFWbwsfO5766XWRCbKHkuYlLmbVa4I/b7Mrekjy2CsrwSpS52WPNIixlIUv1A1AT9vKepzBxPQ3b7zfIWTMVF1diUjBXenHgjyp24ZNXcFNn7bvmVS8CrAkMrx3jet2jMZKCdXpFAG44KfrHfeuxkDnmzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=w0XpedMSuSRECWqWS5cV+829QmsLcnGcy5ZD+iuW22GHzHEpT77YPnqnYM88SXT71LFRsLmIxwnjfd94SuP5XLozHhoqQ5wnVq4yWDeq2050nJsFv3o9wjxa5h00f20fQbmJyRXhX3jKwLSCk1nuXXW3J2qPw9z3hcudHLTmqVk=
Received: by 10.141.197.8 with SMTP id z8mr4452990rvp.285.1205255679581;
        Tue, 11 Mar 2008 10:14:39 -0700 (PDT)
Received: by 10.141.201.19 with HTTP; Tue, 11 Mar 2008 10:14:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0803110954360.4428@alchemy.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76881>

Thanks for the suggestion.  I found a few things in trash:

xs5-trd-p1.grn:warmstro> pwd
/home/warmstro/download/solaris/git-1.5.4.4/t/trash
xs5-trd-p1.grn:warmstro> cat rot13.sh
tr '[a-zA-Z]' '[n-za-mN-ZA-M]'
xs5-trd-p1.grn:warmstro> tr '[a-zA-Z]' '[n-za-mN-ZA-M]'
tr: Bad string.
xs5-trd-p1.grn:warmstro>

does that help, or do you need a bit more than that?

-Whit





On Tue, Mar 11, 2008 at 12:55 PM, Asheesh Laroia <asheesh@asheesh.org> wrote:
> On Tue, 11 Mar 2008, Whit Armstrong wrote:
>
>
> > xs5-trd-p1.grn:warmstro> sh t0021-conversion.sh -i -v
>
>  Try running this as "sh -x t0021-conversion.sh -i -v".  That will print
>  the exact commands run just before they are run, letting you figure
>  out what tr is complaining about.
>
>  -- Asheesh.
>
>  --
>  I know what "custody" [of the children] means.  "Get even."  That's all
>  custody means.  Get even with your old lady.
>                 -- Lenny Bruce
>
