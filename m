From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 2/3] Add -n/--no-prompt option to mergetool
Date: Fri, 24 Oct 2008 23:55:39 +0100
Message-ID: <20081024225539.GA6119@hashpling.org>
References: <1224583999-26279-1-git-send-email-charles@hashpling.org> <1224583999-26279-2-git-send-email-charles@hashpling.org> <48FDC1CA.2080800@op5.se> <20081021122655.GA29294@hashpling.org> <20081022211720.GA23146@hashpling.org> <7vr668tdvy.fsf@gitster.siamese.dyndns.org> <20081023064455.GA10675@hashpling.org> <49024CF1.5040406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	"Theodore Ts'o" <tytso@mit.edu>
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 00:57:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtVaa-0003wQ-HQ
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 00:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbYJXWzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 18:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbYJXWzw
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 18:55:52 -0400
Received: from ptb-relay02.plus.net ([212.159.14.146]:32924 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYJXWzv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 18:55:51 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1KtVZF-0000Dj-1S; Fri, 24 Oct 2008 23:55:41 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m9OMteRp006582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Oct 2008 23:55:40 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m9OMtd9m006581;
	Fri, 24 Oct 2008 23:55:39 +0100
Content-Disposition: inline
In-Reply-To: <49024CF1.5040406@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: e1d38dd4359bfeeecd3e90f0f9d8e625
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99079>

On Fri, Oct 24, 2008 at 11:32:17PM +0100, William Pursell wrote:
>
> If the short option is dropped, the config option should
> probably associated with mergetool.<tool>.interactive rather
> than mergetool.interactive.  (s/interactive/whatever)

I'm not sure I understand your reasoning. The no-prompt/interactive
option affects the behaviour of the mergetool script independent of
which particular merge tool is being used. Why should the presence or
absence of a short option affect whether the config option is global
or per tool?

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
