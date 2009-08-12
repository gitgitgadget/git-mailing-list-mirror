From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [ANNOUNCE] Scumd
Date: Wed, 12 Aug 2009 23:10:48 +0200
Message-ID: <81b0412b0908121410l451bc6dbqe8e0cf9ce917ee37@mail.gmail.com>
References: <4A8309D9.8070008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 23:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbL6L-0003z1-3G
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 23:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbZHLVKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 17:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbZHLVKt
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 17:10:49 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:49028 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbZHLVKs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 17:10:48 -0400
Received: by bwz22 with SMTP id 22so255082bwz.18
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xNOeFCXmfWULRoxizvOF60jiJihyff0O6nuJh5QUIMM=;
        b=hhVucm75jBO+9TVY0GIPE5ZzTm6TSWMTjm8cAHlfRLzUVRMt9gNFC3DvkRNRIDhQSj
         V9N5EecugZelkglzH35NhPtBAe10XkkQgAvJA0coXpPazUWhf++2xENxGdicSM1lTxiq
         bMS+al0TWpzlHnIkR8Tgq0bAEMC5o0JtOZS/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UbjjUwP5y/AGsQYdIfKp5w9ENaIn72AIjn6AlNYkx7HKSeyJwk+EL+bi4QxiP9phww
         IK1MyC5q5hlkGpCS+O4tZ6LjkcaFbxNZ05Dcvs1lMX287UPpxd2u3QSiOA9t/6YGdvwV
         qNYjpn+Me1cB7yxJduPCyeWTCifspA/u/vmHE=
Received: by 10.204.7.198 with SMTP id e6mr258269bke.148.1250111448833; Wed, 
	12 Aug 2009 14:10:48 -0700 (PDT)
In-Reply-To: <4A8309D9.8070008@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125749>

On Wed, Aug 12, 2009 at 20:28, Michael Gaffney<mr.gaffo@gmail.com> wrote:
> ... SCuMD's other goal is to remove the need to serve
> off of normal sshd which some find to be a security risk on the open
> Internet. ...

I just wonder: how is your creation less of security risk than sshd?
