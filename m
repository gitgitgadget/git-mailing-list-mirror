From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-fast-export: Only output a single parent per line
Date: Sun, 25 May 2008 22:19:36 -0700
Message-ID: <7v7idhej6f.fsf@gitster.siamese.dyndns.org>
References: <1211671313-99006-1-git-send-email-pdebie@ai.rug.nl>
 <7vskw7jh7c.fsf@gitster.siamese.dyndns.org>
 <20080526014904.GZ29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 26 07:20:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0V8U-0007Ks-GU
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 07:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbYEZFTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 01:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbYEZFTv
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 01:19:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbYEZFTu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 01:19:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B0A2C2F62;
	Mon, 26 May 2008 01:19:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 15A3B2F60; Mon, 26 May 2008 01:19:38 -0400 (EDT)
In-Reply-To: <20080526014904.GZ29038@spearce.org> (Shawn O. Pearce's message
 of "Sun, 25 May 2008 21:49:05 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A9C1FF2-2AE3-11DD-AC69-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82901>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Is it fine for even git-fast-import?  fast-import.c: parse_merge() seems
>> to suggest that it also wants one parent per "merge " line.
>
> fast-import wants the same as bzr-fast-import; one parent per
> merge line.  If git-fast-import was doing anything with multiple
> per line it was probably dropping everything after the first.  :-(
>
> This was a bug in fast-export; I'm glad Pieter has fixed it.

Unfortunately, t9301 does not pass with the "fix".
