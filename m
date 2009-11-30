From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 15:17:55 -0600
Message-ID: <tzCtKYIbFlbIbn30IPnqgVxpN1o3NxDP88NXFHHufBYXMjZJIG1Gyw@cipher.nrlssc.navy.mil>
References: <20091130075221.GA5421@coredump.intra.peff.net> <0OMCWm31DRbUGCfPIS6SSJn59HQIM9AKtSDgVSNdiSR99clfmJ3D-Q@cipher.nrlssc.navy.mil> <20091130205453.GA20348@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 22:18:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFDdK-0003PN-0k
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 22:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbZK3VR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 16:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752854AbZK3VR5
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 16:17:57 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44301 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbZK3VR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 16:17:57 -0500
Received: by mail.nrlssc.navy.mil id nAULHuYb005138; Mon, 30 Nov 2009 15:17:56 -0600
In-Reply-To: <20091130205453.GA20348@coredump.intra.peff.net>
X-OriginalArrivalTime: 30 Nov 2009 21:17:56.0462 (UTC) FILETIME=[95F198E0:01CA7202]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134141>

Jeff King wrote:
> On Mon, Nov 30, 2009 at 12:07:40PM -0600, Brandon Casey wrote:

>> ps. There's something eerily familiar about this patch.
> 
> Hmmm. Yes, I didn't search before writing it, but you probably mean:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/127172

:) yeah, that was it, nbd.

> But that is missing the NO-PYTHON bit in GIT-BUILD-OPTIONS (did you
> forget it there, or was it part of some other patch that also didn't get
> applied?).

It was 1/2 of that series.

> Also, I am tempted to move the GIT-BUILD-OPTIONS invocation _up_. It
> is about reading config and should probably come before we start doing
> _anything_.
> 
> So maybe this instead:

<snip the patch>

Looks fine to me.

No strong opinion on whether the BUILD-OPTIONS thing should be
at the beginning of the script, or in the place where you placed
it.

-brandon
