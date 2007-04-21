From: John Wiegley <jwiegley@gmail.com>
Subject: Question about removing old objects
Date: Sat, 21 Apr 2007 16:55:26 -0600
Message-ID: <A2948362-ADC0-4F86-92BB-D942E9EF0AAC@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 00:55:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfOUX-00058J-Iw
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 00:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbXDUWzg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 18:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbXDUWzg
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 18:55:36 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:4259 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687AbXDUWzf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 18:55:35 -0400
Received: by an-out-0708.google.com with SMTP id b33so1368176ana
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 15:55:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer;
        b=HV/gl0Y13S7THjgTstHavab3NeEiOzeHtjl11eQ7XaYKNwxtJTdOdom58WYj167cx2qd/yzLPdSW54l76N/H5lvaCvwEwi80MBcy0SD1km0kMlEtViDR5W2Dju+4kfrMZ3aTrgCPAGd/OpDZUYMDsx4ZCJXpu+go9KpPSvsR5/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer;
        b=EGgjiijvoTCFiBHE/KEiq+VY18wRGPnHgLOsnsSb/b7a0Fj1ZarhelLh12KSepg7NDo25OVFgrAI6Z2h0JBYfAOuDNXJmhpsZ1QjJ0tubiyaJqfSOUqhP2hUNFevnwe3LraNT3uW88wjLyG75kCX4SfapojqYasSZO1J70kNLBc=
Received: by 10.100.141.13 with SMTP id o13mr2622021and.1177196134685;
        Sat, 21 Apr 2007 15:55:34 -0700 (PDT)
Received: from ?192.168.0.3? ( [71.211.51.30])
        by mx.google.com with ESMTP id c37sm6916880ana.2007.04.21.15.55.33;
        Sat, 21 Apr 2007 15:55:33 -0700 (PDT)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45196>

Hello, I am thinking of using git to track my home directory.   
However, rather than keeping old history around forever, I'd like to  
physically remove old objects after X days -- in essence, causing the  
repository to appear as if it had begun life X days ago.  Is there a  
git command to do this?

Thanks, John
