From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] diff: treat -crlf files as binary
Date: Sun, 31 Aug 2008 14:34:47 -0400
Message-ID: <32541b130808311134ia3bdab6w37c26649717085aa@mail.gmail.com>
References: <7vfxon4ikr.fsf@gitster.siamese.dyndns.org>
	 <32541b130808291456k3de953a2yd1e93bc27ad14293@mail.gmail.com>
	 <7vljyefaps.fsf@gitster.siamese.dyndns.org>
	 <81b0412b0808310216h6c349e1en740a1f4c7fef75e6@mail.gmail.com>
	 <7vej45b18y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org,
	arman@twinsun.com
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 20:35:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZrmG-0001qc-IX
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 20:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbYHaSet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 14:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755167AbYHaSet
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 14:34:49 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:61212 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbYHaSet (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 14:34:49 -0400
Received: by yw-out-2324.google.com with SMTP id 9so230944ywe.1
        for <git@vger.kernel.org>; Sun, 31 Aug 2008 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GFcieS/SiPHAOV/ixZBxpJDFa47FnYF5cBzcdyCd95E=;
        b=hb0TnEx8U34dnK2js0ozTG06OfC82HZu7Uz3XoRzl1X1vhKJLc/CME+P6Qs5ShQjQP
         fGHboipMZa1EMwxTqjU7/Q19/MWZa4UH1f1vYkSigThdtQyr1uq6Qt6AaAId/ziOsptB
         +PvteY0LD1+y3X+C81pxdoGtCZbuGk0TeyaY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=H1us/DXZY1myDen8Yxue30DID6VOGqT9qdDt/e5nKca7R+V6HFi4jvs7vEt0qSx8Cb
         1SSw3Z8wiomsx82BTaqmWhBhx5Wx1vSeULl5htVh/uZpj0vgSmArwbXlKu9a52QyCI2g
         4J9gS5nKcJySLIXz+/ohW+mC5UdYMgL0tsG8g=
Received: by 10.150.154.6 with SMTP id b6mr7510600ybe.28.1220207687822;
        Sun, 31 Aug 2008 11:34:47 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Sun, 31 Aug 2008 11:34:47 -0700 (PDT)
In-Reply-To: <7vej45b18y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94499>

On Sun, Aug 31, 2008 at 12:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I am actually more surprised by the lack of any surprised comment about
> the unadvertised presense of "binary" (pseudo)attribute, though.  The
> support has been there since f48fd68 (attribute macro support,
> 2007-04-14), two days after introduction of gitattributes mechanism.

Er, well, I was actually talking about a *hypothetical* "binary"
attribute when I commented on this in the first place.  But when there
then turned out to actually be one that worked exactly as I wanted, I
was hardly going to be the first to complain :)

Have fun,

Avery
