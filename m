From: Mike Hommey <mh@glandium.org>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Fri, 16 Oct 2009 09:19:42 +0200
Message-ID: <20091016071942.GC3009@glandium.org>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
 <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <7vskdss3ei.fsf@alter.siamese.dyndns.org>
 <slrnhd0nfv.tq2.antti-juhani@kukkaseppele.kaijanaho.fi>
 <4AD80BBD.8080504@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.fi>,
	git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 09:26:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyhCu-00037K-LG
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 09:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882AbZJPHTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 03:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755751AbZJPHTf
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 03:19:35 -0400
Received: from vuizook.err.no ([85.19.221.46]:36734 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbZJPHTe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 03:19:34 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Myh5R-0002nU-4n; Fri, 16 Oct 2009 09:18:55 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Myh6E-0000n3-3O; Fri, 16 Oct 2009 09:19:42 +0200
Content-Disposition: inline
In-Reply-To: <4AD80BBD.8080504@zytor.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130460>

On Thu, Oct 15, 2009 at 10:59:25PM -0700, H. Peter Anvin wrote:
> On 10/10/2009 03:12 AM, Antti-Juhani Kaijanaho wrote:
> > On 2009-10-09, Junio C Hamano <gitster@pobox.com> wrote:
> >>> +If there is no repository at $GIT_URL, the server MUST respond with
> >>> +the '404 Not Found' HTTP status code.
> >>
> >> We may also want to add
> >>
> >>     If there is no object at $GIT_URL/some/path, the server MUST respond
> >>     with the '404 Not Found' HTTP status code.
> >>
> >> to help dumb clients.
> > 
> > In both cases - is it really necessary to forbid the use of 410 (Gone)?
> > 
> 
> 410 means "we once had it, it's no longer here, no idea where it went."
>  It's a largely useless code...

There is an additional meaning to it, that is "it will never ever
return". It thus has a stronger meaning than 404. Sadly, not even search
engine spiders consider it as a hint to not crawl there in the future...

Mike
