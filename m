From: Richard MUSIL <richard.musil@st.com>
Subject: git-svn: commit author x commit committer issue
Date: Wed, 08 Aug 2007 15:46:19 +0200
Message-ID: <46B9C92B.3000000@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 15:46:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIls0-0004ik-Dn
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 15:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbXHHNqf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 09:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765994AbXHHNqe
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 09:46:34 -0400
Received: from s200aog14.obsmtp.com ([207.126.144.128]:40886 "EHLO
	s200aog14.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765769AbXHHNqd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 09:46:33 -0400
Received: from source ([164.129.1.35]) (using TLSv1) by eu1sys200aob014.postini.com ([207.126.147.11]) with SMTP;
	Wed, 08 Aug 2007 13:46:25 UTC
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C6F9DAC4
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 13:46:21 +0000 (GMT)
Received: from mail1.prg.st.com (mail1.prg.st.com [164.130.59.16])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B9D0D4C077
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 13:46:20 +0000 (GMT)
Received: from [10.139.4.224] (pcdyn4224.prg.st.com [10.139.4.224])
	by mail1.prg.st.com (MOS 3.7.5a-GA)
	with ESMTP id CIL34790 (AUTH "richard musil");
	Wed, 8 Aug 2007 15:46:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55319>

Normally, when patch is applied, git distinguishes commit author and
commit committer (relying on info from patch).
However, after the patches are committed to svn repository using:
git-svn dcommit
author and committer data are set to same values (or at least time and
date, I cannot verify it for names).
I wonder if there is any reason for this behavior, because I would
definitely like to keep original commit info (which came from patch) in
my git repository.

Richard Musil
(please cc: me)
