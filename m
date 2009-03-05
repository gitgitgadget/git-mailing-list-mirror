From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or 
	configured
Date: Thu, 5 Mar 2009 23:26:21 +0100
Message-ID: <fabb9a1e0903051426p1222f151s8f466abf319706da@mail.gmail.com>
References: <20090305221529.GA25871@pvv.org>
	 <fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com>
	 <200903052322.02098.markus.heidelberg@web.de>
	 <200903052325.44648.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>, Andreas Ericsson <ae@op5.se>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Thu Mar 05 23:27:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfM2k-0004kl-Hc
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 23:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbZCEW00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 17:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753603AbZCEW00
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 17:26:26 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:50835 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbZCEW0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 17:26:25 -0500
Received: by fxm24 with SMTP id 24so147277fxm.37
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 14:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pOBAheyULs/8+skUXNIIaEii301Ohzek7Ge5Q+N5Bps=;
        b=mA3aXBAxvWohVc/bjzKepmQcn2NYpy1HG83vPrSDpWxkZ9u3owiiPYhvdZKT4llMHv
         elUd2gLH/4IJxSmCQ7vnLLHGy9LVABVtgolfdlCRloJJGBxYk1l04lmz0O84Bqv1BCWs
         6WI0Qj8VKVRTnEn7yqCZjQPW0XfacqcHwVvT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G+WXt6zDeoHs2OhGb4K/yPfeFbJJKEK3tN9pK+/2W9LEGiliJrK6pqzxt3SyvbAIfF
         aA37LqfC3LkuaqFFu7TYI2bd7EXzFltkbxNGJyM5aNsWjGEN4szqrQgKRYm2TZKR3ytt
         o1vRklQpRQSObkVrhk+2z/t02OSefkveLNheg=
Received: by 10.103.161.16 with SMTP id n16mr774136muo.79.1236291982358; Thu, 
	05 Mar 2009 14:26:22 -0800 (PST)
In-Reply-To: <200903052325.44648.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112354>

Heya,

On Thu, Mar 5, 2009 at 23:25, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> Oh, I confused "config option" with "command line argument"...

Right, I'd like to be able to do:
$ git config push.iamnotretarded true
$ git push

-- 
Cheers,

Sverre Rabbelier
