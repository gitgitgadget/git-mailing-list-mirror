From: Michel Lespinasse <walken@google.com>
Subject: gitk --show-notes support in git.git repository
Date: Tue, 22 Jun 2010 15:21:35 -0700
Message-ID: <AANLkTilrNpJJgOmW06SdKATP1wkhX8uflcKQ_IXOKrIP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 23 00:21:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORBqi-00088f-D9
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 00:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab0FVWVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 18:21:39 -0400
Received: from smtp-out.google.com ([74.125.121.35]:43550 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413Ab0FVWVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 18:21:38 -0400
Received: from hpaq5.eem.corp.google.com (hpaq5.eem.corp.google.com [172.25.149.5])
	by smtp-out.google.com with ESMTP id o5MMLbid020046
	for <git@vger.kernel.org>; Tue, 22 Jun 2010 15:21:37 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1277245297; bh=JWGz3MuxZ9Pv2N/K5tj7wQNdy90=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type;
	b=buMpipH0Rn7IfWCy3KL9a55QqOMsgwo6yi8KDF+hF5O6eg893T5HI0WuvURC9U2ju
	 vEwwuQs1iSk5xA02XQ3fQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=mime-version:date:message-id:subject:from:to:content-type:x-system-of-record;
	b=sutbhI4Yg1i9Qar6SkJlnILfh+BLABY4g5Lmj/4eulm1SD/gY5y25NojO4ZgV1EvT
	OfY04NzSakVInuCW/BBgw==
Received: from gyg10 (gyg10.prod.google.com [10.243.50.138])
	by hpaq5.eem.corp.google.com with ESMTP id o5MMLZFA026958
	for <git@vger.kernel.org>; Tue, 22 Jun 2010 15:21:36 -0700
Received: by gyg10 with SMTP id 10so3469971gyg.20
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 15:21:35 -0700 (PDT)
Received: by 10.229.237.144 with SMTP id ko16mr3604075qcb.68.1277245295366; 
	Tue, 22 Jun 2010 15:21:35 -0700 (PDT)
Received: by 10.229.78.11 with HTTP; Tue, 22 Jun 2010 15:21:35 -0700 (PDT)
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149495>

Hi,

I notice that the gitk version in
git://git.kernel.org/pub/scm/gitk/gitk.git now uses --show-notes by
default, but this change has not been pulled into
git://git.kernel.org/pub/scm/git/git.git yet. Is there any reason not
to ? I am eager to see notes getting more widely supported.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
