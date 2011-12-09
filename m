From: Manuel Stocker <stockema@gmail.com>
Subject: gittornado: A tornado-based implementation of the git-http-backend in Python
Date: Fri, 9 Dec 2011 14:34:14 +0100
Message-ID: <CAJza_0UYtyxU5qsfqPr7cJbMBu0_fxwpe2cOBC5w2BSj1+tsCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 14:34:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ0al-00052U-Ru
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 14:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730Ab1LINeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 08:34:15 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61121 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab1LINeO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 08:34:14 -0500
Received: by iakc1 with SMTP id c1so4243412iak.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 05:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=6ZGdnE79BTB3gOSwS2o8htg6cLnGsohHHRq9FRA0U0M=;
        b=WAnyKAW/VMUbiWV+6GZ7LrHtpl/3ObNRGrOgxuSOXyi38scYBepzD9WMd840Lk36oI
         NwIoNxg9b4FS97FIl7n5m9HPwDZtbGf9rwVImL1XvXUfwSXX1202mGzcoEJD1H2H3zCb
         Pdm4NFR1ElwLUdXPa++h8EyxCd3/L0kNVEVkU=
Received: by 10.42.135.69 with SMTP id o5mr2888002ict.34.1323437654177; Fri,
 09 Dec 2011 05:34:14 -0800 (PST)
Received: by 10.50.242.106 with HTTP; Fri, 9 Dec 2011 05:34:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186633>

Hi,

I decided to implement the smart HTTP protocol on top of tornado for
our codehosting platform. It is built as a library but also includes
an example of a simple server.

At the moment, it's in a stage where it is in daily use for accessing
git repositories by a diverse set of different git client
versions/flavours. I have not done any load testing or performance
benchmarking yet, but it should basically scale relatively well due to
it's event-driven nature.

You can find the code at https://github.com/mensi/gittornado

Feedback / patches are highly appreciated.

--
Manuel
