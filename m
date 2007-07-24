From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: copying objects from another repo?
Date: Tue, 24 Jul 2007 13:35:03 +0300
Message-ID: <20070724103503.GC18701@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Tue Jul 24 12:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDHjU-0006wd-2J
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 12:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbXGXKfI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 06:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840AbXGXKfI
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 06:35:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:23652 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbXGXKfH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 06:35:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so129100ugf
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 03:35:05 -0700 (PDT)
Received: by 10.67.30.3 with SMTP id h3mr529516ugj.1185273305348;
        Tue, 24 Jul 2007 03:35:05 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.35.163])
        by mx.google.com with ESMTPS id 20sm164817uga.2007.07.24.03.35.04
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2007 03:35:05 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53559>

I had some missing objects that I managed to locate
in another tree. So - how to get them to my repo?
Here's what I came up with:

cd ~/scm/good_tree
git tag -f foo dfaa7049e9ebe227cfcffc49d3de16716764bcbd
cd ~/scm/bad_tree
git fetch-pack ~/scm/good_tree dfaa7049e9ebe227cfcffc49d3de16716764bcbd

And I repeated this for all missing objects.
But is there a better way to do this?

-- 
MST
