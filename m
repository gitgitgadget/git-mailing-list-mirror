From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: bug in name-rev on linux-2.6 repo?
Date: Thu, 22 Apr 2010 18:54:18 +0800
Message-ID: <r2sbe6fef0d1004220354g6443218ezbd0452428ad9e4b5@mail.gmail.com>
References: <20100421195822.GX10984@baikonur.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: maximilian attems <max@stro.at>
X-From: git-owner@vger.kernel.org Thu Apr 22 12:54:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4u37-00006g-G1
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 12:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077Ab0DVKyU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 06:54:20 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:46968 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916Ab0DVKyT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 06:54:19 -0400
Received: by iwn8 with SMTP id 8so1831855iwn.16
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8raW0NNpeo4Jlvbv/sQ4lq+JGIoz4FaYqOXi6qziDeA=;
        b=c8zAEOfwlrRyhUCMCPYt0KsOE8MTc/o4GUa7w9ac86W1OhJRSD8KtJ3ovjufl21yjQ
         9um7Loy69hnuzQLEeyiWNdltN1qSETBRoGA6xo4ZZ1+DGjSsFwhV1T+WB/gx5f91jGfg
         P97RkHdCFRthRF1oYNZojDj2Vq20n27rK99Q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=l5TdUYqyjKIcvZIGtG1nTFft+4X/bYvASPWz+UNZW1EV+RG+Wlc2rzyUbDM+2gisRi
         PLUpj3aAZFJh4nbRyhR4e3aFLU7h0v1arEJ6BVJgb8jnzfWQ0kSZYQsKPlHZKs4oQn8V
         CcFZo4NbkoCYqvxR/CraqsYqXjAUhL3l4yx4U=
Received: by 10.231.10.65 with HTTP; Thu, 22 Apr 2010 03:54:18 -0700 (PDT)
In-Reply-To: <20100421195822.GX10984@baikonur.stro.at>
Received: by 10.231.146.83 with SMTP id g19mr41783ibv.88.1271933658730; Thu, 
	22 Apr 2010 03:54:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145520>

Hi,

On Thu, Apr 22, 2010 at 3:58 AM, maximilian attems <max@stro.at> wrote:
> ~/src/linux-2.6$ git name-rev a1de02dccf906faba2ee2d99cac56799bda3b96=
a
> =A0a1de02dccf906faba2ee2d99cac56799bda3b96a undefined

have you fetched tags too?

--=20
Cheers,
Ray Chuan
