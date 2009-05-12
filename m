From: Caleb Cushing <xenoterracide@gmail.com>
Subject: git push origin error (1.6.3 new default functionality)
Date: Mon, 11 May 2009 21:26:19 -0400
Message-ID: <81bfc67a0905111826y779555cer6679da11db787ab1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 03:26:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3glH-00009T-JC
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 03:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbZELB0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 21:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754611AbZELB0T
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 21:26:19 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:24303 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205AbZELB0T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 21:26:19 -0400
Received: by an-out-0708.google.com with SMTP id d40so10906241and.1
        for <git@vger.kernel.org>; Mon, 11 May 2009 18:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=PIen0AwG2et/my0mOrMQS32yWbva6ySNQ3mKZss66nc=;
        b=emAKwke2HKPVFM3ARdL5/E9s4FgORqfKgdu/YBx4KCeUh0iCtiLVU/d1IQN14Wqkhv
         hSS/ERV4qp/SWUqhm3o9OWgLHHYEE0VaIJ7xlTn2A3tBfoWmeiVsIB7HtoJZa0VipUij
         3pnt2mJBAelO5xH4qWR8qNIEPunAJV2JBMpYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=XB5y3VUuk1pVOc6FabzcRBsKoZLgE1jRB9pxAe2+ADUY7H5eiA47KhyuAd+VHZnnY9
         FxLwMAaucuvP5CL7l/epwCfcSJYduSg/FNniiQi1AtYADrnGdlSXM18F49gtKb+VAa4k
         5sVoKUycCA+GGDGQxHAMElyMvB4yLzSLLNyUI=
Received: by 10.100.6.13 with SMTP id 13mr18761755anf.98.1242091579376; Mon, 
	11 May 2009 18:26:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118866>

in the past git push origin would just push all matching branches to
the remote, and it worked. the new error says that's still the
default. The new functionality is nice, but is it really the git way
to yell at you if you haven't explicitly set the default? I think the
default should remain the default, and it should continue to work
without yelling at you for not explicitly setting it. if you want to
change it that's fine.

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
