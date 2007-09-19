From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] strbuf API additions and enhancements.
Date: Wed, 19 Sep 2007 11:46:34 -0700
Message-ID: <7vmyvipk6t.fsf@gitster.siamese.dyndns.org>
References: <20070918223947.GB4535@artemis.corp>
	<20070918224119.17650344AB3@madism.org>
	<20070919144604.7deca4f7.froese@gmx.de>
	<20070919133647.GA17192@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Edgar Toernig <froese@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:06:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY4a8-0000Xw-AF
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 20:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763251AbXISSqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 14:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762872AbXISSqn
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 14:46:43 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:54297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763251AbXISSqm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 14:46:42 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 357881363C2;
	Wed, 19 Sep 2007 14:46:58 -0400 (EDT)
In-Reply-To: <20070919133647.GA17192@artemis.corp> (Pierre Habouzit's message
	of "Wed, 19 Sep 2007 15:36:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58721>

Pierre Habouzit <madcoder@debian.org> writes:

> ... in fact doing it twice is enough but either way I don't like to impose
> that to the caller :/

I do not think so either.  We had a similar issue resolved with
4bf53833.
