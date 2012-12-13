From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: unclear documentation of git fetch --tags option and tagopt config
Date: Thu, 13 Dec 2012 14:29:32 +0800
Message-ID: <CAHtLG6Ti7yPFfhTb2qfSKE1+5n4Ftey4DQeqpm3SSL-bOfspUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 07:29:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tj2Iq-00066y-OD
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 07:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329Ab2LMG3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 01:29:36 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34666 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780Ab2LMG3f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 01:29:35 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so1431694lbb.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 22:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=fNn7sf0n2zMp35Pli1B8dYRQ91j1XR31dJ9/zoZvbm4=;
        b=w2gKU+RO6CrbolQf6dZwJcs0qpa6HhAuGmVyiBPVpVjS5cCt11cb5ilRt06F/u6vX6
         MKm0x4hfiaQmS4P8S8rZKziBTeGuLwOyzLZKuDGHg2884j4wZEn/6/ecHZkXDveZv0fA
         jZ+jdVJYWCKw5XrbTDtbZI8BKU+4L0VUx1XBeBHlKI5iVn+OIuitwmjgZqe1lVqmPdfN
         zVBXu+7O3DxPzXpoZwQa/eBKK/8a1QiVUHGsfHzmEEGCj0Tpn7mVCGGYt1i9E45Aqth7
         LtvLKS64t2By9Oz/XA4T//VWvduKEQ6wVW9YSJimMdP0bynIwKYWxtikFmKkf34N23ud
         W3cA==
Received: by 10.112.11.68 with SMTP id o4mr427764lbb.128.1355380172761; Wed,
 12 Dec 2012 22:29:32 -0800 (PST)
Received: by 10.112.132.199 with HTTP; Wed, 12 Dec 2012 22:29:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211439>

Hi,

With git fetch --tags
or remote.origin.tagopt = --tags
git fetch only fetches tags, but not branches.
Current documentation does not mention that no branches are fetched /
pulled when --tags option or remote.origin.tagopt = --tags is
specified.

Regards,
ch3cooli
