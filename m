From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Hash algorithm choice
Date: Sun, 9 Aug 2009 11:16:31 -0700
Message-ID: <fabb9a1e0908091116y6012caa7j6865d5fcd5d9888c@mail.gmail.com>
References: <f448a46a0908090907v68542e4dw1f1c4f610cb46ca2@mail.gmail.com> 
	<f448a46a0908090917s102b4c83pbad6f298a8e127cc@mail.gmail.com> 
	<alpine.LFD.2.01.0908091038300.3288@localhost.localdomain> 
	<7vljls986b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jerome Baum <jerome@jeromebaum.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 20:17:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaCx2-0008G4-Dd
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 20:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbZHISQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 14:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbZHISQw
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 14:16:52 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:61040 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbZHISQv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 14:16:51 -0400
Received: by ey-out-2122.google.com with SMTP id 9so774003eyd.37
        for <git@vger.kernel.org>; Sun, 09 Aug 2009 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=V8hLotWA/uoEv/PEyYFejzMjjH0IkHA8sNdo+i4MxfI=;
        b=hCgNNcG0c6bXcnZ0GsH56Ylb4reiMixpT0kZroLHqvYQt1bizwDPZ2D8x/5lllfhBW
         SoPzz/20E76LjVO3EoyBfAiGoyuh29L7sbIF5yP7nruXyeHTnm9dTTauaiVUH45nwCHb
         erxnfpvBz82CYJjKjtyrSYoATc9u41BPL7Lag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SMrPEIMlCEooEsT+Tk8S/6cVf9elV9cEc1qhdXYybiC04zMSwbLFAMOVomytRHRh8S
         yMddHnb6Nfxxx7G/HZAv7Xug/sVgtJXGQK8iniWaICHwFqhGEH+fY3AVTgmYRzlOtBOq
         0keAIU9AVL6HT6mjA2Lz67lTntHRwIcK4d+eI=
Received: by 10.216.55.195 with SMTP id k45mr720580wec.70.1249841811633; Sun, 
	09 Aug 2009 11:16:51 -0700 (PDT)
In-Reply-To: <7vljls986b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125358>

Heya,

On Sun, Aug 9, 2009 at 11:03, Junio C Hamano<gitster@pobox.com> wrote:
> Just in case Jerome really wants to go further, "almost no changes" and
> "minimal" refers to the fact that we have a few hard-coded hash values
> known to the code, such as the object name for an empty blob and an empty
> tree.

Wouldn't the transport code also have to be modified? I assume git's
integrity checking would yell at if you gave it commits with
non-sha1-hashes and have no way to tell it that that hash was
calculated with a non-sha1-hash at clone time?

-- 
Cheers,

Sverre Rabbelier
