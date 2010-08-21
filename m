From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 4/5] fmt-merge-msg: Remove deprecated --summary
 option
Date: Fri, 20 Aug 2010 23:04:21 -0500
Message-ID: <20100821040421.GB2636@burratino>
References: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
 <1282331702-5115-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 06:06:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmfLQ-0005ts-26
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 06:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168Ab0HUEGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 00:06:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35483 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab0HUEGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 00:06:05 -0400
Received: by gyd8 with SMTP id 8so1525620gyd.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 21:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bJeVR6CEoryB46Tn8B0+9hV2FzLT6OjnQaSL5B9B6fM=;
        b=qsj3spqWp91BX1a8/1Cuuj6Eo/SJ4GJ/1wBs6AXUzJP9tC2wr5ZIFOtIF+lzvDmXiX
         rU3KpcgH5Yj12MUyrAGecWbBpWFFc/k5DLujMT26URX6njbXUw5u39oAXu5JbkcgcZvw
         LIczW3z6ysbrw8qt5N1c5JnPjlFb65CdwF7ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UDZ89uTXNfSL0n1mfEFN9LtYxY7tZHIkYayxgWHrT1q1ykdxXLY+0IeFUcMtvBJvLC
         gNb2dC2Yac2bJbphVA4lSAurRviF6DRdJnnhnKlyjLWcX4ulVBXQuCgld9axdXJ8DQLD
         0DwWo8/+AzuBTACJATJ0NhMnz6xMombfoPckI=
Received: by 10.100.138.20 with SMTP id l20mr2652915and.10.1282363564016;
        Fri, 20 Aug 2010 21:06:04 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id k11sm5752978ani.10.2010.08.20.21.06.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 21:06:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282331702-5115-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154097>

Ramkumar Ramachandra wrote:

> Remove the deprecated --summary option

We stopped advertising it in v1.7.1-rc0~3^2, right?  That would make
this v1.8 or later material, I think.
