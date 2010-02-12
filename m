From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Commit annotations (editable commit messages)
Date: Fri, 12 Feb 2010 17:55:46 -0500
Message-ID: <32541b131002121455s46bfe15aie484e9be484259c6@mail.gmail.com>
References: <op.u71cw50km02fvl@cybershadow.mshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Vladimir Panteleev <thecybershadow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 23:56:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng4Qs-0007RS-D0
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 23:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab0BLW4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 17:56:12 -0500
Received: from mail-yw0-f179.google.com ([209.85.211.179]:48687 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab0BLW4I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 17:56:08 -0500
Received: by ywh9 with SMTP id 9so2979096ywh.19
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 14:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=/T4UP0srCz1yC8TqekJ96NaA1vJxnuqa9Qc8sF3nBts=;
        b=YgDjZGIC3Xsi66lSr/oR0E6AUCWpnTsWtCLRBnyXGWy+dmjo3JSvDgil+DpAUbaUXX
         lkc95+GKMPjnQAQTMRPk3AQFKHIIRy5X6JZ/Yh+jSfjYoR//jm4xovVHkNqRh82FOT0i
         E4UeIkuXFTtRzA3alt6vxofYDfKOIemzOoe1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lwF1EGUPD/K5ZCw42EkFJLZDafHJx7fGfTKpaid/mN3TJewU8J3Bmm74iZ4jvPRhst
         MUCF6nPn9pDn0boMdtAICEe7OBMUxXtddrzqVBnemu4jRGcoDVE8mtRS9KB9F1sapxCS
         k/QYz2VfJ2ZAb0XJW4ljb8rWmHvUa51im4k8w=
Received: by 10.150.120.42 with SMTP id s42mr3324839ybc.91.1266015366127; Fri, 
	12 Feb 2010 14:56:06 -0800 (PST)
In-Reply-To: <op.u71cw50km02fvl@cybershadow.mshome.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139762>

2010/2/12 Vladimir Panteleev <thecybershadow@gmail.com>:
> You have to agree, being able to edit commit messages in a controlled
> (logged/versioned) fashion is pretty useful. Aside mundane corrections such
> as typos or undocumented changes, it makes it possible to document bugs and
> other unintended changes in the commit that they were introduced. This is
> possible in centralized VCSes and is implemented in Subversion (controlled
> by a server-side hook).

It sounds like you want to read about a new feature called git-notes:
http://www.kernel.org/pub/software/scm/git/docs/git-notes.html

Have fun,

Avery
