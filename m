From: "Bryan Richardson" <btricha@gmail.com>
Subject: Help reverting a particular file
Date: Mon, 11 Aug 2008 17:00:41 -0600
Message-ID: <3f81a4240808111600u78c5eeefu588a6b1250a0dd02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 01:01:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSgOX-0003Xq-VO
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 01:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbYHKXAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 19:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbYHKXAn
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 19:00:43 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:38530 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbYHKXAn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 19:00:43 -0400
Received: by yx-out-2324.google.com with SMTP id 8so827326yxm.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 16:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=adEls5QjV+6jcXe2eFt04nzhYt6swdB3vi7jr4eizQY=;
        b=jYBXWyWy6Y+6WWkIHKZ+CvGJ7G7dWVIZjSuDnDMbdO4okFliUSSJmRbIEbEdxEI/ML
         /CNFp6aEQnNm0MDDEARVyVo2auNdQcED4faxBaT7mm5SVyAD6YnwZzVyBpqKN1Ygzn8g
         GKRCwP2U0wURRIawnafqDiv2YSNKi5UL13/h4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Y3o7VRm4iTcUB99LpdIfIMQRCni9yIkpvSY/1I9w5+6wR060HLjE4J0P4erSYCH5L4
         JYzTsmpY6vnZh+PWhYxwmqn3Qjz3j+24c4O2ftcS9WBXWBAXAkzug98+hIzn6EiEX802
         0lOpUQUxv5Ag3e5P5vm4dQVtUqPZEhZXWxgWw=
Received: by 10.115.75.14 with SMTP id c14mr4140087wal.45.1218495641381;
        Mon, 11 Aug 2008 16:00:41 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Mon, 11 Aug 2008 16:00:41 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92018>

Hello all,

Can anyone tell me how to revert a particular file using git?  I
executed a commit, then froze my Rails application to the latest Rails
version.  This caused my custom config/boot.rb file to be overwritten
and I would like to restore it without rolling back to the previous
commit (which would roll back the rails freeze).  In general I need to
know how to do this anyway. :)

Please help!

--
Thanks!
Bryan
