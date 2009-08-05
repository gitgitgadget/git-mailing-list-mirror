From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 07/13] Add a config option for remotes to specify a 
	foreign vcs
Date: Wed, 5 Aug 2009 14:46:50 -0700
Message-ID: <fabb9a1e0908051446t63942d21nf71ee0673bb85b8c@mail.gmail.com>
References: <alpine.LNX.2.00.0908050055500.2147@iabervon.org> 
	<alpine.DEB.1.00.0908052251430.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051658530.2147@iabervon.org> 
	<alpine.DEB.1.00.0908052319210.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:47:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYoKd-0004nZ-VC
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbZHEVrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbZHEVrN
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:47:13 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:36619 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbZHEVrK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:47:10 -0400
Received: by ewy10 with SMTP id 10so338119ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 14:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=r8peB6WHLQ+vFH1GjLiWS/Rs0xEoS6qY5Rao0JeJl0k=;
        b=jLTP4daxlMd9CzoZtXZkUk7rYgDgoZEjh85VxZ2F8MxPH5W7humb13TnHEde3BPPlN
         /dE1pC+EnN8s2P4fM4zo8c9EGjcUGKaCSRK54Bn8NVWveFLaLXvhXzXwL9D47Zkakog4
         KOjK7IBdTZj/xoE1+zQF2YX6GNPwGWEDO9ynk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YrccEfZOy8UXsRNxbyfaxT9xlr/3a6P3AUuL6EXRrQltEZmzyUCUgYUJCUseuFPxvR
         fNnmWfvPRirKj+KGvixdm42wuFfVcdItHfqfco7Luj5lQIgYS0OUSZzbffDO4qu8B/9Q
         rKACIuSPw+6TZsp92+4fBobzNZ7q2iFgst+Us=
Received: by 10.216.11.211 with SMTP id 61mr1919646wex.68.1249508830122; Wed, 
	05 Aug 2009 14:47:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908052319210.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124999>

Heya,

On Wed, Aug 5, 2009 at 14:20, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> I actually would rather have "svn-http://something" because it tells me
> right away and in red letters what is happening.

I don't know if this is only for ssh, but wouldn't
"http+svn://something" be very recognisable?

-- 
Cheers,

Sverre Rabbelier
