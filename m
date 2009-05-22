From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] t8005: use more portable character encoding names
Date: Sat, 23 May 2009 01:04:36 +0200
Message-ID: <81b0412b0905221604h749b4edfo8ea340e85cf1d0ee@mail.gmail.com>
References: <WnZxv4G_GKTN4oHhxHO_HuQt0cTqurrqXf2HHDiHLAzdp7wC70aKuqDot7xQ1nG9C8_NASCL1_Q@cipher.nrlssc.navy.mil>
	 <7vhbzd85ux.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 01:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7dso-00030M-EO
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 01:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757804AbZEVXK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 19:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757606AbZEVXKZ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 19:10:25 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:60305 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757597AbZEVXKY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 19:10:24 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2009 19:10:24 EDT
Received: by fxm12 with SMTP id 12so148737fxm.37
        for <git@vger.kernel.org>; Fri, 22 May 2009 16:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1HGq/z7kvsarFIkWnb1RtegTZVG0xjYhwUCkOXvTnlU=;
        b=KsUIJuxPNKe9BzTT9tgGfuo0l0vNlXJenRSPvebbGe8dvk929V4PVtozk2sfTNieQc
         6BpWU2CYdagUwn1bv8DFB81EXhjbGqY45lPbVBFXbZVdOejPVp4yHgzRCYD/JMe4UM6w
         dibm6HKRAlQ559u9sbQtuS9xfIRd1kQ3510Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hOgmg5PPomXj2a6l6+d+fikZhUIHUWEVAtxTmWtNsSf7/gv/Cl9yBylmzUBY5ASWyY
         upGl2qVGAdDbtyIJErtxyFu8jc8jYmrUPxYlhr3GCXBr/A8QTh5TTjmn7DBTJyrF3s7/
         ZoBTNY0JN8wH5FNukHqCPzlmBqR/w2qJgZtks=
Received: by 10.204.60.72 with SMTP id o8mr4023080bkh.210.1243033477078; Fri, 
	22 May 2009 16:04:37 -0700 (PDT)
In-Reply-To: <7vhbzd85ux.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119752>

2009/5/22 Junio C Hamano <gitster@pobox.com>:
> Perhaps the test can be changed from using cp1251 (whatever that is) to

cp1251 (win-1251) is Microsoft's Windows Russian
