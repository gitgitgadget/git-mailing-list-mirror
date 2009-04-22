From: Lachlan Deck <lachlan.deck@gmail.com>
Subject: git-svn init/fetch: wow that's slow
Date: Wed, 22 Apr 2009 17:40:34 +1000
Message-ID: <E26B8975-74D3-4F01-A9D9-DAAB96C8FC85@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 09:42:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwX5z-0003yh-BU
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 09:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbZDVHkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 03:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbZDVHkl
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 03:40:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:48901 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbZDVHkk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 03:40:40 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2786379rvb.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 00:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=H2jXyEH9N9h4umsLY73nOASjA87Gfj4dNKaGNwmB3+8=;
        b=etdG2E4pGoBEioDnPVnt6q4A2kSnGqRr6o9l0G6/n4nzrbbCXOcyje/+gqmhan+Bo7
         i9a4rAtfBqT5zhiSpz1fu8obiyPubH9TqhTLyFMx+6KZxXScC9TI6kHFNWW2FtNlqSk9
         85h2cblnmlyvNmo2BtRxPx1mf9rf7XY5zgVnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=PoYeMIqNrqrAPU45pegIHE1XcJFXW93ruqVy0ygfW9mT0SCUSFUXNLHBN5w9XLADmW
         WyeN3S/THGw/Lpwk0prSbfGZoGb8ikcRkbPaYiq3LeKK4tdu9YRfT1jT2VhOSL0JZGDc
         0Pw7w9n0d2z1IqxoQpUQffIl8REmZmBMdUX1I=
Received: by 10.142.103.2 with SMTP id a2mr1572207wfc.88.1240386039900;
        Wed, 22 Apr 2009 00:40:39 -0700 (PDT)
Received: from ?10.0.1.200? (208.198.233.220.exetel.com.au [220.233.198.208])
        by mx.google.com with ESMTPS id 29sm4462800wfg.33.2009.04.22.00.40.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Apr 2009 00:40:39 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117179>

Hi there,

I've just finished checking out a project that has some 5700 odd  
commits (with some 15 branches, and 40-50 tags) and it's taken 4 days  
to complete! Woah - that was testing my patience :-)

Okay, so I'm using git 1.6.2. I assume this is all a 'known issue'.  
Has there been any work / plans towards improving this?
Thanks.

with regards,
--

Lachlan Deck
