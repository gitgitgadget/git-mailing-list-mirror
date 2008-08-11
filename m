From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Mon, 11 Aug 2008 12:11:32 +0200
Message-ID: <20080811101132.GB31686@cuci.nl>
References: <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl> <alpine.DEB.1.10.0808100502530.32620@asgard.lang.hm> <20080810145019.GC3955@efreet.light.src> <20080810175735.GA14237@cuci.nl> <20080810181115.GA3906@efreet.light.src> <20080810201651.GB14237@cuci.nl> <7v7iao1oua.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0808101550570.32620@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Jamey Sharp <jamey@minilop.net>,
	Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Aug 11 12:12:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSUOC-0004YR-M3
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 12:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbYHKKLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 06:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbYHKKLe
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 06:11:34 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:54696 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbYHKKLd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 06:11:33 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id BC3C85465; Mon, 11 Aug 2008 12:11:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0808101550570.32620@asgard.lang.hm>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91924>

david@lang.hm wrote:
>On Sun, 10 Aug 2008, Junio C Hamano wrote:
>>* Define a specific leading path, say ".attrs" the hierarchy to store the
>>  attributes information.  Attributes to a file README and t/Makefile

>1. tieing the attributes to the file more directly will make it much 
>easier to deal with them along with the file in the non-rich checkout 
>(it's much easier to say README* then README .attr/README*)

I have to agree that from a practical standpoint for the user, having
the file and the attribute tree right next to each other in the tree is
a lot easier to manage.

So even though setting up a shadow attribute tree is cleaner because it
doesn't need some kind of magic extension, it tends to clutter the
management in the flat-file checkout case.
-- 
Sincerely,
           Stephen R. van den Berg.

"Beware: In C++, your friends can see your privates!"
