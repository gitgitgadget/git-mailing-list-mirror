From: "Dave Hanson" <drh@drhanson.net>
Subject: git-svn crashes with svn 1.4.4
Date: Fri, 15 Jun 2007 13:15:21 -0700
Message-ID: <9fb1551c0706151315u221feed1se61cc7689ba1f7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 22:15:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzICZ-0002jj-Tp
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 22:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbXFOUPW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 16:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbXFOUPW
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 16:15:22 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:48830 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbXFOUPV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 16:15:21 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1062748nzf
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 13:15:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=UrSG95ttDaMrdrN8W+s5IgJKFwRKS+SUN3Lsz8618T2M3rZESQXlhejE3k7zpdmh5+fVXPdNFhU2PqEFrSBpQ3/qq8IM2O4znygwLi4mQ1I7B8gAgzL4oZPVMY5L290CVDpV/5NwI4NcSS+0QwFF2dMuBz5Omk+52OKIBz0iWys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=pXVxXnQkUS7LA+uSGU4WinTwRH6YPjUsxypWowHZPl3+XWAdPR0r+td54TVFf+cu/A64OEtV1vnjq3HXDz9U6hS4LZpwvoQo+oicQlhQQBicKMIlsJ1A3vib+0bnYRPGSfqtJL7AHGMG2KaHCKW3qgtj/KOz3f4y1spY1dzFUnw=
Received: by 10.142.89.9 with SMTP id m9mr173679wfb.1181938521074;
        Fri, 15 Jun 2007 13:15:21 -0700 (PDT)
Received: by 10.143.10.21 with HTTP; Fri, 15 Jun 2007 13:15:21 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: a75ef0decea5d6d2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50277>

I just installed Subversion 1.4.4 on my Intel Mac Pro from
http://downloads.open.collab.net/binaries.html. After doing so,
git-svn dies with a bus error, in a perl library, I believe.

I rebuild git v1.5.2.1 and reinstalled. Same behavior. I suspect I
have a mismatch between git-svn and the perl swig bindings, but I have
yet been able to pinpoint the offender. Clues would be appreciated.
thanks,
dave h
