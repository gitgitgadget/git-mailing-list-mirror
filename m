From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: can't push to ransom ssh port ?
Date: Fri, 4 Jul 2008 09:33:09 -0400
Message-ID: <6dbd4d000807040633l6210e0cdtf37293ba44a52374@mail.gmail.com>
References: <912ec82a0807040628k14c8acd1ree9d82b68f69e080@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Neshama Parhoti" <pneshama@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 15:34:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KElQS-0002ER-9p
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 15:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbYGDNdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 09:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbYGDNdM
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 09:33:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:16279 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbYGDNdL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 09:33:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so463086fgg.17
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 06:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KVsRiCRpVICQof6nHRmBbyMccbV5Qi0d8x5bdxIdrTo=;
        b=D37xsZb0lz7DuXtsYqMXLJmjhQKKQqAnoD/kqpQiORNqPcCzrutq8y3dlpnwYanLq2
         Yev/Yk9SbhPl+ykH8OGeexWZTt+m30dr4xhn0JaiGSVElx2nN3FJ2u2gjULWUQvhF6t1
         XRkHXAOGXoivo3aepmqCHdTTVtdKX74a4OLhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=owobWSyi3o0lHkvDKPFfqMMo/6pwgoRAMmrO4cQ3NKr8KdS5jEKsqKS66UxJSgUxL5
         PNoFBXhlCI6kn0OOrZQGwya218NN4UBzTOfcchE+18HGS2fAFdvuOFI9wPUnYsoMCsKp
         jeoDvipERGHeFpZ/MD2fSkoZIIvmL7fZXhZho=
Received: by 10.86.29.19 with SMTP id c19mr817093fgc.28.1215178389556;
        Fri, 04 Jul 2008 06:33:09 -0700 (PDT)
Received: by 10.86.30.2 with HTTP; Fri, 4 Jul 2008 06:33:09 -0700 (PDT)
In-Reply-To: <912ec82a0807040628k14c8acd1ree9d82b68f69e080@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87388>

On Fri, Jul 4, 2008 at 09:28, Neshama Parhoti <pneshama@gmail.com> wrote:
> Is there a way to tell git to connect to a random port X ?

>From the man page for git-push (git push --help):

   One of the following notations can be used to name the remote repository:

   ....
   o ssh://[user@]host.xz[:port]/path/to/repo.git/

-- 
                              Denis
