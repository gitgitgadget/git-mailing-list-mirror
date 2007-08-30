From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: gitk startup time improvement
Date: Thu, 30 Aug 2007 16:16:53 +0100
Message-ID: <e1dab3980708300816l5fee87a1pade9701c1bfb165@mail.gmail.com>
References: <18134.45449.527540.940620@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 17:17:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQllT-00081O-Bo
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 17:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760727AbXH3PQ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 11:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760608AbXH3PQz
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 11:16:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:34809 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760691AbXH3PQz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 11:16:55 -0400
Received: by wr-out-0506.google.com with SMTP id 36so432758wra
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 08:16:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nNtIN0HyKZwzv26hyq+IRgl0ZLuOv71l/29jG1xjGoC9aZQoGn/hbtgz4QLgF3hGNsAk2FmayXsF+fMpLU40yD/wPJtgW3T1KUjwPOFO+of4reOeQvmF7kvYzEKpC+vt0wzX0SKJ2O3/UHqWO5vrC3LmDyE6COjV1YWxZq0+oek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rGy11FtDVseOmPY08NHlqOD+s+7HYVAYkFg3jCY4H/CzpkGeQ1x3uHmkOtFcwNfapFnkSU7wAQR2IXO8MtfiYm0zSyhGf5kvX3W/IvYI0ZlHNptXYKzzefdPatWL3reNS/uXrVXtaXd+BCYI5dRnjUdv8R4YIgNEHhVJIENuvUY=
Received: by 10.100.121.12 with SMTP id t12mr487655anc.1188487014024;
        Thu, 30 Aug 2007 08:16:54 -0700 (PDT)
Received: by 10.65.81.12 with HTTP; Thu, 30 Aug 2007 08:16:53 -0700 (PDT)
In-Reply-To: <18134.45449.527540.940620@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57045>

On 8/30/07, Paul Mackerras <paulus@samba.org> wrote:
> I'd like people to try it.  Comments, bug reports, patches etc. are
> welcome, of course.

My main repo is too small to show performance issues as of the gitk
version included in 1.5.3.rc5, but FWIW the startup times for both
1.5.3.rc5 & your branch are both less than 1s (with warm cache).

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
