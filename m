From: Francis Moreau <francis.moro@gmail.com>
Subject: Can't build doc anymore (v1.7.3.2)
Date: Mon, 22 Nov 2010 20:45:02 +0100
Message-ID: <m2oc9hkurl.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 22 20:45:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKcKF-0000yI-Ju
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 20:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab0KVTpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 14:45:09 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37897 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab0KVTpI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 14:45:08 -0500
Received: by wwa36 with SMTP id 36so7736689wwa.1
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 11:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:user-agent
         :date:message-id:mime-version:content-type;
        bh=ZwFhml3+GBgQCWUlpDNW9PNiOakgtW3qwnuk+IKdku8=;
        b=iuksA3ZmCcQ0YjJKgYrvs27O1sCG6o5CrWnDlgFbOvNMYFEm/IOOHSb9sHvKOpzy/c
         cQofQ+9fLvUBAN8f/rfaZ5pbfGH/TcUECctluXC8L4srSXXXkS42obWyLm1SY1if7lNn
         NZtwR/Z7rX+Uxa/BXuyYxbfYwUr+g8Sb9GF24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:user-agent:date:message-id:mime-version
         :content-type;
        b=CnA3MPWk7I9G6A339zmsWaN899sbiXnc84d4B4kSETWKeEH/flLBe0XSRRVMYEPybH
         gDXii5t25iKDZ0rUatoeFo7ONAoHprVkM762TeCAZ2cH/HnuOADT8iW8YC7jeiSVXCGs
         jyA0O+g7u6LKN6i9IS5vCkJ9ZIM/QAHWfshk0=
Received: by 10.227.156.68 with SMTP id v4mr6424782wbw.224.1290455107101;
        Mon, 22 Nov 2010 11:45:07 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id f14sm3547416wbe.20.2010.11.22.11.45.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 11:45:05 -0800 (PST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161909>

Hello,

I'm trying to build the git's documentation, but after pulling v1.7.3.2,
it fails:

  $ make prefix=/usr/local doc
  make -C Documentation all
  make[1]: Entering directory `/home/fmoreau/git/Documentation'
  make[2]: Entering directory `/home/fmoreau/git'
  make[2]: `GIT-VERSION-FILE' is up to date.
  make[2]: Leaving directory `/home/fmoreau/git'
      XMLTO git-fetch.1
  xmlto: /home/fmoreau/git/Documentation/git-fetch.xml does not validate (status 3)
  xmlto: Fix document syntax or use --skip-validation option
  I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
  /home/fmoreau/git/Documentation/git-fetch.xml:2: warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
  D DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
                                                                                 ^
  I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
  warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
  validity error : Could not load the external subset "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
  Document /home/fmoreau/git/Documentation/git-fetch.xml does not validate
  make[1]: *** [git-fetch.1] Error 13
  make[1]: Leaving directory `/home/fmoreau/git/Documentation'

Could anybody tell me what's now wrong ?

Thanks
-- 
Francis
