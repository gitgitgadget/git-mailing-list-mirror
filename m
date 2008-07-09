From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git over rsync+ssh
Date: Wed, 9 Jul 2008 12:02:41 -0400
Message-ID: <32541b130807090902q2cdc9fcbg6f685dcb96407644@mail.gmail.com>
References: <g52gbg$si9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Jul 09 18:03:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGc8q-0005dw-S4
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 18:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbYGIQCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 12:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754672AbYGIQCm
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 12:02:42 -0400
Received: from rn-out-0910.google.com ([64.233.170.187]:51424 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbYGIQCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 12:02:42 -0400
Received: by rn-out-0910.google.com with SMTP id k40so845427rnd.17
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LnphB2ZNuvCdHQdK8x3eI4h1WF7bwOc/Tadne7F+kSM=;
        b=QjmbUmd/msOPdW8P7BlQT7Vtqx3633LcxGi2rA5apsUqEBwEJTvhGKdlBXSfI/nWC3
         uAXL5hpkvOBVMlJjwa8OVBaSBhSWFZPns3Wonvnl7X+0PO1zEXsl8rLXKtrt7G2uOWqt
         y42FQz4OZtOdh6MhYFwxCtxU+53L0xfJn/VB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dPvgkcU5j0Rawysrg2Y+iiIAWNiTKi9nfFOm/6WOycjz1EBdirAAuWAILIngmMjz63
         s07dXcJhrlsnO4fadVJutF9XtbI+8lic122bvePlU5VwofGTUEXlTCApfUZk/87MFXdE
         hmUDuA+VcDiMXskWAQtYhT6x+6iFcroPXMBLc=
Received: by 10.150.49.1 with SMTP id w1mr12720883ybw.4.1215619361194;
        Wed, 09 Jul 2008 09:02:41 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Wed, 9 Jul 2008 09:02:41 -0700 (PDT)
In-Reply-To: <g52gbg$si9$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87889>

On 7/9/08, Michael J Gruber <michaeljgruber+gmane@fastmail.fm> wrote:
> I want to put a git repo on a server where I have ssh access but failed to
> compile git (AIX 5.1, has libz.a but no .so nor headers; compiling
> prerequisite zlib failed, probably due to a botched build environment).
>
>  As far as I can see my only option for a private repo is using rsync over
> ssh.
>
>  Alas, the rsync:// transport of git seems to imply an rsync daemon
> connection.
>
>  How can I specify rsync over ssh as the git transport?

I don't know if this will help in your case, but if it will be only
you pushing to this repository, one option is to simply create a bare
push repository on your local machine, and then manually just
rsync+ssh it to the remote machine from the command line as a
so-called "push" operation.

You would then make the repo available to others over http or
something, which presumably you have available.

Would that work?

Have fun,

Avery
