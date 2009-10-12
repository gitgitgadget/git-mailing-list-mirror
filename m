X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Sergio <sergio.callegari@gmail.com>
Subject: Questions about the new
Date: Mon, 12 Oct 2009 10:23:40 +0000 (UTC)
Message-ID: <loom.20091012T115746-719@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 12 Oct 2009 10:27:57 +0000 (UTC)
To: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 34
Original-X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.183.7.34 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3) Gecko/20090910 Ubuntu/9.04 (jaunty) Shiretoko/3.5.3)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1MxI7q-0001dH-HJ for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009
 12:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755901AbZJLK0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009
 06:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755793AbZJLK0c
 (ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 06:26:32 -0400
Received: from lo.gmane.org ([80.91.229.12]:48594 "EHLO lo.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1754780AbZJLK0b
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 06:26:31 -0400
Received: from list by lo.gmane.org with local (Exim 4.50) id
 1MxI5o-0000Yw-Bb for git@vger.kernel.org; Mon, 12 Oct 2009 12:25:28 +0200
Received: from host34-7-dynamic.183-80-r.retail.telecomitalia.it
 ([80.183.7.34]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id
 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 12 Oct 2009 12:25:28 +0200
Received: from sergio.callegari by
 host34-7-dynamic.183-80-r.retail.telecomitalia.it with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 12 Oct 2009
 12:25:28 +0200
Sender: git-owner@vger.kernel.org




Hi,

I read from the release notes of git 1.6.5 about the new "replace" mechanism.
It is presented as "a replacement of the "grafts" mechanism, with the added
advantage that it can be transferred across repositories."

Since there is still little information about it, I would like to ask the
following:

1) Grafts and replace entries seem to operate on different aspects of the
history graph. Grafts operate on arcs and replace on nodes. 
As such, replace entries seem less general to me. 
Apparently, to simulate a graft with replace entries, you need to introduce
extra commit objects. For instance, if object B has no parents, to pretend that
it derives from some A, one needs to create an object B' equivalent to B but
for the parents and then replace B by B', is this right? Conversely, I guess
you can always simulate a replace entry with the graft mechanism, without the
need to add any extra commit object. Am I overlooking something? 

2) Is it currently possible to use a replace entry to replace a commit object
with nothing? Namely if B has A as its sole parent, is it possible to have a
replace entry such as A-sha1 becomes null, to pretend that B is a hierarchy
root?  

3) If I remember correctly, there was a reason why grafts were not considered
suitable for transferring across repos. Can someone remind me about it? How
does the replace mechanism address this issue?

Thanks,

Sergio
