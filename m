From: Caleb Cushing <xenoterracide@gmail.com>
Subject: gmail screws up patches looking for workable workaround
Date: Fri, 13 Feb 2009 12:09:47 -0500
Message-ID: <81bfc67a0902130909i154a7c2epeff98347985c3fb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Dan Robbins <drobbins@funtoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 18:11:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY1ZN-0002vo-Rm
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 18:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbZBMRJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 12:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbZBMRJu
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 12:09:50 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:34596 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbZBMRJt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 12:09:49 -0500
Received: by qw-out-2122.google.com with SMTP id 5so688201qwi.37
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 09:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=aZlyX79I1lNNcHuVNq1n0PW3CR1VtaGzXXBq+Hb4bwc=;
        b=KFdPWAEdPoIcA8eEUwgi5BJwaPp3cwZt8+stSK8DpYbjgqEPmdV0qrt4fwrAmztsDp
         5/q9bZ+zErNFGFOJZEKjdNyDPdKkeUlOwcdw0tc3vfcKTqRQcW02w4/v8LGnn+PVmkL0
         JqMZbjn1510Zl6NtfYrNHq3Zbv76wZFBA8ygI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=RhpYeIarjRbsNWCzsaMx4cx7xG4wxvkFHa5V+3QS5V2lhEsem1gyZC9NEVf10E0i5M
         NDwl8xuxp2uBpt+vTlPrciIdR8pOwSGiR5tG79JFAuFxGS6+HYYG2/bgqbFeWVBPlPST
         Gu6fSwoFN4iYqs0YM5nzYzSxJgMWT65sEvMwI=
Received: by 10.229.82.79 with SMTP id a15mr630936qcl.57.1234544987742; Fri, 
	13 Feb 2009 09:09:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109760>

I've followed all the steps in the git Submitting patches guide. In
fact it works fine for any patch where all lines are less than 80?
chars. however, some of the patches store sha256 hashes (and the like)
and have really long lines and gmail word wraps them.

I've tried submitting patches as follows.

git format-patch -1 -M --stdout | git imap-send

git format-patch -1 -M --stdout --attach | git imap-send

git format-patch -1 -M --stdout --inline | git imap-send


we know the first corrupts the patches. but what I can't figure out is
why the next 2 don't work on the receiving end. The comment was.


git am -3 -i, when I choose [v]iew patch, I get a binary output.


I'm trying to figure out how I can submit patches via gmail for
someone that uses git am. what is being done wrong?

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
