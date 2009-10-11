From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 1/3] Fix a bunch of pointer declarations (codestyle)
Date: Sun, 11 Oct 2009 17:53:42 -0300
Message-ID: <a4c8a6d00910111353r20de1fb6u2289999491a9310a@mail.gmail.com>
References: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>
	 <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 22:55:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx5SQ-0004hq-AY
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 22:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbZJKUyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 16:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbZJKUyU
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 16:54:20 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:54066 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbZJKUyU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 16:54:20 -0400
Received: by fxm27 with SMTP id 27so8440898fxm.17
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 13:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=2PFzebe/1q9bdnMh4pvPRoE0I2NMsJB1X/IiTVcW5Yc=;
        b=iEnUpwa5bvkO3qdEr7BpPWOjdlOhq1YZwr3YMa9hltEenY6D29aASlJau/Sx6m7ANB
         AL77Jit1I4B39Ms3ok3zybfBs1zErxVIMTFZsZChX2OwcQMhhCLKMgHNLL5B/fjOc99t
         3RdWw/rPGfDkbD/zSwWt9htKHmnTOiRTAln+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=beiHGNGBoCujmpBrCIyfaAaTyRRdNC3ILC0bsRvIo3jFeaU7VvFG0PbR/i7WofsFfv
         Cfmb7/1N4wIf3IwdicWwzrc3YhkA8iqVzmFpDVgzNabahnAzNANSXKdoZuusEZlHfEhA
         I92fg/WyMlkH53vCNY1ilJHHgSkyADHmIA3Cg=
Received: by 10.204.3.219 with SMTP id 27mr4415838bko.127.1255294422277; Sun, 
	11 Oct 2009 13:53:42 -0700 (PDT)
In-Reply-To: <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129957>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
  "Fix a bunch of pointer declarations".

But in this patch you fixed *only* one pointer declaration:
struct diffstat_t* data -> struct diffstat_t *data
