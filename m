From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] merge-recursive: move the global obuf to struct merge_options
Date: Wed,  3 Sep 2008 19:34:36 +0200
Message-ID: <cover.1220463034.git.vmiklos@frugalware.org>
References: <1220402349-7181-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 19:40:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KawHJ-0004V7-SO
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 19:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728AbYICRen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 13:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755826AbYICRem
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 13:34:42 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:59499 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805AbYICRel (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 13:34:41 -0400
Received: from vmobile.example.net (dsl5401C25C.pool.t-online.hu [84.1.194.92])
	by yugo.frugalware.org (Postfix) with ESMTP id 468331DDC5B;
	Wed,  3 Sep 2008 19:34:39 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 4C99184CC; Wed,  3 Sep 2008 19:34:38 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <1220402349-7181-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94823>

On Wed, Sep 03, 2008 at 02:39:09AM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> BTW, there are 3 leftovers: make_virtual_commit()'s virtual_id and the
> global current_file_set/current_directory_set. I guess all of them
> could be moved to merge_options as well. (I don't have more time today
> to do so, but I can do it tomorrow, unless you see some fundamental
> problem with it.)

Here are the two patches, that do this.

These, and the 4 other related patches which are not yet in git.git at
the moment are also available in the 'merge-recursive' branch of
git://repo.or.cz/git/vmiklos.git.

Miklos Vajna (2):
  merge-recursive: move current_{file,directory}_set to struct
    merge_options
  merge-recursive: move make_virtual_commit()'s virtual_id to
    merge_options

 merge-recursive.c |   80 ++++++++++++++++++++++++++++------------------------
 merge-recursive.h |    5 +++
 2 files changed, 48 insertions(+), 37 deletions(-)
