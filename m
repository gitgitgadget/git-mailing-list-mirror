From: =?UTF-8?B?UsOpbXkgSHVic2NoZXI=?= <hubscher.remy@gmail.com>
Subject: Improving the git remote command
Date: Tue, 26 Aug 2014 11:29:32 +0200
Message-ID: <53FC537C.4080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 11:29:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMD4N-00034z-9v
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 11:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934171AbaHZJ3f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2014 05:29:35 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:42558 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458AbaHZJ3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 05:29:35 -0400
Received: by mail-la0-f45.google.com with SMTP id ty20so14662154lab.4
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 02:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=KcCOv99zShB1PvUFJPveY9G6FOv7EYxB1u1rZdPuunA=;
        b=kyi/lVU3RBy3pNb2quwazdHYHNY8JuiQn5fRi0xQqgywbeCHkTSRhCpwhR9KVea3vd
         Qo2kItUDbkJ33zCEba77YBNYipppeLE4YQjNrOzL2sDBRW8eX0T41OSfh9RaqMW6xlcr
         LpVUac1XrvRLJQP9gM27VlwnOvbLmSrIhF3md/mH3A930ghhP/aVhzkDXxCyIT50Fead
         7/oaoIUPDZxVgWpB6krJiQyzOf8jogZAEofZL2RuBmEJ/Osm93RGdLbSXsHVBL/aHdJ6
         D9srMOBsd/AIsfNvnRxB4Z0XpI8bEoJ/RaRXyZawmzJ9uBp93qupjumVq+LY86fpXVpy
         Zs0g==
X-Received: by 10.152.25.170 with SMTP id d10mr25978670lag.37.1409045373644;
        Tue, 26 Aug 2014 02:29:33 -0700 (PDT)
Received: from ?IPv6:2a02:908:e323:af80:7ccb:99f9:6eb3:396a? ([2a02:908:e323:af80:7ccb:99f9:6eb3:396a])
        by mx.google.com with ESMTPSA id ue4sm4324328lbc.0.2014.08.26.02.29.32
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2014 02:29:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255881>

Hi,

I'd like to add a list parameter to the `git remote` command.

We already have:
=20
 - `git remote add`
 - `git remote rename`
 - `git remote delete`

I often write `git remote list` before finaly using `git remote -v` but
it isn't intuitive.

I am proposing to add `git remote list` as a shortcut for `git remote -=
v`

What do you think?

R=C3=A9my
