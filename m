From: "Andrew Arnott" <andrewarnott@gmail.com>
Subject: Re: How to rewrite author history
Date: Fri, 21 Mar 2008 09:41:14 -0700
Message-ID: <216e54900803210941i7fe345c2va850fa3ded8eabc8@mail.gmail.com>
References: <216e54900803210938q4981b5d1t535af419f5b15ad8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 17:42:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JckJb-0007HT-0j
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 17:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602AbYCUQlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 12:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755383AbYCUQlQ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 12:41:16 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:28484 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304AbYCUQlP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 12:41:15 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1726087wah.23
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+s2jFwlXYA12WQmUBU5XooBjkOo9BxyJS8bHly/q7Ak=;
        b=MllkVzcIp9oJV4+0Rr7C5QkSCSdc+AE0+KEaivp/XoMlb2pu1CYR8FLXG9GlUHf68R0XviBDaLwIpr/S7xWZvQioe4Rf5v9XXkjtYHQLRJtnZp+Ahx4cNuetyJsTPGcRbB9LGJIrophx7KL1Sd+NW7MgQYjRSUfgC2H3rMc3vVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D5bMAL1MiZoTdrF6pnbrOLNsVAFzInfPlvPpK7Y8fFJPRIR4knZAnz10KCSU/TxpTs53zrz2xFJJQjx/5FPtkKgsqmaXdf69aitV0qLNZAkt4/VjX+Qn7ZUfshLys0LvnyzirBWHwobVcg8qXRHqL/chslKfOUIkkBJFYfKQE2A=
Received: by 10.115.60.1 with SMTP id n1mr6232733wak.37.1206117674946;
        Fri, 21 Mar 2008 09:41:14 -0700 (PDT)
Received: by 10.114.94.20 with HTTP; Fri, 21 Mar 2008 09:41:14 -0700 (PDT)
In-Reply-To: <216e54900803210938q4981b5d1t535af419f5b15ad8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77748>

I imported my git repo from an SVN repo, and the authors have
email@SOME-GUID for their email address rather than their actual one
(probably courtesy of Google Code hosting).  Rewriting history and
changing all the commit hashes isn't a problem at this point in
development, so how can I do a massive search-and-replace to replace
several specific author emails with the valid ones?
-- 
Andrew Arnott
