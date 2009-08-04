From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH 0/5] Sparse checkout resurrection
Date: Tue, 4 Aug 2009 20:20:26 +0700
Message-ID: <fcaeb9bf0908040620n6a8292br5e62427bc60b0256@mail.gmail.com>
References: <1248850154-5469-1-git-send-email-pclouds@gmail.com> 
	<2729632a0907311418m6e60b1b6g9475f7668dec0192@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 04 15:20:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYJwk-00049E-QC
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 15:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494AbZHDNUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 09:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755470AbZHDNUq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 09:20:46 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:32055 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506AbZHDNUp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 09:20:45 -0400
Received: by an-out-0708.google.com with SMTP id d40so5223260and.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=B7hRQ5r4uZXI65hwmdAI9zHk2QfCNSqBGICQx5L27rA=;
        b=Nnlj4rBeicz+P2wK8BaDQyr/eZuroRKj1DSZybW6UWk/ifOHmFM5c+cCguhQNxdTv7
         S3SJXfIPJ8lG+L4fkkoxp1cSsqjedzNmwwvVW6Yc28jBY5Ysry7dfTJIbE0W1ZAb80jI
         pD72wSuQtZrs25sq7IHh3aok6HElTphwa/xFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=r6saHPqkH9RH78zZI5O+LsVJFCdkJ1FnJWvQOeOGqCL+cPVs5anEtl78QVBzG/CjDn
         KncdYO3ZBDDkV/+90qJnhuxt1AYWCwTCqztp1f2JLekW/FSYuWfCYl2dEbtCFTWZ03rd
         3mv1qCbzjjhYjycV7LOc1MaPPI1N7V+K8eKOE=
Received: by 10.100.173.20 with SMTP id v20mr8747503ane.44.1249392046115; Tue, 
	04 Aug 2009 06:20:46 -0700 (PDT)
In-Reply-To: <2729632a0907311418m6e60b1b6g9475f7668dec0192@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124787>

2009/8/1  <skillzero@gmail.com>:
> BTW...Is there a repository I can clone from that has these changes
> and possibly future enhancements? I checked
> <http://repo.or.cz/w/git/pclouds.git>, but I didn't see them.

No. This is far from usable. I think I'll make "git-shape-workdir" a
hook, put an example hook that should cover basic cases and repost.
-- 
Duy
