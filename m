From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: broken link - what is it?
Date: Tue, 24 Jul 2007 13:24:57 +0300
Message-ID: <20070724102457.GB18701@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Tue Jul 24 12:25:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDHZk-0003Yr-7o
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 12:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbXGXKZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 06:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbXGXKZE
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 06:25:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:12995 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbXGXKZC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 06:25:02 -0400
Received: by ug-out-1314.google.com with SMTP id j3so127960ugf
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 03:25:00 -0700 (PDT)
Received: by 10.66.221.17 with SMTP id t17mr512676ugg.1185272700665;
        Tue, 24 Jul 2007 03:25:00 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.35.163])
        by mx.google.com with ESMTPS id x33sm160246ugc.2007.07.24.03.24.59
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2007 03:25:00 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53557>

I seem to have a corrupted repo:

>git-fsck --full
broken link from    tree c907c09fee3e14adbc17c3e9d54c060b520303ba
              to    blob dfaa7049e9ebe227cfcffc49d3de16716764bcbd
broken link from    tree 00c8e1ed2de45bb57bd5482bf258efdfc28d5192
              to    blob 5909ec5314cebf884c03b2d85c7919eb40b5b424
broken link from    tree ee2144e186e78ce1ebbecfe10a6551ebc407f025
              to    blob 5909ec5314cebf884c03b2d85c7919eb40b5b424
missing blob 5909ec5314cebf884c03b2d85c7919eb40b5b424
broken link from    tree 79f14c41a69bf43069a6828769d8ee3ce86f6daf
              to    blob 5909ec5314cebf884c03b2d85c7919eb40b5b424
missing blob dfaa7049e9ebe227cfcffc49d3de16716764bcbd
broken link from    tree 5c3bb6f86743ced765fbcabe0ade6fc0a7e0f01a
              to    blob 5909ec5314cebf884c03b2d85c7919eb40b5b424
broken link from    tree 5f553908b5e2dfb6d53964c5e01ff596b91a61ba
              to    blob 5909ec5314cebf884c03b2d85c7919eb40b5b424
broken link from    tree 6f48bab6e09ae3d92cfdec8b6dec77b65a0968a7
              to    blob 5909ec5314cebf884c03b2d85c7919eb40b5b424
broken link from    tree 21fade55d91e78863920ecfe58767e007dcd4e74
              to    blob 5909ec5314cebf884c03b2d85c7919eb40b5b424

man git-fsck does not document what "broken link" is.
Can someone enlighten me please?

-- 
MST
