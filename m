From: "Tom Clarke" <tom@u2i.com>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Wed, 3 Oct 2007 16:11:14 +0200
Message-ID: <550f9510710030711p195378c5t2739292d31a12de@mail.gmail.com>
References: <Pine.LNX.4.64.0709281751390.28395@racer.site>
	 <11912513203420-git-send-email-tom@u2i.com>
	 <7vr6ker1lf.fsf@gitster.siamese.dyndns.org>
	 <550f9510710011441t1eb50352ofc8db77f79d794d5@mail.gmail.com>
	 <87ejgescnb.wl%cworth@cworth.org>
	 <550f9510710011521s126ca747v956a6f80182444bb@mail.gmail.com>
	 <20071001223050.GE2137@spearce.org>
	 <Pine.LNX.4.64.0710021056280.28395@racer.site>
	 <550f9510710020329m7917dc9m2bb6cfc4055fea84@mail.gmail.com>
	 <7vr6kdl5rj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Carl Worth" <cworth@cworth.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 16:11:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id4wh-0001zd-9C
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 16:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbXJCOLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 10:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbXJCOLS
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 10:11:18 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:59465 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbXJCOLR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 10:11:17 -0400
Received: by py-out-1112.google.com with SMTP id u77so8505328pyb
        for <git@vger.kernel.org>; Wed, 03 Oct 2007 07:11:15 -0700 (PDT)
Received: by 10.35.63.2 with SMTP id q2mr11211655pyk.1191420674369;
        Wed, 03 Oct 2007 07:11:14 -0700 (PDT)
Received: by 10.35.86.2 with HTTP; Wed, 3 Oct 2007 07:11:14 -0700 (PDT)
In-Reply-To: <7vr6kdl5rj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59841>

On 10/2/07, Junio C Hamano <gitster@pobox.com> wrote:
> I do not offhand think of a place other than "git pull" that
> would make sense to sometimes be able to rebase when you
> normally use merge, so I am inclined to say it would be easier
> to teach that "'git pull' is usually a 'git fetch' followed by
> 'git merge', but in certain workflow it is handier to 'git
> fetch' and then 'git rebase', and here are the ways to get the
> rebasing behaviour...".

I agree. I'll revisit teaching pull to be able to use rebase.

Thanks,

-Tom
