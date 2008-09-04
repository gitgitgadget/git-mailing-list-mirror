From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: Directory renames without breaking git log.
Date: Wed, 3 Sep 2008 17:16:24 -0700
Message-ID: <905315640809031716j7d74d7a6m51b434f62b011135@mail.gmail.com>
References: <200809032338.35359.kai@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kai Blin" <kai@samba.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 02:17:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb2XU-0004n4-UB
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 02:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbYIDAQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 20:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbYIDAQ0
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 20:16:26 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:45508 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbYIDAQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 20:16:26 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1496282eyi.37
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 17:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=XtAyt4/kKHTOuRIe0Ijhsxj49e7cVjtGGBZSrD18FPo=;
        b=Qsz1ij7+729ddQU6n14FIu34kacnBxO85xUz07pYXyIqC8+wfh/hOhVjxIQ2PQwuW8
         njLz7MW6uuRiJ5tVyjafqnR6TxPfvtbxMgGJxPPtGaivLLXGJlHoy0LoMa+QelrWckDx
         q8UPykhurhtnpHkumBKm6gi2DURUjoYREL/jg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=aAlpobuRAAqoGt6LbCHTKfY2HwVy7uoRlSY1FRNyJ13S95ShtlvF6WhurgN8PA+Ren
         +pCE3TlFp9cx+5LabkysOc0Tj8lUyPdrUaN2iP1YasY66t2evDexf8xumdWvBcMFTsUO
         DAsSTxvAw9lliisml0SR9eqiHnfvZPvcFQBZU=
Received: by 10.210.18.18 with SMTP id 18mr10918870ebr.95.1220487384318;
        Wed, 03 Sep 2008 17:16:24 -0700 (PDT)
Received: by 10.210.28.18 with HTTP; Wed, 3 Sep 2008 17:16:24 -0700 (PDT)
In-Reply-To: <200809032338.35359.kai@samba.org>
Content-Disposition: inline
X-Google-Sender-Auth: f5422660df6000e0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94874>

On Wed, Sep 3, 2008 at 2:38 PM, Kai Blin <kai@samba.org> wrote:
> Hi folks,
>
> in an effort to make Samba development easier, we're trying to merge the
> Samba3 and Samba4 branches into a single branch. In order to do so, we need
> to rename the "source" directories both Samba 3 and Samba 4 have (we're
> planning to use source3 and source4).
>
> Unfortunately, the directories are big enough that git log stops to track the
> renamed files, so e.g. git log ./samba3 does not show the samba3 history. The
> history is not lost, of course, but it's way less intuitive to get it.

You can try setting diff.renamelimit to 0 in your ~/.gitconfig.  See
Linus's email here for a similar situation in the kernel:
http://lwn.net/Articles/292948/

Thanks,
Tarmigan
