From: E R <pc88mxer@gmail.com>
Subject: adding files in .git?
Date: Mon, 16 Mar 2009 10:14:58 -0500
Message-ID: <3a69fa7c0903160814u42fbb461qf03a37176546357d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 16:16:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjEYO-0006kc-DB
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 16:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbZCPPPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 11:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbZCPPPE
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 11:15:04 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:36103 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbZCPPPB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 11:15:01 -0400
Received: by qw-out-2122.google.com with SMTP id 5so2600423qwi.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=bCZO4jIejaCwaHBbHv/YS1vWDg9lh3Etx+BM7eEQTyY=;
        b=c6QxQoW2TOgHgp8hpR9+FVnTOEI8c8OXcCV2AmceJRKa61uHMj4MzdMo+gpW+H3nf6
         Q8MYY+TiKNWNSuujTo5ShAFKHy+/n/SG7BlBPBCMFzml/G5++Sjsx8OsGDdStvbaV20s
         VGw5bTBPffvavQ5mQXqkYg4jha9l+ifA4qKo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ew6LAMkz8i5Idxa9qOCY8iqL1mZv6D/it7mgnKEJtPa5eiBIBBEFu/eGbssG/lV4tx
         Jg0Y9fC0CkM/HSjmCgyBrqdoUvLzgic1G4KpxbUmW+pTY8SntBjPPGho2If4OR/FFoaC
         CKYqDZsy2k43y7qxU9Qbgwwz+oYLfP7ZcKgNY=
Received: by 10.220.98.16 with SMTP id o16mr1409701vcn.84.1237216498276; Mon, 
	16 Mar 2009 08:14:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113333>

I'd like to add a "short description" attribute to my .git repository.
This would be used by my bash prompt setting function in creating the
PS1 string. How would you recommend that this be implemented?

My ideas are:

1) Use another file in .git similar to the "description" file (such as
.git/short-description)
2) Use a setting in the .git/config file.

Any comments on the advantages/disadvantages of these approaches? Or
is there yet another better way?

Thanks,

ER
