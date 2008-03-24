From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] Stacked GIT 0.14.2
Date: Mon, 24 Mar 2008 23:55:39 +0000
Message-ID: <b0943d9e0803241655s7a7fea9cvcd3c162253e49625@mail.gmail.com>
References: <b0943d9e0803241259s5280cdc1o255a4412b3fa7bfc@mail.gmail.com>
	 <alpine.LNX.1.10.0803242113070.9368@fbirervta.pbzchgretzou.qr>
	 <47E81037.5030808@keyaccess.nl>
	 <7vlk47ua3v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Rene Herman" <rene.herman@keyaccess.nl>,
	"Jan Engelhardt" <jengelh@computergmbh.de>,
	git <git@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	"Josef Sipek" <jsipek@fsl.cs.sunysb.edu>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 00:56:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdwWh-0004qy-1O
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 00:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbYCXXzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 19:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbYCXXzo
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 19:55:44 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:10595 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbYCXXzn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 19:55:43 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3241867wxd.4
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 16:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FCn94KRnKC1X1o5Ae64OHLuQs/zo+A1Y7SkQPheLoxc=;
        b=lBLfQ3gxcPBxC9VcA8pRfqjSq9scEruoHK075hQVtxrD+3VxaIrDdMXc9Q75JatueBmC6IMg9Bfrf/koR9eduxshXYoUzTpzlQAUcQK30PybQFARzg73tesw6mTXo02e1jHx9jpY6M8H8jtDWOlrNTGPR9oN1SyutRA5f2VpmOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mGqzBtrjXht/mpnAfQvSmiBHTFQVGMI7jUCmU/rHGzOveOc0vzEIKcrGrEXFboilKYrNLaiMuMgIyV+OpcRP8v4k/gZO65yzyq61f9gx2SxIy+uytUB41mbPEytbEe/K6T523tK4/nA2enKjCF4wb/F+YLozTyWlttXoePLqiKE=
Received: by 10.140.208.14 with SMTP id f14mr2727197rvg.283.1206402939772;
        Mon, 24 Mar 2008 16:55:39 -0700 (PDT)
Received: by 10.141.175.11 with HTTP; Mon, 24 Mar 2008 16:55:39 -0700 (PDT)
In-Reply-To: <7vlk47ua3v.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78130>

On 24/03/2008, Junio C Hamano <gitster@pobox.com> wrote:
> Rene Herman <rene.herman@keyaccess.nl> writes:
>  > And I remember some mumblings about git growing quilt-like
>  > functionality itself. Anything on that?
>
>
> Not my mumbling, but I am quite open to slurp in guilt as a subdirectory
>  in git.git at some point in the future just like we bundle git-gui and
>  gitk if asked by the maintainer.
>
>  The same applies to StGIT for that matter, although I somehow feel that is
>  much less likely to happen, because it lived long enough as a standalone
>  project with enough following to achieve sustainable momentum by itself.

Indeed, StGIT has grown quite a lot (it now has ~45 commands) and it
probably feels better as a tool on its own. However, I think it would
be good for git to get such functionality (and it could even share
some ideas StGIT and guilt). If this functionality will get fully
integrated in git, StGIT could use it directly rather than the
low-level git commands.

An example of additional functionality that might stay outside of git
(at least for a while): since basic patch management support is pretty
much complete in StGIT, a feature we are thinking about adding is
better support for patch sharing between developers (or
repositories/branches). This should allow easier cloning and merging
with branches that have a volatile history at the top.

-- 
Catalin
