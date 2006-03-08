From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: git-rev-list bug?
Date: Wed, 8 Mar 2006 16:19:48 +0000
Message-ID: <b0943d9e0603080819i227c637fo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Mar 08 17:20:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH1OC-00033o-VB
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 17:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWCHQTu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 11:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWCHQTt
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 11:19:49 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:31589 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932065AbWCHQTt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 11:19:49 -0500
Received: by xproxy.gmail.com with SMTP id h31so156297wxd
        for <git@vger.kernel.org>; Wed, 08 Mar 2006 08:19:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=P9bTf236mH6UET+zQb0rAIx+Iz7a5VYT4JEwG+Tu7L0T5yUIYDDRpQfMn1xY29WXKY7iqOcoq+abhkUmxWOxuDInSZvAwM8uHzsvFO80ubQNBsOHKIPD3xxJfmsks5CrPLz29riiRAp2KqJz6lmy4T8/I/jp+FJMive6qd65cUw=
Received: by 10.70.124.1 with SMTP id w1mr1018647wxc;
        Wed, 08 Mar 2006 08:19:48 -0800 (PST)
Received: by 10.70.31.4 with HTTP; Wed, 8 Mar 2006 08:19:48 -0800 (PST)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17376>

Sorry if this was previously discussed. I ran git-rev-list on a linear
graph and tried to filter the results by a file name:

  git rev-list since.. path/to/file

but it always shows the child commit of "since" even if it didn't
touch the file. The same behaviour is for git-log (since it uses
git-rev-list) but git-whatchanged seems to be fine.

Is this the intended behaviour? The "stg patches" command based on
git-rev-list used to work fine a few weeks ago but now it is always
reporting the bottom patch in the stack as modifying a given file.

Thanks.

--
Catalin
