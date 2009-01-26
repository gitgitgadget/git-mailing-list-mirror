From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: backwards compatibility, was Re: [PATCH v1 1/3] Introduce config 
	variable "diff.primer"
Date: Mon, 26 Jan 2009 15:32:07 -0500
Message-ID: <76718490901261232k526e80daha7d9cbaed0178922@mail.gmail.com>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu>
	 <7v1vurf7lq.fsf@gitster.siamese.dyndns.org>
	 <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu>
	 <20090126031206.GB14277@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0901261154330.14855@racer>
	 <20090126111605.GB19993@coredump.intra.peff.net>
	 <76718490901260729m21ba140dke157d1d461aed2d5@mail.gmail.com>
	 <20090126184829.GA27543@coredump.intra.peff.net>
	 <76718490901261149xfedc415j8f5dab677b90d693@mail.gmail.com>
	 <7vd4e96dh7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Keith Cascio <keith@cs.ucla.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 21:34:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRY9b-0001kn-97
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 21:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbZAZUcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 15:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753895AbZAZUcJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 15:32:09 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:50410 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbZAZUcI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 15:32:08 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6018917rvb.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 12:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Uvn5KUJLUk0LX59/KgBweM6/uDkgLBcR52/zAg1pCX4=;
        b=fJxETw5hPJbeONxShLeIiQSfgRDMnGZ++HuycsjMjpW1yNqJIeuMwKkZyZ8r3Ne2OG
         1Fy4MJgx7Ry/51d6i8cdg1KkDTGGmBXpx6V9LLClgeASXBWcZ9ka/vic7Wq7+2DHs2wH
         m5bDOR8LH0wWaDnGwytY8iBq+p6KIaw4YF/Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E+c7AwWGzDmLplzShEEpQazTUXZnJ6VCpjqZbREkVgIlevPGEjsrEuszbBa4fnx72x
         gWRzKxNcaC51F+emMsJXQfBDhnc9bsJZkFADh+WHUA/TGVan3/C8htcoqJbPf+WPu6u3
         iCOwk5wFYh/l9oQ+K8TT133zdhUhBMvMBMCOo=
Received: by 10.141.205.10 with SMTP id h10mr4277597rvq.225.1233001927868; 
	Mon, 26 Jan 2009 12:32:07 -0800 (PST)
In-Reply-To: <7vd4e96dh7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107268>

On Mon, Jan 26, 2009 at 3:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Where do all of these nonsense come from?  We are not adding any mechanism
> for scripts to say they need plumbing context.  By calling plumbing they
> are already asking for stable plumbing behaviour.

The suggestion was wrt to commands which are not strictly plumbing.

j.
