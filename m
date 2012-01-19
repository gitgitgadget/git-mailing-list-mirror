From: Victor Engmark <victor.engmark@gmail.com>
Subject: diff --minimal as default?
Date: Thu, 19 Jan 2012 14:41:18 +0100
Message-ID: <CAA5Ydx_ZqnaWRK3cEvMkULcrGx8B1MUyi2-Ca8eSBmbDg==fDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 14:41:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnsFI-0004IV-Db
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 14:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054Ab2ASNlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 08:41:20 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44545 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab2ASNlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 08:41:19 -0500
Received: by bkas6 with SMTP id s6so3771218bka.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 05:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=mBvgXdFmxtWFdBY+0Avl/2nSfcArP2kyu2Q4AnaxbEs=;
        b=BiTA6azLxC4Nxo5TGFmrMDl1GuEDKGUMVDG6vK/WlnbtJ8/RzdFAbSff0k8TCTjL5K
         7WHmQPQcJ3RWYEWcoHtc6zAFNcitC8gmKlIBOgWz0sGse5LZ6fwN2SwfrQtmLIxNNG3v
         zOUd4KxPyt1OBVYT3NCvyWN1b4U6TUmDxjIRY=
Received: by 10.204.145.86 with SMTP id c22mr9931556bkv.61.1326980478185; Thu,
 19 Jan 2012 05:41:18 -0800 (PST)
Received: by 10.204.167.1 with HTTP; Thu, 19 Jan 2012 05:41:18 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188811>

Git v1.7.8 supports `diff --minimal`. I've got cycles to spare and
usually small files - Is there (or will there be) a configuration
option to set this as the default? If not I'll just use an alias, but
there should still be an inverse option to be able to override it in
special cases.

Cheers,
V
