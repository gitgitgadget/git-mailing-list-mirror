From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Fetching a single file from remote repo
Date: Mon, 13 Aug 2007 11:31:50 -0700
Message-ID: <a1bbc6950708131131q74525060x85d5e31c6a538f76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 13 20:32:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKeiO-0000ru-31
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 20:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S974486AbXHMSb6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 14:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1033095AbXHMSb4
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 14:31:56 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:38877 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S974492AbXHMSbw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 14:31:52 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1240831rvb
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 11:31:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Y42HtkreHBXOhE9VX/3qHefNiYmYNUdKQEtEuKh1N9G0fqsYvF9BdW/pqUcenRJM+W3hS776nVogWnSCj0UAFLGa/Godm99Li1aDADqW2df6ZptgU3gceJgPju8LoxWc4IaUDYXkV73YeydxNAYUqv27ibVaZ9rS+u8herE1VpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YmXj9lpykXNtZgCiKhAMtAJef5KCSOA/Yy1nVPqtg3aKqSb1x0UVODX7JVuhynN7TbZW94qppKZ4jV9XNC/AkAJy7eOemjM8JPs+Rrly5iVEPLsLR59XIDc8RX+sHVbkpt2O8BKcZXmYNShraO1KQ+GLj5Q7Bvp+KfC7p/gtjP8=
Received: by 10.141.42.10 with SMTP id u10mr2675069rvj.1187029910434;
        Mon, 13 Aug 2007 11:31:50 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Mon, 13 Aug 2007 11:31:50 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55776>

Is there a way to fetch a single file from remote repo without
creating a client repo?
I want to do something like
  git show --repo git://repo.or.cz/bla.git master:/somedir/file.txt

-- 
- Dmitry
