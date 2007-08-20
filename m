From: "Frank Showman" <fshowman@googlemail.com>
Subject: Splitting up a changeset
Date: Mon, 20 Aug 2007 15:32:11 +0200
Message-ID: <e1bf234c0708200632g3a2282bfr76863555493d513@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 15:32:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN7Mg-0002U7-U9
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 15:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655AbXHTNcQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 09:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbXHTNcQ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 09:32:16 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:17408 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbXHTNcP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 09:32:15 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1834899mue
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 06:32:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=o8neaX5JenYypazIEUL8MifqqYMFnjnAwX1KR1FPWCv8cRyVt3VFhf3toDp+yhHWH6vRpdU0yWkBK4DB17EbxiOLtqf7Ovn1YFsQDLxUGu3JhSdypGXegF1uxha/w5t3Z7bjNzb9DpO8Gib28Gk1vMyaOoHe2GuBx5tP7+WYhWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pPj7vjUrs+nQxccEYxX0wuCs5V5mZUvIlpnfDrEW7KrQjS9VWcsDHWzWGhDa9Fn0VwRjRB+04/pizcugJIEXXN72FAHO7eqY5UyZPySzsO/pahXabBWRTAgB/V6Aa1fq22EaQhUPxkd+wXTG+NryzT56lf75c8slGzKgHkTi2vg=
Received: by 10.82.158.12 with SMTP id g12mr7772921bue.1187616733061;
        Mon, 20 Aug 2007 06:32:13 -0700 (PDT)
Received: by 10.82.184.13 with HTTP; Mon, 20 Aug 2007 06:32:11 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56217>

What I really want to do is merge a couple of files from a changeset
at a time. Given that GIT doesn't track files, the only sensible way
to do that seems to split up the changeset (I want GIT to track the
merges) and then merge (cherry pick) the split up stuff.

Is there some (reasonably simple) way to do that? What happens to
remote repositories that already have the big original changeset (and
possibly changes based on it)?

-- Frank
