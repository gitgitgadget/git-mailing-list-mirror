From: Laszlo Papp <djszapi@archlinux.us>
Subject: Clean the line endings in the repository history
Date: Fri, 25 Jun 2010 21:14:06 +0200
Message-ID: <AANLkTinqLnxNO7eHuvL3luEavaWsp6GpNW5o0d3F7wjA@mail.gmail.com>
References: <AANLkTilKdX-D_I9AqcpESdxngbuPB8RIgzo_eDBgcpsq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 25 21:14:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSEM0-000142-RK
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 21:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343Ab0FYTOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 15:14:15 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:38317 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320Ab0FYTON (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 15:14:13 -0400
Received: by wwi17 with SMTP id 17so1306372wwi.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 12:14:12 -0700 (PDT)
Received: by 10.216.182.7 with SMTP id n7mr906917wem.91.1277493246935; Fri, 25 
	Jun 2010 12:14:06 -0700 (PDT)
Received: by 10.216.163.6 with HTTP; Fri, 25 Jun 2010 12:14:06 -0700 (PDT)
In-Reply-To: <AANLkTilKdX-D_I9AqcpESdxngbuPB8RIgzo_eDBgcpsq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149704>

Hi,

What's the problem with this command ?
git config core.autocrlf input && git filter-branch --tree-filter true
--tag-name-filter cat -- --all

I am trying to clean my history with it, so I clean the working copy
and I do a git push --force and when I clone again this repository
into another folder and I try to run the above command again I
experience that It runs again instead of not running, because it was
earlier cleaned up.

What can be the problem ?

Best Regards,
Laszlo Papp
