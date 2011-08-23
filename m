From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 4/4] Add documentation for ref namespaces
Date: Tue, 23 Aug 2011 12:38:04 +0200
Message-ID: <CACBZZX4bow8vwrwSL5uRJQtAgeg10_K+5ss8u-HvCHOn3+0Tuw@mail.gmail.com>
References: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
	<1307470885-4018-1-git-send-email-jamey@minilop.net>
	<1307470885-4018-5-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Tue Aug 23 12:38:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvoN7-0004BE-UO
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 12:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427Ab1HWKiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 06:38:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62282 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab1HWKiG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 06:38:06 -0400
Received: by fxh19 with SMTP id 19so144768fxh.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 03:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Rtlq+2XOJIvgJ3SJIfENVp0j9///ojj/xXpE+kKiNdM=;
        b=Lf6SyxpmqdgpzFjTFvrsqC+FHjq5B5CRQiD3TZxjJRPApX3jgQP5ru3+uk8xyOd64Q
         N7Kt9kMz5X5p8Brrf0JVHIx1iMhbRS1jBvh5KrR3lYE2WZajfAWeij9lBcO136LCgfHB
         T9uUQVYIYWD6nHZYIL9Pt52ncZMHwYrpPlVzE=
Received: by 10.223.100.145 with SMTP id y17mr104738fan.32.1314095884467; Tue,
 23 Aug 2011 03:38:04 -0700 (PDT)
Received: by 10.223.78.203 with HTTP; Tue, 23 Aug 2011 03:38:04 -0700 (PDT)
In-Reply-To: <1307470885-4018-5-git-send-email-jamey@minilop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179935>

On Tue, Jun 7, 2011 at 20:21, Jamey Sharp <jamey@minilop.net> wrote:

> Document the namespace mechanism in a new gitnamespaces(7) page.
> Reference it from receive-pack and upload-pack.

This breaks the build on older asciidoc versions, the fix is to do
what I did in f5008f56d5aba06598e1c6272f4f55b4ee4bb016.
