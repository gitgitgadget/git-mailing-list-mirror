From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT] Supported Eclipse version
Date: Thu, 24 Jul 2008 15:57:02 +0200
Message-ID: <48888A2E.4030302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 15:58:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM1Kc-0007bb-DF
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 15:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbYGXN5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 09:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752883AbYGXN5I
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 09:57:08 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:3023 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbYGXN5H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 09:57:07 -0400
Received: by ik-out-1112.google.com with SMTP id c28so2168538ika.5
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=8PJmST3s6HHqGdUp4ChvjSCvxAOZHTo3YwSs7hx+NsA=;
        b=uzBdIHxeofQOFMg3JDifbfN11wPlehLS8DQqZfxfn69ByGPA//HjVUgMbkXoSj4KlD
         7unuEs4Ly5UV29yRVcuuVBs3XYwupc67MDrX7xao7LJcEmvQ4MqkbfY8hjx59gt16DId
         2oIUKflI4xKHc99qxsJJRqmjWmV+gIqpWzAyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=E6MPokoo8FqUiixKQn6TeUZkLSD1Xja9j6XV2EDEd+lON25efcpGMn3CdGvLB7LXAI
         fxP15eXbzgyk+5vX1r/CIV1hGMbkXORxzJsu6K5Sl9B6PojmHOgSdQIzChtU52FzBp7H
         CnEM0hUDOcYeYDwD7Isc1PHEm81ghb39f5kFw=
Received: by 10.210.26.10 with SMTP id 10mr390013ebz.63.1216907825523;
        Thu, 24 Jul 2008 06:57:05 -0700 (PDT)
Received: from ?192.168.1.167? ( [150.254.6.130])
        by mx.google.com with ESMTPS id h6sm25161693nfh.29.2008.07.24.06.57.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 06:57:04 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89882>

This topic arose after 3.4 release. Are we dropping support for 3.2.x 
release or not?

I've recently reported some bug at eclipse.org bugzilla regarding broken 
FileDialog for 3.3.x  and it was closed, marked as resolved in 3.4 with 
comment that 3.3.x stream is finished. Actually, this bug is not 
critical, just annoying.

It just seems that eclipse.org is trying to force users to update their 
Eclipse soon after next stable release.
3.3 also added some interesting APIs, Robin mentioned it one day. I'm 
currently just touching TableViewer API and it also have some nice new 
features being available since 3.3.

Do we still have to be compatible with 3.2 release? It's about 2 years 
old, with last synchronized release/build February 2007. On the other 
hand, some commercial tools are still based upon 3.2 release.

Maybe some users (or developers) from mailing list can tell us about 
their opinion?

Marek Zawirski
