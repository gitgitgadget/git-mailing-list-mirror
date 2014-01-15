From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: After stash pop, refs/stash become 40 zeroes
Date: Wed, 15 Jan 2014 13:56:52 +0800
Message-ID: <CAHtLG6TmkYdGRF3H-6CoVvnxZqZBBk3ZUR-ohTVvgeAe9tTuOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 15 06:57:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3JTG-0002fj-Hn
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 06:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbaAOF4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 00:56:54 -0500
Received: from mail-we0-f180.google.com ([74.125.82.180]:36646 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbaAOF4x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 00:56:53 -0500
Received: by mail-we0-f180.google.com with SMTP id q59so1314767wes.39
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 21:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=fFk1MM7rKNnm9vLj88mNpS1xpUgVXT0c8DYS8mxr09k=;
        b=Z59k3HNm/whf2O164lDmVg8wyT/CsK/sAC3E2CAyr6ESJiUrGXbZ5gOK4UX7LqinvA
         fb78dukxXhOj+6fhOZIk7y7pT9QQFNA4HQVhmr0+q4dSsOt+4J3Z8ZlbUvexmHdCK5xV
         saRkoglRxjstN5QmsMwVOWiFcCSTN/RwVvUtk6k/Sc2MW66XiSxZG5t9wF21t9konTDt
         e3KXk8NLd+4Weblxhhec/4xpxLzyqwzBjM9uZ6+2a+Ke/jIKM93NmSo6+8K6wPdBRfqA
         95pvZa2CeI+wl5y6VM9SBayINjYg+yMvqLzoXsOP6hsRD+rQW628sQBg1f3RNjL/Bqqh
         zAZQ==
X-Received: by 10.180.206.201 with SMTP id lq9mr375899wic.8.1389765412328;
 Tue, 14 Jan 2014 21:56:52 -0800 (PST)
Received: by 10.216.53.137 with HTTP; Tue, 14 Jan 2014 21:56:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240433>

Hi,

what are the possible causes of this?
After stash pop, refs/stash becomes 40 zeroes.
This is the only stash, so refs/stash should be deleted after pop.
However, it becomes 40 zeroes.

git 1.8.x
