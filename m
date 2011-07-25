From: Christoph Blank <sol@textmode.at>
Subject: Http/s authentication failure with some git versions
Date: Mon, 25 Jul 2011 15:23:17 +0200
Message-ID: <20110725132317.GA21590@tp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 25 15:23:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlL83-0006th-Ee
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 15:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab1GYNXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 09:23:23 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:58189 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab1GYNXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 09:23:22 -0400
Received: by fxd18 with SMTP id 18so9076647fxd.11
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 06:23:20 -0700 (PDT)
Received: by 10.223.15.141 with SMTP id k13mr6735262faa.118.1311600200781;
        Mon, 25 Jul 2011 06:23:20 -0700 (PDT)
Received: from tp (clnet-kmu02-090.ikbnet.co.at [83.175.88.90])
        by mx.google.com with ESMTPS id 12sm3288583fad.40.2011.07.25.06.23.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 06:23:19 -0700 (PDT)
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177795>

Hey, 
Following command: 
git clone "https://git%40app.example.com:myp...@git.example.com/app-comm 

This works fine with git versions: 
1.7.4.1 
1.7.6 

and fails with: 
1.7.1 
1.7.2.5 
1.7.33 

does anyone know why, or if there was a particular bug fixed? 
I don't want to upgrade git on the production systems without a reason..
Can't find anything and I'm getting desperate...

Thank you,
Christoph
