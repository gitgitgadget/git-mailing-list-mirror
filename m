From: Jakub Narebski <jnareb@gmail.com>
Subject: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 3 Jun 2008 03:14:02 +0200
Message-ID: <200806030314.03252.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 03:15:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3L7K-0007uP-10
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 03:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbYFCBOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 21:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbYFCBOG
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 21:14:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:38019 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbYFCBOF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 21:14:05 -0400
Received: by ug-out-1314.google.com with SMTP id h2so16684ugf.16
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 18:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=lnPw92dAplVo1URTb/XtifllWvVPP3Fu1/9Gi7/na+U=;
        b=FcDDQ1aX3OvbA7zteQ/xMtJbwiNQkpIKgU41PHfKqkHRB9FBGQAwwLYT63LCRzKDVs
         N9UTO44cdXhtyptcngDT05au5uft9bXtw3tfEt3f+Dik1wKu93XMSb1IR/FrYfneGTPV
         Z91BmXJnPhAbsYXwYbvoxdQD2nvEb7yS6nXxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=er1TTMpSDVrZA7TPC3oLGzSRBty891qVCiNQE5BtlXRhAZZQGqmXwDBOz2Yuj4HFYy
         m2usC/3TtM11L2WX4X9/f2W/9Njp7d0wFW25/PrL94MCxnv/1Pup49ceoHm7tL2hY1l9
         fq/oxDYM32DR49owmR+7Oi2CZeYgNoGcC0yu8=
Received: by 10.66.240.12 with SMTP id n12mr68522ugh.33.1212455643716;
        Mon, 02 Jun 2008 18:14:03 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.244.52])
        by mx.google.com with ESMTPS id g30sm8377906ugd.16.2008.06.02.18.14.01
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 18:14:02 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83608>

I think that octopus merge (merge with more than two parents/legs) is 
feature which is unique to git (isn't it?).  Do you remember perhaps 
why it was introduced?  What does it give, beside making it difficult 
to convert git repositories using this feature to others SCMs, for 
example for comparison:
  http://vcscompare.blogspot.com/2008/05/meet-candidates.html

TIA
-- 
Jakub Narebski
Poland
