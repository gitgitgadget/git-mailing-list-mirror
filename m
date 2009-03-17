From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Local clone checks out wrong branch based on remote HEAD
Date: Wed, 18 Mar 2009 06:31:23 +0900
Message-ID: <20090318063123.6117@nanako3.lavabit.com>
References: <b97024a40903171219k8841508p774d9dc4295a09bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Tom Preston-Werner <tom@github.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 22:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljgut-0000Na-W9
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 22:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974AbZCQVcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 17:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbZCQVcE
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 17:32:04 -0400
Received: from karen.lavabit.com ([72.249.41.33]:35905 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755507AbZCQVcC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 17:32:02 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id E059111B846;
	Tue, 17 Mar 2009 16:32:00 -0500 (CDT)
Received: from 3365.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id TF1F0N6KJZ7G; Tue, 17 Mar 2009 16:32:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=xoHRQ+qJEUJQ00FGCWx5NS8ry4Ozh47F/M4DyrgfWhqrbG+qJ46lh7dWWhSb6+dK6FiZwaMKPmoD0d7lBgrBRbNoTSQYa+KEP856ateru16m0z2ZX0VeBCQET/h6c3ktqYqnJhCaYFx+Z2wyqouos97CAibFLSQ9Sr4ENbSr3bc=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <b97024a40903171219k8841508p774d9dc4295a09bc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113529>

Quoting Tom Preston-Werner <tom@github.com>:

> I'm guessing that the first branch that matches the remote HEAD
> revision is being checked out instead of the actual remote branch. I
> would expect the correct branch to be chosen regardless of where the
> branches are pointing.

Isn't this a known issue that can be found out easily from the archive?

  http://article.gmane.org/gmane.comp.version-control.git/27259
  http://thread.gmane.org/gmane.comp.version-control.git/101956/focus=101958
  http://thread.gmane.org/gmane.comp.version-control.git/102039

If I remember correctly, the two patch series from Junio wasn't accepted warmly and they were dropped.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
