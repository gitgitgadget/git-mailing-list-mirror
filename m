From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 13:22:31 +0000
Message-ID: <200701231322.32987.andyparkins@gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at> <200701222127.09601.johannes.sixt@telecom.at> <Pine.LNX.4.63.0701231227200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jan 23 14:22:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Lbl-0007vD-Bn
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 14:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbXAWNWi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 08:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbXAWNWi
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 08:22:38 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:26479 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965038AbXAWNWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 08:22:37 -0500
Received: by an-out-0708.google.com with SMTP id b33so597540ana
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 05:22:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lE2J0uzF1EhgFRMR6O/pBFyySPmRZn+FfUUQ/XEw+n274COu5/5MxFTP8IOcGBbgldaaxzBqsU4mtif1yk0Bd17E9Ur8cWP3uS3BwA39ZIW4ctgRXO06nZmiT+g5Dl4CNlJrlc8Yg4sNNyfegbo3t3HNZglElKtv9b+urEwbm28=
Received: by 10.49.57.1 with SMTP id j1mr1059320nfk.1169558555870;
        Tue, 23 Jan 2007 05:22:35 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id g1sm2506002nfe.2007.01.23.05.22.34;
        Tue, 23 Jan 2007 05:22:35 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0701231227200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37514>

On Tuesday 2007 January 23 11:32, Johannes Schindelin wrote:

> Maybe we have to go the other way round, just as POSIX git does: instead
> of spawning the pager, we should _beginthread() the actual work, and
> execl() the pager.

What about just forgetting paged output under Windows?  It's been a while, but 
the only decent one that I ever found was LIST.COM, and that's probably 
vanished now.

I haven't used Windows in a while, are pipes still as awful as they were?  
That is to say they cheated and redirected output to a temporary file then 
redirected that file to the input of the second process.  The upshot of which 
was you had to have the whole pipe complete before you could view the first 
page of output.

I can well imagine that in Windows I would find the paged output more painful 
than useful.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
