From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on maxsize reached
Date: Tue, 4 Mar 2008 09:12:18 -0500
Message-ID: <118833cc0803040612g38dfc9f8tdb33ef866f6752e2@mail.gmail.com>
References: <200803041459.29000.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: "Michal Rokos" <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Tue Mar 04 15:13:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWXt3-00056J-DB
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 15:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbYCDOMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 09:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbYCDOMU
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 09:12:20 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:36683 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbYCDOMU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 09:12:20 -0500
Received: by fg-out-1718.google.com with SMTP id e21so923036fga.17
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 06:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=O97RNhAjwKCDHcNoCGE0+8bRCygnH+mqvhCjKF2pQXE=;
        b=uwbo4kUMBYZYChE7JLTzM8N+hEC2KrjTE9OV9nOrtjmYOonf4qozxQ4MygnvI61XGpOqCo30Nw8j2DFGAyCsWlwTk2FQAOy9fkBk8PVr6rOz5LYtukokRvucArA+TwRVRflJ+P3YvbDQog1mor47svL3ixTDYt/DD36yxkKojMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KkoxJ3Eiltdtx6F/GRJN3dR1qQRefOMkfj9Rs9NxPAscsRKm5V8vrMEM1AG2qVw5CKFZcsZXTGnURGH5MzSikwVhU4FO1Uhw6qGbMiu6wa6+OC53Xf3iOVVptwfL2GqAPTr0e+Q1agbgjyi1Mzi9nzT2CeAaMfQHJuKxMXhx2RA=
Received: by 10.86.50.8 with SMTP id x8mr1329954fgx.25.1204639938483;
        Tue, 04 Mar 2008 06:12:18 -0800 (PST)
Received: by 10.86.89.14 with HTTP; Tue, 4 Mar 2008 06:12:18 -0800 (PST)
In-Reply-To: <200803041459.29000.michal.rokos@nextsoft.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76087>

That leaks in the out-of-memory case.  Not terribly important, but still.

Morten
