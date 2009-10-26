From: Eugene Sajine <euguess@gmail.com>
Subject: gti push interface inconsistency
Date: Mon, 26 Oct 2009 18:23:44 -0400
Message-ID: <76c5b8580910261523s51ac22b5y624ec3502e8fed67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 23:23:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Xyf-0004fi-EU
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 23:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbZJZWXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 18:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753772AbZJZWXl
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 18:23:41 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:35263 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbZJZWXk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 18:23:40 -0400
Received: by gxk8 with SMTP id 8so259204gxk.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=EmACw5AX7cnf2lJnQI+12T2DYSTWGluMlnvwRNmOHX8=;
        b=aFKyo1UZlOtYnjFR7I9x2Y6PlEzR5CxvmZPRwGWu1dBRvXzNA9jYJsz8ajD+ooUMZQ
         MdtHUX42fdMSwPF204r0Av/HBa9ATZm1neJluYpGNRHgiuEOSzgi5adTkhikQRYHhUVd
         0Ulv1W9YgpV6UXjo+K4BEbyH0RmXhWRDY/lUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=yE9HRyyya1Tg3MAE+ZssEJVoFuKfLxwf9/SrPMFGgCyaok1rNPOm+FrPFw2ALNOdYo
         FGv18rJb9c3TF+laklS0Z5fQ38P8cjRvQRxoaDONbxuiJYp5u/p9VCJqiksaQSaY5WaI
         Mvx39nRBMqAY7EKUWjAeBkmx0WVXxZAeQvMkk=
Received: by 10.90.8.21 with SMTP id 21mr18299184agh.37.1256595825143; Mon, 26 
	Oct 2009 15:23:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131278>

Hi,

I have a question:

Why I can't do

$ git push my_tag

It will fail because the remote is not specified, even if there is
only one origin remote

but can do

$ git push --tags

and it will push tags to origin...

Thanks,
Eugene
