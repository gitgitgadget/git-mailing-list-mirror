From: "Changsheng Jiang" <jiangzuoyan@gmail.com>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git reset --hard"
Date: Thu, 11 Sep 2008 10:14:38 +0800
Message-ID: <eafc0afe0809101914lff5b23ehaf625d702fbd9b5d@mail.gmail.com>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>
	 <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 04:16:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdbix-0001V6-4u
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 04:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbYIKCOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 22:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbYIKCOk
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 22:14:40 -0400
Received: from ti-out-0910.google.com ([209.85.142.185]:53913 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbYIKCOk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 22:14:40 -0400
Received: by ti-out-0910.google.com with SMTP id b6so58859tic.23
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 19:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fR9CmpaW5Q0Zl72q+619IiWlRU4yeALrt40RVNGl974=;
        b=u+9wH/bQF1A+dF0R2tXF1cCk+UXsvziztMMaSKOA8NAOMYvGgIRuJttJMRN+xBF0XJ
         J7hbrX4AIYdeQDgNNOm4eE3wAxurM7BnUkIJqhKyBRdVSx+OOvp/4GNhiiiVMVKNus1K
         n38SpRea4/TSTBWSKjZyJ1SRcR+RSFJ8AMZMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=x/Q/8iKTQPgmNE6KKIUI2R+rGLaMTBlI3dBKNp4uA78cxAlhf+9MhUIAy+5h4jIrDh
         wD4q+/5l/Ff5duDCfERhF5nMF3/pATXwYDtOdLgqjQX14a2rzsw8T6jnT2suqnEYlfZ5
         InJrGMxfoIPmRRAV/ctLLf6uhOOFgzn/eS/RY=
Received: by 10.110.50.19 with SMTP id x19mr2543201tix.36.1221099278388;
        Wed, 10 Sep 2008 19:14:38 -0700 (PDT)
Received: by 10.110.37.16 with HTTP; Wed, 10 Sep 2008 19:14:38 -0700 (PDT)
In-Reply-To: <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95573>

I think the current behavior is better than you described. If you want
to ignore some files, you can added it to the exclude file. All files
not excluded in the repo directory is maintained by git.
