From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Mon, 19 Mar 2012 09:43:05 +0700
Message-ID: <CACsJy8DsuQNEwLb_vSPTN_Zrh6o9OK3V_R3xZDMQsFCaOafUXw@mail.gmail.com>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net> <201203182307.43599.jnareb@gmail.com>
 <20120319023231.GA10426@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Ivan Todoroski <grnch_lists@gmx.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 03:43:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9SZS-0006Qt-7G
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 03:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833Ab2CSCni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 22:43:38 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:47245 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964783Ab2CSCnh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 22:43:37 -0400
Received: by wejx9 with SMTP id x9so5469015wej.19
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 19:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZyTXBrb6x8hoJT8B96rfMYdjO+SS4wdEnu+gTizqP5A=;
        b=nC/btq1r+ZeT/vUKGbconBRolEJnE/GByC3H2JLHg3MxXyfjrR1QvaOKgrfc7e/x7i
         njcMVvaZpg/Okqf6nud2Pf/JjSOgD6wZZ9doCH94easjkb4h58s0agDpDRMMRneX/gkx
         s+ygS96c0mTDnUi0PfJAn+ubnnDX8y+s27ld4PbCzMs1lKdf1+0gfAP5qB7PrsaCZazy
         F9vM5CllPMzN8e2A+z4IqY37+KO1vLbWxYKpBTaIOPnuNqOeKGqI4Mujgjf4jNBnHj8Q
         /Y5tBTBOh4c3fBIdhvVJSKQYs5wtZqzC22U3N2tbOREAyUcEl/ImvseH82ZxHCWH/wfn
         GlnA==
Received: by 10.180.99.100 with SMTP id ep4mr16098525wib.7.1332125016196; Sun,
 18 Mar 2012 19:43:36 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Sun, 18 Mar 2012 19:43:05 -0700 (PDT)
In-Reply-To: <20120319023231.GA10426@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193411>

On Mon, Mar 19, 2012 at 9:32 AM, Jeff King <peff@peff.net> wrote:
> However, I think you would need to teach the run-command API how to open
> extra pipes to a child beyond stdout/stdin/stderr.

That might be a problem on Windows. I think Windows exec* has special
support for stdin/stdout/stderr and only those.
-- 
Duy
