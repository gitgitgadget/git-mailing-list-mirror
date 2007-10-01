From: "Tom Clarke" <tom@u2i.com>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Tue, 2 Oct 2007 00:21:21 +0200
Message-ID: <550f9510710011521s126ca747v956a6f80182444bb@mail.gmail.com>
References: <Pine.LNX.4.64.0709281751390.28395@racer.site>
	 <11912513203420-git-send-email-tom@u2i.com>
	 <7vr6ker1lf.fsf@gitster.siamese.dyndns.org>
	 <550f9510710011441t1eb50352ofc8db77f79d794d5@mail.gmail.com>
	 <87ejgescnb.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, Johannes.Schindelin@gmx.de,
	git@vger.kernel.org
To: "Carl Worth" <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 00:21:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcTdt-0005p2-Hc
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 00:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbXJAWVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 18:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbXJAWVY
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 18:21:24 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:50817 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbXJAWVX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 18:21:23 -0400
Received: by py-out-1112.google.com with SMTP id u77so7361854pyb
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 15:21:22 -0700 (PDT)
Received: by 10.35.117.5 with SMTP id u5mr4592821pym.1191277281857;
        Mon, 01 Oct 2007 15:21:21 -0700 (PDT)
Received: by 10.35.86.2 with HTTP; Mon, 1 Oct 2007 15:21:21 -0700 (PDT)
In-Reply-To: <87ejgescnb.wl%cworth@cworth.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59639>

On 10/2/07, Carl Worth <cworth@cworth.org> wrote:
> What I think I've always wanted is something like the following
> behavior for "git pull":
>
>   * Fast forward if possible
>
>   * Otherwise, rebase, but only if there are no conflicts at all
>
>   * Otherwise, do the merge as normal, (leave conflict markers in
>     place allowing the user to fix them up and then commit).
>
> Would it be straightforward to turn your rebase merge strategy into
> something like the above? And if so, would that address the primary
> concerns that Junio raised?

Maybe we need a 'pull' strategy' - merge, rebase or <insert name for
strategy you describe above>.

-Tom
