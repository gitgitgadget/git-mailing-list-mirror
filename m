From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3.5.1 08/12] send-email: Simplify --compose subject 
	sanitation
Date: Mon, 20 Apr 2009 22:29:20 -0500
Message-ID: <b4087cc50904202029h3b9fee7p18e466d6aee0c133@mail.gmail.com>
References: <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-8-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-9-git-send-email-mfwitten@gmail.com>
	 <76718490904181854o380fe118y9f3a52c926bd1f6d@mail.gmail.com>
	 <b4087cc50904181937q38ef45fm7409e020ecf40792@mail.gmail.com>
	 <76718490904190713l3d6b5abcmf54544512de87413@mail.gmail.com>
	 <b4087cc50904190739u54a9a9d7p6f011ab2b47c1d05@mail.gmail.com>
	 <1240159421-5643-1-git-send-email-mfwitten@gmail.com>
	 <20090421023423.GB14479@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 05:30:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw6hF-0008Fy-3Q
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 05:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbZDUD3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 23:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbZDUD3W
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 23:29:22 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:54690 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbZDUD3V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 23:29:21 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1243695qwd.37
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 20:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f9IzBahRViAHuzkAuwnsqfQxKEe3nScLEWGsMMnwRps=;
        b=dLLlyrRV6jOakZLNwZmg31XTDR2uxZtHb/kxjGs4EQRs8s4JCEagNga1ryz/I7wgxR
         RKpOLhSt1gwJS2g7+fIx51ne8oEzo0aUSpBE1eZy7alz9i3cuBMkvcCTbffj74WCzY7Q
         0JYBSUDduKypLZAU0VI3YQDPGouhOHgpolLG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LG7P3q08hDawBxN3il676mNaTIWp3BOoIk76dix39oxKLe9i4hZgJpOJdRq0vlfBQW
         mzD+McU4PWy8ldy1IyYvosxTbxpfpAtKi+bBDFvIjpSf8sof+B5a4TJcVnTsLNjD6VE7
         RoP4xS2mRabLJ/B6HilM/ZHgBDbJ4t+peZCj8=
Received: by 10.224.37.16 with SMTP id v16mr7163446qad.67.1240284560502; Mon, 
	20 Apr 2009 20:29:20 -0700 (PDT)
In-Reply-To: <20090421023423.GB14479@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117085>

On Mon, Apr 20, 2009 at 21:34, Jeff King <peff@peff.net> wrote:
> A few lines above the ones
> you changed, notice that when we see the message already has a
> MIME-Version header, we turn set $need_8bit_cte to 0. But in that case,
> we still may need to encode the subject if it has non-ascii characters.

I think this is the only problem with the patch, and I'm glad you
caught it. However, I can't make further comment until I read the RFC,
so I'm going to withdraw his patch from consideration. Thanks!
