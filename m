From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Git notes list/show <revision-range>
Date: Mon, 18 Apr 2011 20:19:59 +0200
Message-ID: <4DAC80CF.8020704@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>, bebarino@gmail.com,
	johan@herland.net
X-From: git-owner@vger.kernel.org Mon Apr 18 20:19:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBt3C-0004mx-Tf
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 20:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756284Ab1DRSTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 14:19:51 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52734 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761Ab1DRSTu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 14:19:50 -0400
Received: by ewy4 with SMTP id 4so1464185ewy.19
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 11:19:49 -0700 (PDT)
Received: by 10.213.103.137 with SMTP id k9mr4114141ebo.36.1303150789522;
        Mon, 18 Apr 2011 11:19:49 -0700 (PDT)
Received: from [145.94.80.223] (x080223.tnw-m.tudelft.nl [145.94.80.223])
        by mx.google.com with ESMTPS id x54sm4257122eeh.26.2011.04.18.11.19.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Apr 2011 11:19:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171752>

Hi all,

Considering a work-flow using topic branches just as the git development uses itself, I do miss a certain feature.

When a feature/patch is proposed, it will "cook" for a while in "pu" and "next". During this period people can comment on the patch. These comments can be stored in git notes added to the commits on which is commented.

At a certain point I want to decide whether the feature can be merged into "next" or "master", so I want to collect all notes for a certain branch to see what still has to be done before this feature can be merged. One can think about this of automatically generating a "What's cooking in X" listing
the topic branches and the comments for the commits in each branch.

That's why I want to (try to) implement the feature that 'git notes list' and 'git notes show' accept a revision range and collect all notes for the commits in this range.

Do you think this will be a useful feature and that it has chances to be merged into git ?

Vincent
