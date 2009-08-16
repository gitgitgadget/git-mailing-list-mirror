From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 0/6 (v2)] Suggested for PU: revision caching system to 
	significantly speed up packing/walking
Date: Mon, 17 Aug 2009 00:47:28 +0200
Message-ID: <c77435a80908161547x4d2a9087qf439d1c30cc4fa99@mail.gmail.com>
References: <op.uyb1uryftdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail
X-From: git-owner@vger.kernel.org Mon Aug 17 00:47:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McoVl-0005Gf-Am
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 00:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753AbZHPWr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 18:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754128AbZHPWr2
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 18:47:28 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:13153 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbZHPWr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 18:47:27 -0400
Received: by ey-out-2122.google.com with SMTP id 22so591643eye.37
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 15:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=vuGnq8EJTzVyYpj9FYKgbEmS2q8QAzrlO4AliYG5N8o=;
        b=ubn/wIBWcdh6hAGg3+mvPUqTjPr3zJL+2IW235n/mrDCztaiWRYs/3jBjNKP35VkJC
         AkViofG6vLEhWrJGjlnXtbQHP/jisGkCX6oAtGu39AquZX7HalzGy4G30PPNMLQkxS2R
         Kr+avQJu+vzTBAUbgDZgjFqxB6hYCVctEU6t0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=RTJ2EZ59em2y5RtcLQhDlCaXHss1Jx5FF2B5buCXLI9gm9uFoj0s/OAiKOOSIs8Jv5
         RyfhEEsM7o+04sdsKFG2jYtk6PGyQGLiUE5z7+mTMDBbK8n30f6NIbYdZyt/jQfAANTX
         CHpZnVyKf3b5moKBXUHnBPAUbUnTdDKOCoNnI=
Received: by 10.216.0.79 with SMTP id 57mr914903wea.48.1250462848315; Sun, 16 
	Aug 2009 15:47:28 -0700 (PDT)
In-Reply-To: <op.uyb1uryftdk399@sirnot.private>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126091>

Well crap, in my infinite wisdom I replied with the final updated
patchset to the wrong version :-/  I don't want to clog up the list
with my stupid mistakes, but if you need me to I can resend them to
v3.

But yeah, I've uploaded an updated version.  This patchset:
 - fixes whitespace errors
 - adds _ondisk versions of structures to ensure portability
 - cleans up definitions/fix a typo

Hope it works out for you all.  Sorry about the mismatched reply.

 - Nick
