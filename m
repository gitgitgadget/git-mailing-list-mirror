From: Marcus <prima@wordit.com>
Subject: Reverting to old commit
Date: Tue, 27 May 2008 18:50:31 +0100
Message-ID: <8345bd80805271050q7412917bt292a276fbbe6aed3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 19:51:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K13KW-0007qY-My
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 19:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580AbYE0Ruc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 13:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755515AbYE0Ruc
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 13:50:32 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:3039 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212AbYE0Rub (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 13:50:31 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3056901rvb.1
        for <git@vger.kernel.org>; Tue, 27 May 2008 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=vJ/+3YdwzlsSEA7CkchFUK6LPwchB+A8XUxoTABnwpQ=;
        b=LmP+huHa7GyWIxVaPZudj0YqgjnVdy49UgSuwiD1ZpXm55JPprmrcjV4SCUvMWESlp12IT0KYZG5CvpncLj5BM5yws1q16Tc3ALxf6aWQP9T6B6AC3MRXv+pCOLj9wpjOUE6HbA2mh2J11LI0hvTNhrJtaRk5eiDwGF9hMpc5+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=DTy9wS+4EvV1oofVjKAiOxascJc7SJhVb2M6DVzs6u2vp5ZWjKMDu2OC9KPRduEYfv77PDPlxUhNVTBZpr282yKQG+fcVUSev9zBJwBu5tQXihj6AbvQ3MPF+TKpjiKgiQHg1OHPEUBpSelVeSd/d6VDnmcPQ5MsZWv7okA+XQs=
Received: by 10.141.164.13 with SMTP id r13mr665013rvo.150.1211910631364;
        Tue, 27 May 2008 10:50:31 -0700 (PDT)
Received: by 10.141.202.7 with HTTP; Tue, 27 May 2008 10:50:31 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 043abde6bcc5f3d3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83032>

Newbie question: What's the simplest way to find an old commit and revert?

Say you have a version from yesterday which worked and today's
experiments failed, so you want to go back to that working version.
Unfortunately, it's not tagged. Instead you need to actually view the
code to identify the version you want. I thought maybe gitk might
help, but I can't find my way with gitk. I hoped you could browse
revisions easier in a GUI and tell gitk or git-gui to revert?

Thanks,

Marcus
