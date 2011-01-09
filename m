From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Introduce new configuation option to override
 committer information
Date: Sun, 9 Jan 2011 11:24:31 -0600
Message-ID: <20110109172431.GA7718@burratino>
References: <igadki$4tb$2@dough.gmane.org>
 <1294568989-5848-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Stephen Kelly <steveire@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 09 18:24:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pbz0W-00026U-Ui
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 18:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab1AIRYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jan 2011 12:24:39 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60284 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab1AIRYj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 12:24:39 -0500
Received: by iwn9 with SMTP id 9so18569934iwn.19
        for <git@vger.kernel.org>; Sun, 09 Jan 2011 09:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9Fo2oUsdnHHAnbfz9VmeeR+h+C5tDiqlwOZyhMHscdc=;
        b=Gpgc5fcgjT5IPEEXiHAx/RVv2I63+wNtYz+d1hB1GSBdO4TR6mhK3aoEzdVNe6Lhcc
         DV6nu2c3wODGq33aRuzsrBAtzMXWzYk6qcVC5qRV6W1vvHna2syj44E6PmzWkdz/fEdR
         PsAlgi2vugnorFYqYernl4/FgQ4pQ7MfacN3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dukWoBlAfgF4/6NQMEMaFtNa6heX8wwlHwvVuQQS3q6jsmr5oA3keJp+uK6/DSRqmk
         V2NkcWurG63ue/ILuQ+FsxHFIOs4pqGXfIFYIz/LNwKttbYVCYBjQU4pwHqiPsbcm8a8
         mIV26IrwSw4T09CwI/AXlmz1gIb3r4tPtvFIg=
Received: by 10.42.164.73 with SMTP id f9mr3347894icy.156.1294593878137;
        Sun, 09 Jan 2011 09:24:38 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id k42sm2833309ick.8.2011.01.09.09.24.35
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 09 Jan 2011 09:24:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294568989-5848-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164854>

Ramkumar Ramachandra wrote:

> The 'user.name' and 'user.email' configuration
> options set both author and committer information. To solve this,
> introduce 'user.committername' and 'user.committeremail' configuration
> options to override committer name and email respectively.

Predictably, I don't like this idea at all.  How would we explain this
to a new user that is reading over gitconfig(5) for the first time?
It makes the semantics of the committer and author name (that are mostly
meant for giving credit and a contact address) much more murky.

Stephen Kelly:

> In KDE the committer email address is used to be able to use keywords in 
> commit messages to automatically close bugs.

Is it impossible to fix this on the KDE side?  I would think a
many-to-one mapping from committer identities to bugzilla account
names could be a useful thing to have in any case.

Hopeful,
Jonathan
