From: Ori Avtalion <ori@avtalion.name>
Subject: git-blame missing output format documentation
Date: Thu, 13 Aug 2009 15:18:11 +0300
Message-ID: <4A840483.9090402@avtalion.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 14:18:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbZGA-0005y5-SI
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 14:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbZHMMSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 08:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbZHMMSM
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 08:18:12 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:65226 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbZHMMSM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 08:18:12 -0400
Received: by bwz22 with SMTP id 22so543721bwz.18
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 05:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=YYBRsJAmfSDhTPZDgxoIM0gUa5yze10wf88CrfJ8WOc=;
        b=g75jnX/h37MnCrbpSeDP8AfE/U0gbhp/ZhFGVfyjGnuyDdyq6HNewz5r9QK5ynpG5C
         As0UU7SqRV+l58UsqcdqF0VgyUlkPfOnAJ5cps812aDAM7o3vLidrRfyWCVtjhHCm6kH
         RNxkU9OGiv5hVMOp3GQnluoRCGwUzqdOeaaJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=qvzyZihm2O4QXLzjI9a6dMDSq1Pt4i0j3+BFk832J/gDeCDvd7u0FlMvdXmW+4uuzh
         NMSkiN8Q8PACz27QpFoTMS5XvjYsjF/nQrPsndxCupbKg9RZ7dBQdbSAIAi82rj+lMhU
         E+QLnSUubPWx9ZXQctPTycIGFn1xXX4acUx4A=
Received: by 10.103.50.32 with SMTP id c32mr349791muk.1.1250165891857;
        Thu, 13 Aug 2009 05:18:11 -0700 (PDT)
Received: from ?192.168.1.55? (bzq-79-179-35-131.red.bezeqint.net [79.179.35.131])
        by mx.google.com with ESMTPS id t10sm934573muh.30.2009.08.13.05.18.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 05:18:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.1.3pre) Gecko/20090811 Shredder/3.0b4pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125808>

Hi,

"git blame" prefixes boundary commit tree-ish's with ^.
This doesn't seem to be documented in the git-blame manpage.

Is it a convention used elsewhere, that it can go unmentioned?

Also, the manpage doesn't describe the format of the regualr, 
non-porcelain, output.
Doesn't it deserve its own section?

The only non-obvious parts to me  are the the boundary commit notation, 
mentioned above, and the filename in the second column.
