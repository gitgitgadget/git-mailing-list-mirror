From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Rebase with tags
Date: Wed, 29 Sep 2010 21:43:37 +1000
Message-ID: <2892317C-ECA8-476C-9039-CA9FE3986CDF@gmail.com>
References: <AANLkTinQm8kVA_rCgX_SN=fX_2a0UU78aiOHr-YtO6zK@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 8B117)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Leonid Podolny <leonidp.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 13:44:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0v56-0002PS-4h
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 13:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab0I2LoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 07:44:10 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52279 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab0I2LoJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 07:44:09 -0400
Received: by pvg2 with SMTP id 2so133349pvg.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 04:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-transfer-encoding:content-type:message-id:cc
         :x-mailer:from:subject:date:to;
        bh=jViz5KnAbQS5kLzJj5weu5ZSv4bhBtFB5LWb4rQCL2o=;
        b=IDBN2eFrYt/zl1OiO9Gs2qVtCUghmbqA13E0HW85e4emOTOppnQatQbviZ3FWz7RXk
         jC5bWOYSJ+inDaxWgwqdW/bR5SAU8tMbjWT2utA2BLVls6/yM/8UVo4qxqBfA73YOplX
         So2Nke+KYTz5YgtS91MG8Kmh0GJF3UtjOO9V4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        b=QFh9gHQy8D2I1ofDi9nuTVzN0mZhqa73EVxzof9+bC+syv5R5u3kQyfV6NS5wl6Ils
         LaagUeVckEi2Bv1pBbocNEDweGlcCZtCz2D3rDeaQQ5GPLx3NX49g7z7kUAawzLNrvVj
         jSqU+hjRmm+kRIwQUjOgVejOlkQhmkDz+sNb0=
Received: by 10.114.78.11 with SMTP id a11mr1755755wab.4.1285760648859;
        Wed, 29 Sep 2010 04:44:08 -0700 (PDT)
Received: from [10.216.190.88] ([120.153.212.234])
        by mx.google.com with ESMTPS id 33sm14405619wad.6.2010.09.29.04.43.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 04:44:02 -0700 (PDT)
In-Reply-To: <AANLkTinQm8kVA_rCgX_SN=fX_2a0UU78aiOHr-YtO6zK@mail.gmail.com>
X-Mailer: iPhone Mail (8B117)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157558>



Sent from my iPhone

On 29/09/2010, at 18:45, Leonid Podolny <leonidp.lists@gmail.com> wrote:

> Hi,
> I would expect this question to be asked dozens of times already, but
> surprisingly I can't readily find an answer.

The reason this is not directly supported is that it encourages people to regard tags as mutable entities that can be changed at will. This goes against the general principle that a tag, once cut, never changes.

Technically you can change a tag, but this is meant to be a measure of last resort not something you do as a matter of course.

That said, I understand the requirement - if you are using tags as markers for different segments of a private history, I can see it would be useful to move the markers when you rebase. 

Perhaps there might be a case for a kind of marker reference that does move with a rebase, but it would be somewhat invasive to implement so you'd have to convince the list it was worthwhile.

jon.