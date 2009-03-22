From: Geoffrey Lee <geoffreyj.lee@gmail.com>
Subject: Re: Newbie: Do I need to download the entire repo to work on just 1 
	file?
Date: Sun, 22 Mar 2009 16:16:43 -0700
Message-ID: <83d7aaa40903221616x706fe579r9c8d3d792d2341e0@mail.gmail.com>
References: <BLU121-W15DB0E5CEBC1DA697E5ED8B4950@phx.gbl>
	 <fabb9a1e0903221600j22cf028fl903aef8076e53777@mail.gmail.com>
	 <20090322231002.GA12974@vidovic>
	 <fabb9a1e0903221610p3b11f09ctc6a9f4d38b1bda3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s-dev@laposte.net>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:18:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlWw6-0005yS-44
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 00:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546AbZCVXQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 19:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756515AbZCVXQq
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 19:16:46 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:60340 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbZCVXQp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 19:16:45 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2515753wff.4
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 16:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sY7MLG8k/M9Gw0R9T5IyQYwejpi6Hi+WEUS3M4kyvwg=;
        b=p0zyS9tkeZTxtRNOtdr4j7QfxBk0Xcq4lunYejCsXraoO2qJD0DV0dI9zSIzR2FUHL
         ObmVsEOnV9LWjnV8MIGSkue3k/cNaj9IPIphblUTDIqyKcFTRHdke2t1oedan3Edw130
         p8GOmaZUqa9L9McFzkewLZk9Qt3PADdp+pJsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p5BFvKgtmirKBJHs5y4f3dVmi5vKZTi2YzBIVFdA5pF0D0xmyQGHZd7vRFerAqCzYk
         fOp1GEn1tFzhFEG1+IbJhsYBjbxy7QJ5AqJaUYFGm9wG8+QYpD0fbi+ltb2u98BdeZCs
         qx4dcemeu/trcyg2Bv+FgHdGqLr7fGcbmt/08=
Received: by 10.142.179.2 with SMTP id b2mr2566964wff.46.1237763803670; Sun, 
	22 Mar 2009 16:16:43 -0700 (PDT)
In-Reply-To: <fabb9a1e0903221610p3b11f09ctc6a9f4d38b1bda3e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114200>

On Sun, Mar 22, 2009 at 4:10 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> That depends on if he wants to push back to the original repo or not, right?

Correct. You cannot push, fetch, or clone a shallow repo. And for Git
development, it's all about sending patches, so you don't need past
revisions.

-Geoffrey Lee
