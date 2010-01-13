From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Display author and committer after "git commit"
Date: Wed, 13 Jan 2010 12:34:08 -0500
Message-ID: <20100113173408.GA16652@coredump.intra.peff.net>
References: <xuu2zl4tfuij.fsf@nowhere.com>
 <20100106073806.6117@nanako3.lavabit.com>
 <7v4omz17xz.fsf@alter.siamese.dyndns.org>
 <xuu28wc9xd42.fsf@nowhere.com>
 <7vskagh9fg.fsf@alter.siamese.dyndns.org>
 <xuu2fx6d9rzb.fsf_-_@nowhere.com>
 <7vzl4lw160.fsf@alter.siamese.dyndns.org>
 <xuu2zl4kks3s.fsf@nowhere.com>
 <20100112142405.GA13369@coredump.intra.peff.net>
 <20100112153656.GA24840@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:34:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV76x-0003Ae-O5
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 18:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756201Ab0AMReT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 12:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756181Ab0AMReT
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 12:34:19 -0500
Received: from peff.net ([208.65.91.99]:46146 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756109Ab0AMReS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 12:34:18 -0500
Received: (qmail 25248 invoked by uid 107); 13 Jan 2010 17:39:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 13 Jan 2010 12:39:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2010 12:34:08 -0500
Content-Disposition: inline
In-Reply-To: <20100112153656.GA24840@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136847>

On Tue, Jan 12, 2010 at 10:36:56AM -0500, Jeff King wrote:

>   [1/3]: strbuf_expand: convert "%%" to "%"
>   [2/3]: strbuf: add strbuf_percentquote_buf
>   [3/3]: commit: show interesting ident information in summary

And here's a re-roll based on Junio's comments.

  [1/3]: strbuf_expand: convert "%%" to "%"
  [2/3]: strbuf: add strbuf_addbuf_percentquote
  [3/3]: commit: show interesting ident information in summary

-Peff
