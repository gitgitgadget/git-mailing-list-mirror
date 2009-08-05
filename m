From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 07/13] Add a config option for remotes to specify a 
	foreign vcs
Date: Wed, 5 Aug 2009 15:05:58 -0700
Message-ID: <fabb9a1e0908051505h671ece4ekef8bb887865a8488@mail.gmail.com>
References: <alpine.LNX.2.00.0908050055500.2147@iabervon.org> 
	<alpine.DEB.1.00.0908052251430.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051658530.2147@iabervon.org> 
	<alpine.DEB.1.00.0908052319210.8306@pacific.mpi-cbg.de> <fabb9a1e0908051446t63942d21nf71ee0673bb85b8c@mail.gmail.com> 
	<alpine.DEB.1.00.0908052349250.8306@pacific.mpi-cbg.de> <fabb9a1e0908051453y3bb4b2fax2ab17608436510ca@mail.gmail.com> 
	<alpine.DEB.1.00.0908060004300.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 06 00:06:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYocz-0006ky-PN
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 00:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbZHEWG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 18:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbZHEWG0
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 18:06:26 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:10259 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbZHEWGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 18:06:25 -0400
Received: by ey-out-2122.google.com with SMTP id 9so244152eyd.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 15:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JS5pjI+FSpnNwjdB5vF3gudAxK9fnBKQbjidSvwwxPk=;
        b=f7PBJWAqgopWn/NJ26Q1DNgt1M4hVv3ql4ek9R6F1m0TWlPtLMICjcLe030Out1uym
         29plDcfLbv56OJGwkg7E/SBD5TVf/xTrjzerE+Lvg+atyfbN/oo9ma9X4b/OWUN6Hfse
         KLUFKMJYs67RJ06Negb9qoqRMxq7qBHbe2F/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=p62jkr6Yd2+BPBHR+Nahqwnb7anBYZgQSIzP7wR2FQaGjt29PQ2TWYcS+hZ7dZmfSb
         A3RD+cskvsaMBC3YQM2T+r/L+vzremNlaiFWMJbZ70kOXn5iqt6Wf/CHj1iv+/a2YvA9
         Uk8lLofYvDKtM22wLB22tMtoZmpFVZuMNZY00=
Received: by 10.216.45.206 with SMTP id p56mr1889604web.88.1249509984768; Wed, 
	05 Aug 2009 15:06:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908060004300.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125007>

Heya,

On Wed, Aug 5, 2009 at 15:04, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Yes, I agree: svn:http:// is much better.

Was that sarcasm? (I just realized that ':' is also a forbidden character)

-- 
Cheers,

Sverre Rabbelier
