From: sean <seanlkml@sympatico.ca>
Subject: Re: Selecting the minor revs
Date: Mon, 27 Mar 2006 19:02:01 -0500
Message-ID: <BAYC1-PASMTP12827905B389678EB07BDAAED30@CEZ.ICE>
References: <0e6701c651f9$2605aad0$a100a8c0@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 02:05:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO1hi-0004Ru-FG
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 02:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWC1AEk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 19:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWC1AEk
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 19:04:40 -0500
Received: from bayc1-pasmtp12.bayc1.hotmail.com ([65.54.191.172]:41036 "EHLO
	BAYC1-PASMTP12.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932108AbWC1AEj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 19:04:39 -0500
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP12.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 27 Mar 2006 16:10:02 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 14858644C28;
	Mon, 27 Mar 2006 19:04:38 -0500 (EST)
To: "Greg Lee" <glee@swspec.com>
Message-Id: <20060327190201.60d26d5f.seanlkml@sympatico.ca>
In-Reply-To: <0e6701c651f9$2605aad0$a100a8c0@casabyte.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 28 Mar 2006 00:10:03.0218 (UTC) FILETIME=[F5FB8320:01C651FB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 27 Mar 2006 18:49:53 -0500
"Greg Lee" <glee@swspec.com> wrote:

> How do I select one of the "minor" bug fix revs using git?  For example I want to do a git
> bisect between 2.6.15.6 and 2.6.16 but I cannot determine what the naming convention is
> for "2.6.15.6".  I've tried "v2.6.15.6" and "v2.6.15-6".
>  
> Please cc any responses.


If you're interested in the stable-series releases of the kernel, unfortunately they're
not in the git repository.   On the otherhand if you're actually talking about the 
release candidates that Linus puts out before each new major version, the format is  
v2.6.16-rc2, v2.6.15-rc3  etc..

Sean
