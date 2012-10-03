From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 03 Oct 2012 12:25:46 +0000
Message-ID: <1349267146-ner-5314@calvin>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<vpq626s6kwu.fsf@grenoble-inp.fr>
	<CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 03 14:27:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJO2o-00043M-KY
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 14:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab2JCM1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 08:27:06 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:48864 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab2JCM1F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 08:27:05 -0400
Received: by wibhr7 with SMTP id hr7so2329488wib.1
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=MplaqoyFEmPn1JoqcBXvaxHj5aibRPW8PBfo/JdtsqA=;
        b=x+UWqWsk+f9W7wxYuHl/DWG5634nvrCdSrNqxDO0PXcnxEj65ub5fUIGzY/XYs1wYG
         ZzxSQopZjxKXQ/JGPcSOwtMnYwwfBcPbGmKiwySzKjkJCYL9RUqy/c3IzebagPh/fFsg
         GFIiz/9xie8dWZqIhP2Lec3djZu8sBbvfvEcMfeZlsF4v1QzC+BC4aaaIedn853OpqiV
         I0Ix3Lj+Hltcc9yzcmgDrXPfUyqLtrlXHGYqHN8foReLTNSKUdz6iNJ8L2Y6bx1DvyaS
         MvuJPmv6zTXCQnj2ymzMTonCnSAqScPz2wyD2vwKA+VuH60BpOjf8bBR6aPuQNtway2H
         iHdQ==
Received: by 10.180.93.106 with SMTP id ct10mr4667464wib.8.1349267223012;
        Wed, 03 Oct 2012 05:27:03 -0700 (PDT)
Received: from calvin.caurea.org (cust.static.46-14-151-191.swisscomdata.ch. [46.14.151.191])
        by mx.google.com with ESMTPS id l6sm26682929wiz.4.2012.10.03.05.27.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Oct 2012 05:27:02 -0700 (PDT)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id B7162D1ED1; Wed,  3 Oct 2012 12:25:46 +0000 (UTC)
In-Reply-To: <CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206885>

On Wed, 03 Oct 2012 10:24:00 +0200, Angelo Borsotti <angelo.borsotti@gmail.com> wrote:
> create a new one. To force it to create a brand new one I added
> --allow-empty to it
> because the man page stated that it would bypass the check that prevents to make
> a new one. The I discovered that sometimes --allow-empty does not behave as
> expected.

The documentation only states that it will skip the 'same tree as parent'
check, not that it will *always* create a new commit.
