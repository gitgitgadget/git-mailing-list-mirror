From: Michael Toy <michael@toyland.org>
Subject: git-status -- trying to understand all possible states
Date: Tue, 1 Apr 2014 13:07:33 -0700
Message-ID: <4AF06B83-E928-4FE2-8094-F23CE3BA1EBC@toyland.org>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 22:07:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4yE-0001st-3k
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 22:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbaDAUHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 16:07:37 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:42803 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbaDAUHh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 16:07:37 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so10090197pde.29
        for <git@vger.kernel.org>; Tue, 01 Apr 2014 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:content-type:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=tiFAZlw57faHK2h2TiwgCOKEGqVA8vb4dZtKpFgQHrI=;
        b=pgw5zB9k+5qni76d/ei6lym0C3/htTk3psI+S2zgbOAvir/gRKFOg05LA2tq3XJ/IL
         8fWcHBGmzvH4GGJJ/poYJJlrzVLQGBmsQYudDW4PP7V53OQ5bhtnpRTLgMVIzToGW+VA
         SnsHtTABn0s48wssrjm+l+KU+dSbXPbX2g+lk5DrvHHNJNUzoaHRdMX4U2sE4A2/jJLh
         fRMS71NNjv3dShhqzBapLC7sfSg0EOmmWbX5swgc0z9aMW6iZqMRZbfjMEmeACK4AJpc
         BTfLPbiuPTmWJ+iMLgOkKMuxz7zzRO7k7NcCmHoZ4t99ctMahwPcxAcsGZ4F+N+UV+A7
         zTag==
X-Received: by 10.66.65.204 with SMTP id z12mr33044919pas.60.1396382856271;
        Tue, 01 Apr 2014 13:07:36 -0700 (PDT)
Received: from [10.0.1.106] ([63.249.67.138])
        by mx.google.com with ESMTPSA id au16sm59875246pac.27.2014.04.01.13.07.34
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Apr 2014 13:07:35 -0700 (PDT)
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245651>

I also have this question posted to stack overflow ( http://stackoverflow.com/questions/22792906/how-do-i-produce-every-possible-git-status ), but perhaps this is a better place to ask this question.

In working on some code which provides an interface to existing git repositories the question I had was "what actions should I present to a user", which lead to the question, "what does a user need to do to generate that condition", which lead to developing this gist:

https://gist.github.com/the-michael-toy/9907309

... which is a ruby script which tries to produce a repository with a file in every possible "git-status" XY condition

Of the 24 possibilities (not counting ignored) in git-status, there are 7 that I can't figure out how to generate.

D           M    deleted from index
C        [ MD]   copied in index
D           D    unmerged, both deleted
A           U    unmerged, added by us
U           A    unmerged, added by them

any clues, including pointers to "just go read XXX" would be appreciated.
