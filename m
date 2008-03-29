From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: Re: git-archive and submodules
Date: Sat, 29 Mar 2008 10:13:34 -0400
Message-ID: <8ec76080803290713k71b7cb19xee2361035a71878d@mail.gmail.com>
References: <8ec76080803290647h25e86f18k7a86bc4cb2cc3d38@mail.gmail.com>
	 <20080329135202.GR4759@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 29 15:14:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfbpF-00031L-Jd
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 15:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbYC2ONf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 10:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbYC2ONf
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 10:13:35 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:28685 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbYC2ONe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 10:13:34 -0400
Received: by wf-out-1314.google.com with SMTP id 28so653443wff.4
        for <git@vger.kernel.org>; Sat, 29 Mar 2008 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hxnTFDYQEmpS9g715B7702XSNODHXqpu/IJJ+c4FE5w=;
        b=Oj7lmIDzEKqBvcs73GRaYwm47Mu/SlA6Q2sguhtq8H63Q/ElCx8TqYGFSgM4y2ISmEq3N25JhIQ0ygJ7BssnBBzzRv26hSMu3N7dd7QAwp7KhB41I+aGS+LVMTq6juTsSBtzRql/caUxWn5obFBhSVVkyUCoyfrrmaZWbuQP6lE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P/Wghu67RSssh5UQWLUlFyqjOTuo1C7fvZfrXs7FxftztzvnR2TaCP+Dwj9GMzxutm2JN/H9Ajw1IjMrWf8YawriSi1HTjyljA80+Rj28mM7mdkIDCb+gF6vdr7+pRFKl/jhXCsi+UL3KHpG40uT+7jTddPCf6Yuf+wmCCKpzII=
Received: by 10.142.178.13 with SMTP id a13mr2649810wff.129.1206800014250;
        Sat, 29 Mar 2008 07:13:34 -0700 (PDT)
Received: by 10.142.187.13 with HTTP; Sat, 29 Mar 2008 07:13:34 -0700 (PDT)
In-Reply-To: <20080329135202.GR4759@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78469>

as a first patch that might be a bit ambitious for me, but I will give it a try.

anyway, it's good to know that there is additional support for this behavior.

-Whit


On Sat, Mar 29, 2008 at 9:52 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Whit Armstrong <armstrong.whit@gmail.com> wrote:
>  > Is there a way to ask git-archive to archive the submodules of the
>  > project as well?
>  >
>  > I have a project that needs it's submoduels distributed with it.
>
>  No.
>
>  Patches welcome.  :-)
>
>  We've talked about supporting it, and wouldn't mind having the
>  tool do it for exactly the reason you mention, but thus far a
>  patch has not been written to implement that.
>
>  --
>  Shawn.
>
