From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Wed, 2 Jan 2013 13:37:10 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130102183710.GB19006@thyrsus.com>
References: <20130101172645.GA5506@thyrsus.com>
 <7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
 <20130102003344.GA9651@thyrsus.com>
 <7vr4m331bn.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 19:38:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqTCl-0002jJ-2H
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 19:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab3ABSh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 13:37:59 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:37020
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab3ABSh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 13:37:58 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 54B424415C; Wed,  2 Jan 2013 13:37:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vr4m331bn.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212531>

Junio C Hamano <gitster@pobox.com>:
> As your version already knows how to detect the case where cvsps is
> too old to operate with it, I imagine it to be straight-forward to
> ship the old cvsimport under obscure name, "git cvsimport--old" or
> something, and spawn it from your version when necessary, perhaps
> after issuing a warning "cvsps 3.0 not found; switching to an old
> and unmaintained version of cvsimport..."

This can be done.  As this may not be the last case in which it comes up,
perhaps we should have an 'obsolete' directory distinct from 'contrib'.

I'll ship another patch.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
