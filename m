From: Enno Weichert <enno.weichert@gmail.com>
Subject: Subject: Something like cat-file for the index?
Date: Fri, 10 Jan 2014 12:53:35 +0100
Message-ID: <CABtFQN6n_FKTfGt1ubkL51t8n_iJ0vcYW4ZEYLOkAsFNCq0GQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 10 12:53:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1aei-0004ZK-QK
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 12:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbaAJLxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 06:53:37 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36616 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbaAJLxg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 06:53:36 -0500
Received: by mail-ie0-f178.google.com with SMTP id lx4so5003020iec.37
        for <git@vger.kernel.org>; Fri, 10 Jan 2014 03:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=wTd5avm8aU1mW6A6BgiBsGeseUSQb5t81rVnyHHvY+8=;
        b=QkLOHczQTpUcFrYj2n50yFBcuvsAK4gti2Z4VqC5Qy+dmslT4PFq4Cq+ltJ3OkvOCa
         CDB8VfSwdbE2WUnkYvjLvtPq/g43oc2yPjPLfcR6WOuMBRS/Day/iRwXpWAhMfLg2oY/
         O1/ES7v97Ihmo4eCmPlgP4KcZjG/CUsPxJDS+QI6nquAU3oNp5H3TyBpyvWBZqRhbJNv
         lquX3RXPXON8MSsKWQ/tC5WJGCWyJDjDskKmjBol0w8JlWrf1q8GMKXdCLYZyb0K7UAJ
         Hxrv0k3REZd6pEswTOlzcOm0O2r3UzQDdZUxPr1Gp0eViStrV5QCRCdQEMyQKfvSI4y+
         LN+g==
X-Received: by 10.50.22.72 with SMTP id b8mr2765858igf.13.1389354815995; Fri,
 10 Jan 2014 03:53:35 -0800 (PST)
Received: by 10.64.17.233 with HTTP; Fri, 10 Jan 2014 03:53:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240300>

Hi,

I'd like to have a more technical look into the index file and what/how it
stores data; call it educational spelunking.

I know the index-format.txt but I'd really like to save me the work to
implement a pretty-printed output based on it.
I know ls-files but that's obviously not the whole thing.

So: is there something like cat-file, that basically gives me a readable
version of the information (version number and all...) in the index already
implemented or did nobody care until now?
