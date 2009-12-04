From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH v2 7/8] Add remote helper debug mode
Date: Fri, 4 Dec 2009 17:03:40 +0100
Message-ID: <fabb9a1e0912040803q41b7d015ic9fb3014748a3fdc@mail.gmail.com>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<1259942168-24869-10-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Dec 04 17:04:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGadm-0007Dj-4D
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 17:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009AbZLDQD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 11:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756998AbZLDQD7
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 11:03:59 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:59693 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756903AbZLDQD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 11:03:56 -0500
Received: by vws30 with SMTP id 30so1220134vws.33
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 08:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=JwR+76PqDBRCOQSwX90DzAmqvI4GQtX2skh4bpI9dl8=;
        b=SFS885Qpe7aavrymSoighS1o+papNnuF1oskjiST1wotfGafzpn7V7DHw/RSRcyCN5
         h5YH0XblNgag9PJnfI3N+fMpkg/TGBdu4CkVYwh4OLBbN6P1S05v1Dg39KnPgNaqOVvR
         R6iBqyThpwlDd2hME8iUHcMCBey++eBjChIsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GbEvjbqVwGH22mfrj4PbodT+LYEq5eyZ3KQoJPLwrzOXdmsOSI24eWqArKgDVXQM8T
         hpuduW0at2FDqLYdX8RqUtICWwgGtNN0uoY+G1RUXNDJ8tnHI6a+KJIuGSMiuF4A6qyG
         Vm/H7munYutJ6dWFhhcCit0i0dxu4Gcdrj69k=
Received: by 10.220.89.221 with SMTP id f29mr4250062vcm.1.1259942640190; Fri, 
	04 Dec 2009 08:04:00 -0800 (PST)
In-Reply-To: <1259942168-24869-10-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134531>

Heya,

On Fri, Dec 4, 2009 at 16:56, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> Remote helpers deadlock easily, so support debug mode which shows the
> interaction steps.

You should move this to the beginning of the series, so that it can be
merged even if your other patches are not :).

-- 
Cheers,

Sverre Rabbelier
