From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: rebase edit handling
Date: Wed, 13 May 2009 10:18:27 +0200
Message-ID: <589ffd8942fd21b6f727163f78592381@mail.hotelhot.dk>
References: <fcaeb9bf0905122351y3a1235e8s5cc9b83c225ca9c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 10:18:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M49fi-0003nf-40
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 10:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926AbZEMIS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 04:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754858AbZEMIS2
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 04:18:28 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:37942 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583AbZEMIS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 04:18:27 -0400
Received: from ajaxmail.hotelhot.dk (web.hotelhot.dk [192.168.0.170])
	by mail.hotelhot.dk (Postfix) with ESMTPSA id 367AC44FA;
	Wed, 13 May 2009 10:18:27 +0200 (CEST)
In-Reply-To: <fcaeb9bf0905122351y3a1235e8s5cc9b83c225ca9c6@mail.gmail.com>
X-Sender: mail@cup.kalibalik.dk
User-Agent: RoundCube Webmail/0.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119003>

On Wed, 13 May 2009 16:51:33 +1000, Nguyen Thai Ngoc Duy
<pclouds@gmail.com>
wrote:

> Could we unit the way to squash/edit commits in rebase? If I squash a
> commit it, I need to to update the index and continue rebase. If I
> edit a commit, I need to amend that commit. The problem is when I have
> a few edits/squashes in the same rebase, I easily get confused and do
> "commit --amend" on squash too.

A squash does not leave you at the prompt, unless you abort the editor
with the concatenated commit messages. So where does your confusion
come from?

Anyway, here is a (fruitless) thread on the confusing UI of interactive
rebase:

  http://thread.gmane.org/gmane.comp.version-control.git/105738

Maybe it answers your question in some way.


Anders.
