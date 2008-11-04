From: "Andrew Arnott" <andrewarnott@gmail.com>
Subject: Re: Intensive rename detection
Date: Mon, 3 Nov 2008 17:18:20 -0800
Message-ID: <216e54900811031718o4cc81294sc0c32be1e71b9372@mail.gmail.com>
References: <216e54900811031717j70669868p3c7503357ceb5138@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 02:19:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxAZz-0000Ez-Ux
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 02:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbYKDBSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 20:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbYKDBSW
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 20:18:22 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:23594 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbYKDBSV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 20:18:21 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1092165ywe.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 17:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pe3FK0A8Angeo8cE0j/MHKFimFfT0QJvoWCNo7rGa/o=;
        b=AvAKYpY6MA9DgNbZuGTCjGwslpY9L97WqwiPb+ugMxgFfdBa70KpfgB+jafjGU5HVe
         Ub583JXkwBAl9H85O3B8UAbKCWV04JEt+PNqg/qryfS5ODdhSNXh8NYFJqCekzov/ezp
         7p3yZh8oQw0XT/penDBloHuKxOWlWrc9z7cTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qOQ3nTBl6N2eBiLOeLFcMKVsUHCY00NnwoJruFWAKowUA1r4PjxJXkCTgVc7kaDv23
         1MoMT+UQlxPTBtuvfzmXqydz7UNgos2yguU542KnJpEeRDD+lFGrxrtT/tf4QWKeMmeq
         QQYTA770fKEptJ/Rv0Q9IOkajQ0KbrSb9J8gw=
Received: by 10.150.52.10 with SMTP id z10mr1349367ybz.130.1225761500273;
        Mon, 03 Nov 2008 17:18:20 -0800 (PST)
Received: by 10.151.142.12 with HTTP; Mon, 3 Nov 2008 17:18:20 -0800 (PST)
In-Reply-To: <216e54900811031717j70669868p3c7503357ceb5138@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100020>

I'm refactoring a library including renaming both files and
directories.  A few lines of each file are also changed, but they are
substantially unchanged in content.  I've done a git add to put all my
changes into the index, but a git status shows that git only detected
a few of the renames... most of them are delete-add operations.  Is
there anything I can do to help git recognize the rename so that
history is preserved across this commit?

Thanks.
