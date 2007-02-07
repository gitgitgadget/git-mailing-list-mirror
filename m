From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Deprecation/Removal schedule
Date: Wed, 7 Feb 2007 09:33:20 +0100
Message-ID: <200702070933.21804.jnareb@gmail.com>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net> <7vsldibfva.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Mark Wooding <mdw@distorted.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 09:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEiDq-0007ff-Ej
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 09:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbXBGIbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 03:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbXBGIbz
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 03:31:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:3754 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030488AbXBGIby (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 03:31:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so120635uga
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 00:31:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oeDeLxrU2JfRVskXqhrsZ/KY1BP3OerMxA/qMi3A84d52laCkmaPAJU+3NubxZyb2LJo1filDVoToDbONOeJ8lB1PJUooEcEawUR5No9vUDE2kmJBpMLiMooAey5QUrSZiGA1P+fFG7DXcKQ+OCdRNAy+dBBf3u4UCYH4LHX0MQ=
Received: by 10.82.165.1 with SMTP id n1mr5036061bue.1170837110888;
        Wed, 07 Feb 2007 00:31:50 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id j2sm641748ugf.2007.02.07.00.31.49;
        Wed, 07 Feb 2007 00:31:50 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vsldibfva.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38895>

Junio C Hamano wrote:

> In 1.5.0, you will still see git-resolve and git-diff-stages,
> but they will be removed by 1.5.1.

Well, it is not as if we cannot obtain equivalent of git-diff-stages
without this command. Stages are <ours>, <theirs> and <ancestor>
(git-merge-base <ours> <theirs>) so I think we can use git-diff-tree
with appropriate arguments...

-- 
Jakub Narebski
Poland
