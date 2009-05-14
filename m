From: Cory Sharp <cory.sharp@gmail.com>
Subject: Re: [Q] merge squash unexpected conflicts
Date: Thu, 14 May 2009 11:25:23 -0700
Message-ID: <bb9d69200905141125i4a8ffaa8j6aea2a6c44de0c7d@mail.gmail.com>
References: <bb9d69200905131706m61b0dda1xc347ca2e719ec142@mail.gmail.com>
	 <bb9d69200905131942t7a43a29fh9638d2548e9f12dc@mail.gmail.com>
	 <7v4ovo1iap.fsf@alter.siamese.dyndns.org>
	 <bb9d69200905132057u60adc2f8vb9ba9a35791f72ac@mail.gmail.com>
	 <7veiusz45w.fsf@alter.siamese.dyndns.org>
	 <bb9d69200905132334m7a4e3a4akde3529abeab5a09@mail.gmail.com>
	 <7v4ovoxk0n.fsf@alter.siamese.dyndns.org>
	 <bb9d69200905132354h6b64171g24351840fb1d0893@mail.gmail.com>
	 <20090514070129.GL8212@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Radziej <mir@noris.de>
X-From: git-owner@vger.kernel.org Thu May 14 20:25:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4fcb-0007JA-13
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 20:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbZENSZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 14:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbZENSZY
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 14:25:24 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:15659 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbZENSZX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 14:25:23 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1153130qwd.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 11:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NxUkdV6dzAyjf/PA2g9oBCUPVSPD8Y/msZI2YXplnc0=;
        b=f8gOTAsSIjwaHqZFZA+ePjMXCwWzc5UNcU6wMzHjVgcVYbTEFfGzX71Ks7S+kQuyR+
         ahgNZUaXOOWX6/bRGJkCnElUdiFrnYEImRhzPDclfQiIaxgJIZ5jqUFU/DzOzgEzTm6v
         xwjIxHywamELG8cWB0gY5JpRJ/hgOlD5Nz/j8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ReSItwXvFpAeBOW+NoO3z4U/JKw5TM82zcQE7El7l9fnr0UmpgNoSRho1ii6W+ErVZ
         eJXcZQhxnm6vSK74pOQRKUexCIIRpetyKakQ+a5XxBgf+O5PPGUy+lKT1F0vb5siTS3q
         gt4JWVB1cUgOi2M7wt8Leu/EuX0IGt9bacbBY=
Received: by 10.229.80.18 with SMTP id r18mr1767458qck.73.1242325523799; Thu, 
	14 May 2009 11:25:23 -0700 (PDT)
In-Reply-To: <20090514070129.GL8212@noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119209>

On Thu, May 14, 2009 at 12:01 AM, Michael Radziej <mir@noris.de> wrote:
> git merge --squash is not a merge at all. ...
> It is useful only in very special circumstances.

You're right.  I (incorrectly) thought I had to use --squash to
properly interface with an svn branch and trunk through git-svn.  I
thought not using squash would trigger hundreds of commits - it
doesn't, nice things happen with just "merge".

Thanks everyone for helping me,
Cory
