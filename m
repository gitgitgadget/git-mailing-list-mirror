From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 0/6] Make "local" orthogonal to date format
Date: Wed, 2 Sep 2015 08:48:26 +0100
Message-ID: <20150902074826.GK30659@serenity.lan>
References: <20150901083731.GE30659@serenity.lan>
 <cover.1441144343.git.john@keeping.me.uk>
 <20150901224431.GA9353@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 09:48:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX2mf-0001OV-Jt
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 09:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbbIBHsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 03:48:38 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:57737 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbbIBHsh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 03:48:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5C28ECDA59E;
	Wed,  2 Sep 2015 08:48:37 +0100 (BST)
X-Quarantine-ID: <GK8s0w4tzg4t>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GK8s0w4tzg4t; Wed,  2 Sep 2015 08:48:36 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 236D7CDA5FA;
	Wed,  2 Sep 2015 08:48:28 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20150901224431.GA9353@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277078>

On Tue, Sep 01, 2015 at 06:44:31PM -0400, Jeff King wrote:
> [1] I do think the error message for "relative-local is nonsense" could
>     perhaps be more explanatory, but I couldn't come up with any better
>     wording. But if you have ideas, feel free to switch it.

My only suggestion would be to reuse the "unknown date format: %s"
message and avoid having a special message in this case.
