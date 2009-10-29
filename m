From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC 2/2] Provide a build time default-editor setting
Date: Thu, 29 Oct 2009 21:57:36 +0100
Organization: Viscovery Software GmbH
Message-ID: <200910292157.37474.j.sixt@viscovery.net>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca> <4AE98175.504@viscovery.net> <7viqdy6ii1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: David Roundy <roundyd@physics.oregonstate.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 21:57:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3c3w-0000M8-MU
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 21:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbZJ2U5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 16:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754317AbZJ2U5a
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 16:57:30 -0400
Received: from [93.83.142.38] ([93.83.142.38]:50778 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752855AbZJ2U53 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 16:57:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B5DFB19F604;
	Thu, 29 Oct 2009 21:57:37 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7viqdy6ii1.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131653>

On Donnerstag, 29. Oktober 2009, Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> > Something like below? Possible usage in shell scripts:
> >
> > 	editor=$(git var GIT_EDITOR)
> > 	"$editor" "$filename"
>
> I think we support GIT_EDITOR that is command path plus its initial
> command line arguments, so you do not want dq around $editor, right?

Yeah, whatever, I didn't take the time to think it through. But this may be an 
opportunity to give some life back to the zombie that git-var currently is, 
that is, to make it the plumbing that does value discovery for variables like 
GIT_AUTHOR_INDENT, GIT_COMMITTER_IDENT, GIT_EDITOR, and perhaps also 
GIT_PAGER.

-- Hannes
