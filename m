From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Is there way to set git commit --date to be older than 1970 ?
Date: Wed, 29 Oct 2014 20:19:14 +0100
Message-ID: <20141029191914.GA16599@paksenarrion.iveqy.com>
References: <CAOE_JxJp0nA_p_42yOyk_nMjsyMaovj0Fx6AJ5nywiEQfB5XAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Vojtek <peter.vojtek@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 20:13:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjYg8-0001in-Bs
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 20:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756697AbaJ2TM7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2014 15:12:59 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:64474 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683AbaJ2TM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 15:12:57 -0400
Received: by mail-lb0-f169.google.com with SMTP id l4so3080668lbv.28
        for <git@vger.kernel.org>; Wed, 29 Oct 2014 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GclUS12I1j7156cGp9V4GKZfqa1NjRVoDtQoyda9KPI=;
        b=pKL+e1l+QUxhbuxATgSMZVfCuMc2QqfE8VYvPzKPYR5ZDu7qzjobR5eYO2OlT018LL
         tpMklXbfMFhgNsZ2k5rrTYtIHid8ddQC1fjE3R6TQRZJFUGvQCuNQqdpN8RX1rbjwkvG
         L5XGJvqajd7UbLpftcel7bcPbl/4w9X3WoeR7ueRcnaVQu5gTGICqkcwsrOaQaoV/K5N
         shP4J0E5d48+j91QK7WL0Yw5fCNDNHwh6gNy4wM4AUeEOrPtexqBKUC0W8nE8qXZtnnR
         jAamodpVyTCZ4Cb0HlXpBRPbX099FF+t/uKheo61jfTTZKbbMGm6fOigjbSBEqldvoF8
         fmVw==
X-Received: by 10.152.5.201 with SMTP id u9mr13581143lau.24.1414609975998;
        Wed, 29 Oct 2014 12:12:55 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-249-10-52.bredband.comhem.se. [83.249.10.52])
        by mx.google.com with ESMTPSA id vr7sm2276207lbb.21.2014.10.29.12.12.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 12:12:55 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1XjYm2-00027B-83; Wed, 29 Oct 2014 20:19:14 +0100
Content-Disposition: inline
In-Reply-To: <CAOE_JxJp0nA_p_42yOyk_nMjsyMaovj0Fx6AJ5nywiEQfB5XAQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 29, 2014 at 07:49:19PM +0100, Peter Vojtek wrote:
> I am playing with git in slightly unusual manner - e.g., to use git t=
o
> store history of europe:

Actually you're the second person I hear that is trying to use git as a
timeline of some sort. The previous person had the exact same problem.
Unfortunately I couldn't find a mailthread about it in the archives.

I'm curious, why did you choose git for this? Maybe this is a use case
we should consider?

--=20
Med v=E4nlig h=E4lsning
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
