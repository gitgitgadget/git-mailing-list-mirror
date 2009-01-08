From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: collapsing commits with rebase
Date: Thu, 8 Jan 2009 20:19:16 +1030
Message-ID: <93c3eada0901080149m3c349e6bx33b58d653fd43b48@mail.gmail.com>
References: <93c3eada0901071608r190a723bma502b68c4ab81a08@mail.gmail.com>
	 <200901072011.37299.bss@iguanasuicide.net>
	 <20090108023224.GU21154@genesis.frugalware.org>
	 <200901072039.12631.bss@iguanasuicide.net>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Thu Jan 08 10:51:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKrXk-0008SI-53
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 10:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758794AbZAHJtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 04:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758792AbZAHJtS
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 04:49:18 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:5991 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716AbZAHJtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 04:49:17 -0500
Received: by rv-out-0506.google.com with SMTP id k40so8318404rvb.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 01:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=z9bVLTS/9shCjJm+kc7ymGREq6T5D7lDBZlEaxCPlYg=;
        b=fYHqPGif411cCHi2WUD2V0FtWJPB1SSpnX4YK89mZBpoWXUMJF4H0sFXNckJO9Mh6X
         ClxIO3pB6uZiosf00SyJVugItbvq86zXz+HGAC+wod0Y5MbAya0u7uO+T9FxdjdhilgW
         mNd+mn0M1seCjumlnFTWaxvbURdvLdSZKmwtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=sySD36owuzVp3SLzqovW1pe8Hn0Ci8+jJFJpxK4hNy8SKmaGnPcHYC8MoErdkTfObS
         DCkZ6fww9/WYLBDNDlwAENv9QFRKjMosDM5L2bowRpOJE90uW0HL7XDlvy/BFUOQXPHi
         E+CYX1aISJhtV7pRUjWxKsDMFrHxuMwD4ToS8=
Received: by 10.141.197.21 with SMTP id z21mr12021809rvp.267.1231408156440;
        Thu, 08 Jan 2009 01:49:16 -0800 (PST)
Received: by 10.140.136.16 with HTTP; Thu, 8 Jan 2009 01:49:16 -0800 (PST)
In-Reply-To: <200901072039.12631.bss@iguanasuicide.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104910>

On 1/8/09, Boyd Stephen Smith Jr. <bss@iguanasuicide.net> wrote:
> On Wednesday 2009 January 07 20:32:24 Miklos Vajna wrote:
>  >On Wed, Jan 07, 2009 at 08:11:32PM -0600, "Boyd Stephen Smith Jr."
>  <bss@iguanasuicide.net> wrote:
>  >> git merge -s sha(D)
>  >
>  >You probably mean --squash here, -s stands for --strategy - and I *hope*
>  >you don't have git-sha(D) in your PATH, as a custom merge strategy. ;-)
>

Many thanks, now I have plenty of ways to think about!

Cheers,
Geoff.
