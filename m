From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: long fast-import errors out "failed to apply delta"
Date: Thu, 7 Jul 2011 18:24:07 +0600
Message-ID: <CA+gfSn_zdMJ-J_5unUjUtqGzoRyy_Hy9Bo0MNh9Qt+zzGL8Q_A@mail.gmail.com>
References: <CA+gfSn8jjptyv10iVimmfXpf6QHrR_3UpkRdd+Dv1M=KgORtGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 14:24:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qend8-0007m4-1g
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 14:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143Ab1GGMYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 08:24:21 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40871 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870Ab1GGMYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 08:24:08 -0400
Received: by qyk29 with SMTP id 29so2633678qyk.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 05:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=NSFKWfoe4nxraZ01HHOseZYiGS3CTnh9N558wVDFEs4=;
        b=FzoMbuSsPVmXN8EqwhgbtCpstQIMQQHtkjkmCRKgPVkiTpIa/DtbUqF7PHr4OLFucs
         yLy8bAbQVaD68nsgUbKo/0zIREhp5cjk69sPfxoI6onKb+5dbBbC6LT5AIEIewc8A1uS
         ulfJyzrv+neHiViupBs0TTjAMbbUhFfNver2Q=
Received: by 10.229.41.136 with SMTP id o8mr547662qce.83.1310041447834; Thu,
 07 Jul 2011 05:24:07 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Thu, 7 Jul 2011 05:24:07 -0700 (PDT)
In-Reply-To: <CA+gfSn8jjptyv10iVimmfXpf6QHrR_3UpkRdd+Dv1M=KgORtGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176760>

Small update: valgrind didn't detect anything.
