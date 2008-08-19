From: "Alexander E Genaud" <alex@genaud.net>
Subject: Remote to a clone
Date: Tue, 19 Aug 2008 15:57:50 +0200
Message-ID: <ee521d6f0808190657k720e584fs9763bd98fa685616@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 15:59:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVRjd-0005H8-S8
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 15:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbYHSN5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 09:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbYHSN5x
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 09:57:53 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:24338 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbYHSN5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 09:57:52 -0400
Received: by mu-out-0910.google.com with SMTP id w8so4015269mue.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 06:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=YCbGBQYEAqiUFhssTZtYfiJCMW6deMlCv71STEFI2UE=;
        b=GeMlwG9ZjrU/Lv0qezvuB3p8pajeG4OngSBTEThGL0XSmFEgm2GMDB3cDlDkQikLmx
         tb5cOzyj2cMdVcSYLqdiOiOdzYbzu2uNt3X4+hPGaI/Es5A5Sg5OiE2Qu+8Wyeqi/VUN
         8RtKwKLZZDNHiFTB2w6O4wbm/Q6irlaf9oU3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Oj6jctL8pjxpx/Uw/jjYMnk7T93y0/hLO47WVeG9wUaDU8ShV574uo1V+O9YTliXK/
         TK2MyvsuM7LCtmKHNXmNcQPpDcj6WRvyguA3GyWQZ6SelqDeJjO6FBDwXqVl8xuJbVcV
         vhp6IuxdbgR4ucMhgLUTD4nd/TOlJ2fnVWOXo=
Received: by 10.103.175.9 with SMTP id c9mr4851907mup.15.1219154270438;
        Tue, 19 Aug 2008 06:57:50 -0700 (PDT)
Received: by 10.103.8.1 with HTTP; Tue, 19 Aug 2008 06:57:50 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 4c1fa61b79bbbc93
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92862>

Hi guys,

I have cloned a ClearCase snapshot and am considering setting each to
remote to the other. Is this a bad idea? How could it be done? The
snapshot will never have more than the master branch, while the clone
will have many.

I've only cloned because switching between branches makes a mess of
ClearCase notion of changes and hijacks (mod dates and write bit) and
resolving hijacks makes a bigger mess (.keep and .unloaded).

-- 
[ alex@genaud.net ][ http://genaud.net ]
[ B068 ED90 F47B 0965 2953 9FC3 EE9C C4D5 3E51 A207 ]
