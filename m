From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 19:33:32 -0300
Message-ID: <a4c8a6d00908171533n7db1a6d4o60f9a2e38c466f06@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>
	 <3f4fd2640908171343s6e2796a8le0455e02fd8386d9@mail.gmail.com>
	 <3af572ac0908171354i6dd231etb576859ab8941214@mail.gmail.com>
	 <alpine.DEB.1.00.0908172304200.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171423ye08efa8m6666ddb922d5ee92@mail.gmail.com>
	 <alpine.DEB.1.00.0908180005250.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171519h7b72427lba7536506d44460e@mail.gmail.com>
	 <4A89D807.1080202@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pau Garcia i Quiles <pgquiles@elpauer.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Reece Dunn <msclrhd@googlemail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 00:33:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdAlm-00060g-9I
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 00:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758233AbZHQWdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 18:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758224AbZHQWdc
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 18:33:32 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:25978 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758217AbZHQWdb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 18:33:31 -0400
Received: by an-out-0708.google.com with SMTP id d40so3086128and.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 15:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ABi9EHbeMI479L14iF94wuwtJMltpjIwB0iHZ46yDRo=;
        b=QuwqT8EszkDs6Qx37gUE1VM5rfBoLhOZDBoDbiUAIbhRRim/jFCPAO3RXU3W3sBqbU
         cvC2SD1kO7iybnF8Q0+SDVUKf+pPVkFAOLYGeb29Kh1j1UAgmzcyFCZO7MgrFekyWVhT
         tKrVYJmCjIoIPxUxL+V1sD5fZvkxKE30mdMbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OMuG31otllc34HR4CfMGViCp5xAkfeI4OlbdXbiW3I/cGsSwPGYkPV8QcLMN69bFTb
         9ol+1NinfNH295Q8cPchc0DrnQUlrMkUDH8T+sClrrfCDEgF7QxoJSAFvGlHGKm6Jhj8
         o7qR2HayCmggzZXXhJM0WvCo3uU0NvDB1hDZk=
Received: by 10.101.44.1 with SMTP id w1mr4188078anj.113.1250548412996; Mon, 
	17 Aug 2009 15:33:32 -0700 (PDT)
In-Reply-To: <4A89D807.1080202@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126304>

What about the common-cmds.h that is in the builtin-help.c? How it will be
generated? I followed the instruction in ReadMe, but I couldn't compile
because of this "missing" file.
