From: "Tim Visher" <tim.visher@gmail.com>
Subject: Re: Is it possible to roll back unstaged changes while leaving the staged ones for the next commit?
Date: Thu, 18 Dec 2008 07:24:11 -0500
Message-ID: <c115fd3c0812180424q3ac080a8iad53803fd3f2bb4d@mail.gmail.com>
References: <c115fd3c0812171157m3d180534gb5630fbcf39b2bbd@mail.gmail.com>
	 <7vy6yelf2m.fsf@gitster.siamese.dyndns.org>
	 <c115fd3c0812171448o3db6f4c1oc24e39f9a68ed1d3@mail.gmail.com>
	 <7vbpvajtmd.fsf@gitster.siamese.dyndns.org>
	 <c115fd3c0812171722g93dbeefw2fb5bf7641dfe394@mail.gmail.com>
	 <20081218123456.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nanako Shiraishi" <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 13:31:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDI1y-0000aQ-5H
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 13:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbYLRM3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 07:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbYLRM3p
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 07:29:45 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:33928 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbYLRM3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 07:29:44 -0500
Received: by yx-out-2324.google.com with SMTP id 8so146362yxm.1
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 04:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pxz59BxZMRUWan6T8WWgEsOj7XxRJoAqVigGJlQUtII=;
        b=BfRXGvsKgzKGFF+OLM/vPjSIG8qNC8DCFpegpRhl37G3O++C40VPtnH/ffwK1TGyou
         hyagJTfd2QWCQzEeb08p90Tflbe7p28CuvWsBdiuVpJiWk/mtf7qmQPzdVSi9PHqRQ1n
         cKIXUcF/5c26LFoTKSRubweRh7Q2dA5zTfG40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=baVRlMhrVOR1JxUOGEmZ8qe8uQWL3HAYFOYvJlE0TX6eKXLupzOFkZ5nI3Zzz3PDJe
         /spiPQRuAZFYx1Q7OBQyvlu8KMzm0xr0kzlUGqIkY69Ga6XRFTwGAkG9e2ljyNC94RPz
         IfnVxPy0gJ/yHRsq2eyLbC0/SDP9y7EtXWGAw=
Received: by 10.100.93.19 with SMTP id q19mr1332515anb.156.1229603051802;
        Thu, 18 Dec 2008 04:24:11 -0800 (PST)
Received: by 10.100.198.2 with HTTP; Thu, 18 Dec 2008 04:24:11 -0800 (PST)
In-Reply-To: <20081218123456.6117@nanako3.lavabit.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103457>

On Wed, Dec 17, 2008 at 10:34 PM, Nanako Shiraishi <nanako3@lavabit.com> wrote:

> A short answer is "no it is not the case."

Thanks.

> I was about to quote "git checkout" documentation to you because I was reasonably sure that Junio won't respond to people who ask a question whose answer is plainly described in the manual pages, but I think the description of the command is a little confusing especially for people who read it for the first time.

Agreed.

>  When <paths> are given, this command does *not* switch
>  branches.  It updates the named paths in the working tree from
>  the index file, or from a named <tree-ish> (most often a commit).  In
>  this case, the `-b` options is meaningless and giving
>  either of them results in an error.  <tree-ish> argument can be
>  used to specify a specific tree-ish (i.e. commit, tag or tree)

Works a lot better.

Thanks for the help!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
