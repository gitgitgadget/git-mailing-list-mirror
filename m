From: "Russ Dill" <russ.dill@gmail.com>
Subject: Re: Cleaning the .git directory with gc
Date: Wed, 23 Apr 2008 17:09:40 -0700
Message-ID: <f9d2a5e10804231709v1d7e426fwf68b3d316a15081a@mail.gmail.com>
References: <20080423231359.GA30913@fox>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Haakon Riiser" <haakon.riiser@fys.uio.no>
X-From: git-owner@vger.kernel.org Thu Apr 24 02:10:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jop2t-0006C2-8X
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 02:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbYDXAJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 20:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbYDXAJn
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 20:09:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:55741 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbYDXAJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 20:09:42 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1149011nfb.21
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vxP8gJ/CHUNbpn5rEeY+j1Ah/MTZYXLEzFQXkjttBpE=;
        b=u3/WrqxoPvKnrC2o/FajoF+b7aRM2o+eNj56pEuDbd+o5btGMfw24GUI1dcKHxCYZFIEnEZUplU4DwoJbotCmG1Ug9E10X4hsy07vPmVIvM11pxI1yY8D0tqW1B0Qx0RD44L5xoNA0jSJFkhFMJC0XtoDq/LaFV4SY8tjHwVDFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CgnJw+DpqsdoQjKMof7Uh1IhlU8TtDWxPkzvq3S4zvDWv/2q+VlqD6Q6akAEsspTfqDlYhuiJB5NclQ6Uo4aZpXUCfQ9TiOeZX+WHeD5QFLYYvzJn+JfuxZoGF4uT6G/iNSpw3QcTgEyY3zVkonoCzyBRnXHT67Z+Za1qBKpUZE=
Received: by 10.78.134.6 with SMTP id h6mr1682670hud.68.1208995780417;
        Wed, 23 Apr 2008 17:09:40 -0700 (PDT)
Received: by 10.78.19.20 with HTTP; Wed, 23 Apr 2008 17:09:40 -0700 (PDT)
In-Reply-To: <20080423231359.GA30913@fox>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80274>

On Wed, Apr 23, 2008 at 4:13 PM, Haakon Riiser <haakon.riiser@fys.uio.no> wrote:
> I've recently started using git, and while experimenting with
>  git commit --amend, I noticed that git gc does not do what I
>  expected.  Example:

Thats a lot of work without first reading the man page:

       --prune
           Usually git-gc packs refs, expires old reflog entries, packs loose
           objects, and removes old rerere records. Removal of unreferenced
           loose objects is an unsafe operation while other git operations are
           in progress, so it is not done by default. Pass this option if you
           want it, and only when you know nobody else is creating new objects
           in the repository at the same time (e.g. never use this option in a
           cron script).
