From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] format-patch: Add format.subjectprefix config option
Date: Wed, 4 Jul 2007 12:00:24 +0200
Message-ID: <81b0412b0707040300q54a95b98v528bb2745c1b7eb7@mail.gmail.com>
References: <1183337339745-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Adam Roben" <aroben@apple.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 12:00:29 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I61eu-0006pu-KB
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 12:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557AbXGDKA0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 06:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756723AbXGDKA0
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 06:00:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:1674 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667AbXGDKA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 06:00:26 -0400
Received: by wr-out-0506.google.com with SMTP id i30so58130wra
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 03:00:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LwV3Y3n9ssnFpyv13qgAp0Kmrs7+/Y1V/Q/IlYHjFlR7vT6OXZQ1U+i6nP8dQQxKQO1Rrcc6IIgzZ4GmkQ3XZpCuvYTvuIlEJriY9mljpWGDnzTEKIehBJa3QdOFLXv3pnlocAFGiXhRiXEyMAlFw6lOH2FV7U/qiDnksmM7+JY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sEz6hfgZZtqkJjdIh8m1l0cEhNXSconZGPXQZXELGf3qdGrGGBYK65Q5p0OF1ZKSEo9F43tJRVK/K7wCzlofOGtaohNENpcdYKNKxe2QSFUrCVg5W+YUGBdMnIy4pEVwRHepCmvnIEDz/Dw2/uIiIdNR9LktNop7rfy2puyNp6w=
Received: by 10.78.171.13 with SMTP id t13mr4007656hue.1183543224156;
        Wed, 04 Jul 2007 03:00:24 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 4 Jul 2007 03:00:24 -0700 (PDT)
In-Reply-To: <1183337339745-git-send-email-aroben@apple.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51587>

On 7/2/07, Adam Roben <aroben@apple.com> wrote:
> This change lets you use the format.subjectprefix config option to override the
> default subject prefix.

It is incomplete. The patch make git show --pretty=email produce subject
lines like "Subject: [(null)] ..." because revlist argument parser
will not setup
the prefix. Besides git-show also git-log (and rev-list and maybe
something else)
accept --pretty=email option which supposed to produce the same output as
git-format-patch.
