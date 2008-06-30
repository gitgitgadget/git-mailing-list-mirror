From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [RFC] Single system account for multiple git users
Date: Mon, 30 Jun 2008 21:07:53 +0400
Message-ID: <37fcd2780806301007p6c1717bcue325bd5bca96ffe4@mail.gmail.com>
References: <20080630151113.GO5737@dpotapov.dyndns.org>
	 <alpine.DEB.1.10.0806300858380.25384@alchemy.localdomain>
	 <37fcd2780806300951sd164870ib09bfc5e47dcaa57@mail.gmail.com>
	 <48691059.4060604@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Asheesh Laroia" <asheesh@asheesh.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Loeliger" <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 19:09:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDMsD-0001Yq-Ev
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 19:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbYF3RII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 13:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbYF3RIH
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 13:08:07 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:46415 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbYF3RIE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 13:08:04 -0400
Received: by yw-out-2324.google.com with SMTP id 9so791716ywe.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=392v975Wm/lHExPOHBKYUm9eP2xoYVfwU/eBIZR6Qi0=;
        b=IVn0qxuqegJS3cgi4g8YSCyKFWAYTjwDCxvWugj34Dz6A4BvjEUM7HB01Rm14KJMtE
         8+s+6MlkyC+f9PldJYo9GU/QCl/MTkeR5F0pDl43cLhhVZh97mZ3iRtcGBAhvfRyhFhU
         OnyhT0sli0ZEapIBZceXC+vkcofZP/o+H429A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hZLlmHdirFq21HKq62Ai79OuFN8eMiFaUPy7JVdYwgBYyslgtzsGoAwsXM6UsMVWqP
         q2vAEbsDZrnKwmWmT5LHQj8Vg8NPEDf+YbioX5KRcHtJsbz7pvfR+Xv2Nd5kGHNe6Vwm
         Axb/gu54R5m7+oYoYJSauSieHCY+K8S38RaWw=
Received: by 10.143.30.10 with SMTP id h10mr2001534wfj.7.1214845673229;
        Mon, 30 Jun 2008 10:07:53 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Mon, 30 Jun 2008 10:07:53 -0700 (PDT)
In-Reply-To: <48691059.4060604@freescale.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86924>

On Mon, Jun 30, 2008 at 8:56 PM, Jon Loeliger <jdl@freescale.com> wrote:
>
> Does that just mean that the git-shell program
> has to be listed in /etc/shells?

Whether git-shell should be listed in etc/shells depends on your
distributive, but it is irrelevant in this case. git-shell will not interpret
the given command. So, it won't work.

Dmitry
