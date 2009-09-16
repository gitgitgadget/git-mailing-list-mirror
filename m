From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH] archive: Refuse to write the archive to a terminal.
Date: Wed, 16 Sep 2009 13:27:13 +0200
Message-ID: <237967ef0909160427m4d7de120tf5ef3176f75123ad@mail.gmail.com>
References: <20090916103129.GA21430@feather> <4AB0C7DE.7030109@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 13:27:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnsfn-0006Gr-8L
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 13:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbZIPL1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 07:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZIPL1M
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 07:27:12 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:37257 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbZIPL1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 07:27:12 -0400
Received: by bwz19 with SMTP id 19so3413834bwz.37
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=aV6MIk7Zv3p72bsD1NOCsuv4tIRZLrBRcwLc1Bt34FM=;
        b=Cp1YqS01kHQNeKUX1sGFpKWKJ9Z8+4eH/EbPpTJHD2Ibh5gGWr3oNQMai3HAc2qnuk
         gzQWbfCrcR8ln2wR36cEisMVaX9ViQkfpvvUvjushVQVRGq+2b8nx/qt205Xd1x8mD/6
         Nv6s1bFxzM7zObjDaT5I6V/n5YkfKHQX9/nfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KZ14qlRAMLB9x71aY72OGvv3Rb3ZPNBaZ+gc+ip0g7baB2Gqyy1yDVvIuU8sA5mJYG
         yQdQa48Exo1o+kVKb28LjOBM1b0guDtATy6txq0MTjYnj8N/G2199+BfvTAtj3tyq+EH
         ycIxrhWqc6CF/hRWlpsqmpAtZGt0rgp4IQXpw=
Received: by 10.204.0.69 with SMTP id 5mr7312118bka.140.1253100433846; Wed, 16 
	Sep 2009 04:27:13 -0700 (PDT)
In-Reply-To: <4AB0C7DE.7030109@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128643>

2009/9/16 Johannes Sixt <j.sixt@viscovery.net>:
> Josh Triplett schrieb:
>> I considered adding a -f/--force option, like gzip has, but writing an
>> archive to a tty seems like a sufficiently insane use case that I'll let
>> whoever actually needs that write the patch for it. ;)
>
> How about '--output -' instead?

You could always just add '|cat'.

-- 
Mikael Magnusson
