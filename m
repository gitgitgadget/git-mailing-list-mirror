X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/4] Series short description
Date: Fri, 24 Nov 2006 00:16:27 +0100
Message-ID: <20061123230721.9769.38403.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 23:17:29 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32169>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnNor-0001cN-5B for gcvg-git@gmane.org; Fri, 24 Nov
 2006 00:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934249AbWKWXRT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 18:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934250AbWKWXRT
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 18:17:19 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:14044 "EHLO
 smtp5-g19.free.fr") by vger.kernel.org with ESMTP id S934249AbWKWXRS (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 18:17:18 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp5-g19.free.fr (Postfix) with ESMTP id AA9E927989;
 Fri, 24 Nov 2006 00:17:17 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch) by
 bylbo.nowhere.earth with esmtp (Exim 4.62) (envelope-from
 <ydirson@altern.org>) id 1GnNoy-0002st-F3; Fri, 24 Nov 2006 00:17:32 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

The following adds a --patch flag to "stg refresh".  I mainly needed it to
edit the log message in patches down the stack, but with some work it could
be used to record changes in another file and come back.

That would require to pop patches with --keep, and if we ask to only record
a subset of the changes, we would need to implement "push --keep" first.

This patch is not perfect, since it reverses a list twice, but I did not
find an elegant way to make it better.  Python gurus, feel free to improve
this :)

While I was at it, I noticed that "stg goto" need not revert the applied list
if we're going to an unapplied patch (sorta compensate my extraneous revert above ;),
and I noticed a DWIM behaviour on the (should-be)-erroneous "refresh --ack --sign".

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
