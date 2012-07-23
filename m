From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v2 7/7] build: reconfigure automatically if configure.ac
 changes
Date: Tue, 24 Jul 2012 01:16:08 +0200
Message-ID: <500DDB38.3050805@gmail.com>
References: <7vy5mgvb6f.fsf@alter.siamese.dyndns.org> <cover.1342683786.git.stefano.lattarini@gmail.com> <173104dd1ddba55bca09e89ba090ebb852bdf1b7.1342683786.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 01:16:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StRrN-0005Ai-Ce
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 01:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768Ab2GWXQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 19:16:13 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48223 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749Ab2GWXQM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 19:16:12 -0400
Received: by bkwj10 with SMTP id j10so5795404bkw.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=jQAUv0Ygu0d4io3j5dp/UGUnTDaKcTaC4GcncyxEHRo=;
        b=Fea8Glumu6CsTn7zBHGgS1Hf+pQwfwpAm8wi0K7uSfq9G+WxRKcLpMQvoh8/zRrjHy
         UngzhWLhEA+4H4C/CcQdFY9KFBpMzs0tYg2a+7OYtCoAk32NMX3el2QwncBviK79lb7d
         NELuRglONzFFVUNpZj1CAl2J9NxTMas1js95cJOgjN71SD6HUF4e9Pb8gdRKPMAbYwkR
         jpa+OPvLKntYIEgfSlWZ5CQc9mS+RocA0sxkDBhhFdsNQG5vYIcR5IVFTv8TQdBJu1V0
         u8rVk41BkO3wxJj4tyQjT6GKPitOF1HXVkWtpmkpMRkTltgdZs5tWNHWxlxd/+PMjln6
         1pyA==
Received: by 10.204.130.151 with SMTP id t23mr9140506bks.94.1343085371110;
        Mon, 23 Jul 2012 16:16:11 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id ht18sm9173560bkc.16.2012.07.23.16.16.09
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 16:16:10 -0700 (PDT)
In-Reply-To: <173104dd1ddba55bca09e89ba090ebb852bdf1b7.1342683786.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202002>

Hi Junio.  I've just noticed a minor typo in the commit message ...

On 07/19/2012 09:50 AM, Stefano Lattarini wrote:
> This provides a reduced but still useful sibling of the Automake's
> "automatic Makefile rebuild" feature.  It's important to note that
> we take care to enable the new rules only if the tree that has already
> be
>
... here, it should read "been", not "be".  Can you fix that locally
before merging to 'next', or should I send a re-roll?

> configured with './configure', so that users relying on manual
> configuration won't be negatively impacted.

Thanks,
  Stefano
