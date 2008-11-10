From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Tue, 11 Nov 2008 10:37:37 +1100
Message-ID: <ee77f5c20811101537u6061e5b4w420e9692e0cefad3@mail.gmail.com>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com>
	 <20081029164253.GA3172@sigill.intra.peff.net>
	 <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com>
	 <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20081029171122.GA12167@sigill.intra.peff.net>
	 <20081102123519.GA21251@atjola.homenet>
	 <7vljw2yo93.fsf@gitster.siamese.dyndns.org>
	 <20081103071420.GD10772@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Stephan Beyer" <s-beyer@gmx.net>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 00:39:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzgLY-0005iE-1C
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbYKJXhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753010AbYKJXhk
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:37:40 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:47052 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbYKJXhj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:37:39 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1059114eyi.37
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 15:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ylK1JSJqdCCjncau62XmrUeBM+wp3pZ2nScGw7ZJ644=;
        b=H6gyjv1dxbta5afQ1maZCKpEW2Z/E+V3McZAjdInVmv+AJUkceO1RbWtC/We1yy6/m
         apkODJ1qnpwrSd53aHm8C/LfyiQH+sm+ZpQDAFLiscQT8TCfx7+2Q/Xz9yiEgF/m3eJG
         rvcz4bHoQd9IRQnzmmX7ANDs5cGjOA3pbCYlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ls4ji/ozmiutUsTJ2963laKo/Ig3Gnm3bkdRcknbZq2qsHLyXywPc8C1G/eG+kmHvc
         eXsbDZkvlU/1HxK/RORYhhVbyz7clPYFKYv46VQ5ewl1G1cZK4MbxtBo5Eql84aauJG+
         gByBYs8MQ033lD6FDoE2m3QDHU85DXjW5L6g4=
Received: by 10.210.57.12 with SMTP id f12mr5157220eba.99.1226360257848;
        Mon, 10 Nov 2008 15:37:37 -0800 (PST)
Received: by 10.210.51.7 with HTTP; Mon, 10 Nov 2008 15:37:37 -0800 (PST)
In-Reply-To: <20081103071420.GD10772@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100592>

On Mon, Nov 3, 2008 at 6:14 PM, Jeff King <peff@peff.net> wrote:

> And I am not proposing a change here (except to perhaps "git diff
> --staged" instead of "--cached"). Just pointing out that it does not
> follow the "--staged operates on both, --staged-only operates on just
> the index" rule.

So apart from the wider discussion, I think this patch by itself is a
nice step forward towards improving the UI of this part of git. Is
there any further discussion on this one alone?


Dave.
