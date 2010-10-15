From: David Barr <david.barr@cordelta.com>
Subject: [PATCHv2] Add support for subversion dump format v3
Date: Fri, 15 Oct 2010 23:54:11 +1100
Message-ID: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 15 14:55:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6joh-0007tx-Pq
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 14:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931Ab0JOMzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 08:55:04 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:37222 "EHLO
	mail08.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755648Ab0JOMyd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 08:54:33 -0400
Received: from localhost.localdomain (d110-33-95-167.mit3.act.optusnet.com.au [110.33.95.167])
	by mail08.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id o9FCsPsk006314;
	Fri, 15 Oct 2010 23:54:27 +1100
X-Mailer: git-send-email 1.7.3.32.g634ef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159117>

This series follows Jonathan Nieder's svn diff applier series.

Patch 1 adds the required infrastructure to fast-import.
This features the addition of the cat-blob command to
fast-import. This allows access to blobs written to the
the current pack prior to a checkpoint and is critical to
retrieving full-texts to drive the diff applier.

Patch 2 adds the basic parsing necessary to process the v3 format.

Patch 3 adds logic around decoding prop deltas.

Patch 5 integrates svn-fe with svn-da to decode text deltas.
It is based on a large patch authored by Jonathan and inspired by Ram.
It has been heavily trimmed to reduce code bloat and enabled me to
determine the logic for the previous patches.

A bit shout-out to Jonathan Nieder and Ramkumar Ramachandra for
their help in bring this series into existence.

I have tried to incorporate all the feedback on the list and over
at #git-devel. I hope to impress.

--
David Barr.
