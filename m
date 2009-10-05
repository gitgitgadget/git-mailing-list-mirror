From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when 
	appropriate to do so
Date: Mon, 5 Oct 2009 18:00:05 -0400
Message-ID: <76718490910051500m32878c7dgcc86489933cb2309@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 00:08:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muvj9-0003XD-M3
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 00:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbZJEWAo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2009 18:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754849AbZJEWAo
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 18:00:44 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:55494 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827AbZJEWAn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2009 18:00:43 -0400
Received: by iwn8 with SMTP id 8so1953650iwn.33
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 15:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6gtCW3IIQ6l3Ub5aiC+qJ1t/ikLAgSVa9bvOpb/meBk=;
        b=enhEjrXt8AWpzsnVJCU/rxt5MD0ln81ZB/+MXGYgH91Nl3g2EUpsLwvjrLR5anCmKq
         rv9Bc908COmUkOp+1sYczpCLZ6RRCSvbIztIsykcg/Mc3ieFryIQxRZZalh9ggf5+j9g
         a08I4dffDEFSeI7LVyHKpq0MW8PIB/ToDEy08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WYniUl4cSbL2ZDa+MH5gHCMxpuFE/ta1NLj9eqhlDVRWKygSrW0g8rzcWOOf4p7Sie
         oVAn3zwsrVE3AydPulSH4eLNhmDktvqgd/Ie+edDB6pibCgZc17+b7tbM1o9IrS1hlnE
         BlFcY+50QIGsV2sWyZPXjXpiCIhbAL0ECJR8E=
Received: by 10.231.26.131 with SMTP id e3mr1070469ibc.0.1254780006020; Mon, 
	05 Oct 2009 15:00:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129599>

On Mon, Oct 5, 2009 at 5:17 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Actually, we should really think long and hard why we should not
> automatically check out the local branch "next" in that case. =C2=A0I=
 mean,
> really long and hard, and making sure to take user-friendliness into
> account at least as much as simplicity of implementation.

Sure, why not? Are you asking for a patch, or just soliciting conversat=
ion?

j.
