From: "Francis Moreau" <francis.moro@gmail.com>
Subject: git-send-email and aliases
Date: Mon, 26 Mar 2007 11:39:52 +0200
Message-ID: <38b2ab8a0703260239j3f3f0be2teee70fc502f6f7c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 11:40:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVlgF-0008Lx-90
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 11:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbXCZJj4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 05:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbXCZJj4
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 05:39:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:61629 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbXCZJjz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 05:39:55 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1540995uga
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 02:39:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oCt6MVR2o+EWvyPzQKfJMy1VwXC7Qcv6EYxOO5wt9TgG6FBq37I0ALn4BgNpm+OCcX+T0Rgc17Zk2c4d81dRFrIo0rZfpJLKziUsrrJhZOjX5U7LSsBsxWwUB8PDkK48KZdoFGQGM2wV8w+VtfYJBQiDRRd6WKfR82EMLRrEKO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pV/4+xmm1xcyMFwA6GGjRrZ7TCWNk1CkX5CeQNlGfDowYEUe4+tpcJNVAsABtgX0S1ZL31lH8fIDswx9ZIyj2iBc1WnP46mpOwg3WO0qfDYnJvM8T4nowhqgiBboDmUzSz2hOMrQ6lUiddxg4YX4UhrfKuFuVvka0a8wIleH34A=
Received: by 10.114.25.3 with SMTP id 3mr2567836way.1174901992690;
        Mon, 26 Mar 2007 02:39:52 -0700 (PDT)
Received: by 10.114.38.12 with HTTP; Mon, 26 Mar 2007 02:39:52 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43139>

Hi,

I'm trying to make an alias for 'git send-email' as following but it's
not working:

[alias]
	send-email = send-email --no-signed-off-cc --suppress-from

Is it failing because git-send-email is an external command ?

Thanks
-- 
Francis
