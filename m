From: Andy Parkins <andyparkins@gmail.com>
Subject: sha-1 mismatch using command line sha1sum
Date: Tue, 16 Jan 2007 13:42:50 +0000
Message-ID: <200701161342.56431.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 16 14:43:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6oah-0008T3-5Q
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 14:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbXAPNnE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 08:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbXAPNnE
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 08:43:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:3840 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbXAPNnC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 08:43:02 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2404569nfa
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 05:43:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Kcp6tnDKiiSCWpHbn28AxS+B2V5LicCIcFxCqS5OVcFBm02eCE9B2cATzpIbHLO1jYUSFU8tyTpzIwG0mYdGKYOP62IbWlnTPHFlaGkzHoCg8hrm1hZIdC76/ipINHvbynW1LmhKPloR58qw8yWM8GPrwtKZaYG7prqDVB1Ncds=
Received: by 10.82.118.2 with SMTP id q2mr1106795buc.1168954979764;
        Tue, 16 Jan 2007 05:42:59 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id m1sm8623391uge.2007.01.16.05.42.58;
        Tue, 16 Jan 2007 05:42:58 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36936>

Hello,

I came across this message:

http://www.gelato.unsw.edu.au/archives/git/0504/0212.html

So I thought, "hey that's interesting, I'll try it".  I was surprised to find 
this:

$ sha1sum .git/objects/f4/b6c6b90fdce12d69e4ad80ff6082405ec8cfb8 
ac4c6f1d36d6e0341486789b32f86ae6f506df35  .git/objects/f4/b6c6b90fdce12d69e4ad80ff6082405ec8cfb8

This is in the latest git repository.

Is this correct, or should we all begin screaming and crying that our 
repositories are woefully corrupt? :-)



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
