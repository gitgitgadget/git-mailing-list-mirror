From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: THREADED_DELTA_SEARCH
Date: Thu, 10 Jul 2008 01:51:06 -0700 (PDT)
Message-ID: <m3hcaydswg.fsf@localhost.localdomain>
References: <20080710075327.GD24819@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 10:52:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGrsm-0004ry-VS
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 10:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbYGJIvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 04:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbYGJIvK
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 04:51:10 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:57037 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbYGJIvJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2008 04:51:09 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1543521ika.5
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 01:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=UaPK/1BO71Guzpmxx6rginZMQndya+iAPMVXM/LzbOk=;
        b=iBuOU49QBopTf1ngIFLTXI/AEPzsH0CAQ/2oahe7yeN2FSVKHFX8yCxnzIMZbGrpB5
         FdwhPl/iX9dFBDZ9/N+xhc/2WE44+oAzmrvGd0TIJ4YmSh6wFQVxnxUd8P/K3+Y8BsaJ
         sxETUT6OCiQmW9JvomAqk8ZWeBDXY+Afvu8Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=tnobOzx+C0bIWXQel490C7a2NUUSvuEFkc/wi0ssrMX9f9nL3ThjJo7Cn5qAut+jw0
         F3iIc0lI7SOGC9y7Q+fzGXELLItiNkFP+r9XFIO1lS+l3wgrofTz5Ouvt8H8QzBmjqeU
         M4/1dM+6AbwY4GjzWMyqI80tstK+TFOKYzkTI=
Received: by 10.210.27.20 with SMTP id a20mr5904053eba.89.1215679867298;
        Thu, 10 Jul 2008 01:51:07 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.245.18])
        by mx.google.com with ESMTPS id z33sm12105062ikz.0.2008.07.10.01.51.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jul 2008 01:51:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6A8p2ps004736;
	Thu, 10 Jul 2008 10:51:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6A8oufQ004731;
	Thu, 10 Jul 2008 10:50:56 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080710075327.GD24819@artemis.madism.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pierre Habouzit <madcoder@debian.org> writes:

>   I'm using it in production for quite a long time now, and I wonder =
if
> there is any specific reason why it's not default. Debian activated i=
t
> by default too a couple of weeks ago, which means that it's in
> production on quite a large scale, and there are no issues reported
> either. Would a patch making it default be accepted ? It's quite hand=
y
> given that SMP machines are really pervasive nowadays=E2=80=A6

Doues our ./configure detects if it makes sense (i.e. if it is SMP
machine)?  What is the cost of THREADED_DELTA_SEARCH for single process=
or
single core machine?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
