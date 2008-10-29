From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Pull request for sub-tree merge into /contrib/gitstats
Date: Thu, 30 Oct 2008 00:39:36 +0100
Message-ID: <bd6139dc0810291639l36849afai45df3b571061fe58@mail.gmail.com>
References: <bd6139dc0810291606o2efe4254me378335b76861340@mail.gmail.com>
	 <20081029231251.GB31926@spearce.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailinglist" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:40:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvKei-0006pM-SU
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbYJ2Xjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754452AbYJ2Xjk
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:39:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:57796 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbYJ2Xjj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:39:39 -0400
Received: by fg-out-1718.google.com with SMTP id 19so240631fgg.17
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 16:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rIwnkCvdIPLAgs5n4GWrhdWT00waFAoOpvQTiPMqSoQ=;
        b=vwhJyJqpMO1NcCb32qpqx0C8AdgFFzS/53SL/ic/wh6zNzA8Gt4QwDiLurqiUzAiS3
         8EjfemRMANArz1cSIkejaSSEfeQndqGZqr3HwgY4VMrQshIzKh/xcAsJNjIh789r7QQ+
         CpS6VR0NGwkcKqYKhSZhmLB03PhBkxD0WTwpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=lJbaYkpfJDRXSt2iq7vxq0JBEIk22DwXNb6r5f8t/p3fWfI9GnR6iGBFcVi7ArP4Lo
         dTNtLE6B76N30x+xI8y8GAQ8KQJ6juuwq1ZgfiPbpv+l3YkfBCrEWGWtsuA2z2EwUUe+
         GBLJI49F60cTXX07BU9zC2pTCbdekA+VPMAyI=
Received: by 10.187.195.12 with SMTP id x12mr917764fap.85.1225323576546;
        Wed, 29 Oct 2008 16:39:36 -0700 (PDT)
Received: by 10.187.213.8 with HTTP; Wed, 29 Oct 2008 16:39:36 -0700 (PDT)
In-Reply-To: <20081029231251.GB31926@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99437>

On Thu, Oct 30, 2008 at 00:12, Shawn O. Pearce <spearce@spearce.org> wrote:
> Most stuff in contrib/ has its commit messages with a prefix string
> to make it more clear when looking at the shortlog what is being
> impacted.  Maybe this should be re-written with filter-branch to
> include a prefix before it merges.

Sure, I'm fine with rewriting all commit messages to have a "gitstats:" prefix.

-- 
Cheers,

Sverre Rabbelier
