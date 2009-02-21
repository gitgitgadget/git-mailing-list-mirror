From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [tig PATCH] Predefined external command: git commit
Date: Sat, 21 Feb 2009 17:19:49 +0100
Message-ID: <2c6b72b30902210819q43cbf184x77d7587a6aa1630a@mail.gmail.com>
References: <1235176121-17483-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 17:23:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Laudr-00069P-65
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 17:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbZBUQTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 11:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbZBUQTw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 11:19:52 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:35088 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbZBUQTv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 11:19:51 -0500
Received: by bwz5 with SMTP id 5so3548348bwz.13
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 08:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ywcueqrMo6qSHwdmeXEQhrBTGAVfRrXD1mmfLEVgv4Y=;
        b=mbxK49iygbYAiCZCLd9SpJDkNADLZVYVgrc/BcjZ3Ex4MtZrLr3zRw2KA3dHXOvY1P
         60iH/w0yj2tIapxh+1Xaa8Yn3abGw/BVHwfEBj2CkxjyQNXCDM8882EaGulTewnyINdF
         +feHMJia0Ywu047F4YtWOYGUny7R/amwDJKKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=peTUx85r08gE/4X1II8BLX6ILLxqICzVX7j8bMQcYTDPm9ulwy6QNXb4AdrUahR8+C
         Mr8a5zHFG2hBOXjUou9/BNlUC1AFaQ3dQlHA2FZCU+6iIV095lKburN9cbUy/oD5x5px
         baJ37BgaTlYn0r41/p/QuNcLmRxzOuL7J/h7U=
Received: by 10.181.199.19 with SMTP id b19mr740205bkq.191.1235233189930; Sat, 
	21 Feb 2009 08:19:49 -0800 (PST)
In-Reply-To: <1235176121-17483-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110964>

On Sat, Feb 21, 2009 at 01:28, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> It might make sense to map 'A' to 'git commit --amend', too, even though
> that key is currently taken by author display toggle.

We could remap author toggling to 'a' to free 'A'. I assume you want
'A' to make it less likely to be pressed by accident?

BTW, to make the keybinding more scalable, the option toggling should
probably be hidden behind a common prefix key, which would open a menu
with next key searching this menu.

Thanks for both patches.

-- 
Jonas Fonseca
