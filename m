From: Martin Fick <mfick@codeaurora.org>
Subject: Re: fmt-merge-message: add empty line between tag and signature verification
Date: Fri, 25 May 2012 12:06:30 -0600
Organization: CAF
Message-ID: <201205251206.30783.mfick@codeaurora.org>
References: <alpine.LFD.2.02.1205250850001.19607@i5.linux-foundation.org> <7vtxz4tcmn.fsf@alter.siamese.dyndns.org> <CA+55aFwwUzErbcCGa597N4G7i-_mYso+aJO_0aRq0jNBOi9=ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 25 20:06:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXyuK-0000tK-R4
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 20:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726Ab2EYSGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 14:06:32 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:35149 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab2EYSGc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 14:06:32 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6722"; a="192491396"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 May 2012 11:06:31 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id A473310004A9;
	Fri, 25 May 2012 11:06:31 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <CA+55aFwwUzErbcCGa597N4G7i-_mYso+aJO_0aRq0jNBOi9=ew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198499>

On Friday, May 25, 2012 11:20:10 am Linus Torvalds wrote:
> On Fri, May 25, 2012 at 10:05 AM, Junio C Hamano 
<gitster@pobox.com> wrote:
> >> Btw, I'd also like to see the merge notes (notably the
> >> conflict file list) before the generated shortlog,
> >> but that seems to really not work with the current
> >> fmt-merge-message model.  Oh well.
> > 
> Yes. Right now, the conflict line is hidden way at the
> bottom, and I've actually overlooked it several times
> (and I don't think I'm the only one - do "git log
> --grep=Conflicts:" on the kernel tree and you'll see a
> lot of people just leaving them be).

Tangentially related, I think that in the cherry-pick case 
this can also be a problem. Not exactly the same, but in the 
cherry-pick case you are generally starting with an existing 
commit message, and the location of the conflicts at the 
bottom ends up actually causing functional problems for the 
interpretations of the old "footer-lines" by some tools.  

Notably, our users sometimes cherry-pick gerrit changes but 
then the old Change-Id footer line gets placed above the 
conflicts and if they forget to remove the conflicts, the 
Change-Id footer is not recognized by Gerrit.  

So, not only are users forgetting to remove the conflicts, 
it causes tooling problems in the cherry-pick case by 
messing with the footer layouts,

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
