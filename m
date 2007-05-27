From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sun, 27 May 2007 09:06:22 -0700
Message-ID: <56b7f5510705270906u54792b40g621313d197880fc0@mail.gmail.com>
References: <20070526052419.GA11957@spearce.org>
	 <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
	 <20070527033429.GY28023@spearce.org>
	 <alpine.LFD.0.99.0705271110550.3366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun May 27 18:06:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsLGJ-0006uh-9Y
	for gcvg-git@gmane.org; Sun, 27 May 2007 18:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbXE0QGZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 12:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755004AbXE0QGZ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 12:06:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:26722 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbXE0QGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 12:06:24 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1461676ugf
        for <git@vger.kernel.org>; Sun, 27 May 2007 09:06:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tVsei7n+H/AfJAtwW9CFj+gAZUCTO031TGWzOAe3n3ryOlVuG8NeIqqSCa75tqFlY7kq5bGu+lGo+Mom8QE0MCIwuNetzWwPBGos3DpRclHHwczQdKUtw9QHOMb1l1gS9NnlKNUWnXDT3OPI/8EftLTUJrLnLFcVHG/1jtQbMdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D1OAIfsuFqIqr2/G2ChCmf46PYf6ntEfsG+qg8YoR9MnU4+d5U6FuxInt+g7WBYQOOJLVXzyn2lGH63aZ6uanWk94VkE1idh0FJnWpHmUDzQ+lATrwFmRrM/uIaHAJ3t4PcIABY+ysrKiU0QjHTXXzT5Miluk8uyumCkZKJy9Ek=
Received: by 10.78.140.16 with SMTP id n16mr1447797hud.1180281982532;
        Sun, 27 May 2007 09:06:22 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Sun, 27 May 2007 09:06:22 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0705271110550.3366@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48565>

On 5/27/07, Nicolas Pitre <nico@cam.org> wrote:
> BTW I think the Newton-Raphson based index lookup approach should be
> revived at some point.
Yes.

 I think if we figure out the statistics we could win big.
I thought about it a bit when it was first discussed
but need to return to it.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
