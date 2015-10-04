From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] Add prereq to detect OS X
Date: Sun, 04 Oct 2015 11:28:05 -0700
Message-ID: <xmqq612m1oay.fsf@gitster.mtv.corp.google.com>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
	<1443981977-64604-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 04 20:28:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zio17-0007UF-RV
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbbJDS2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 14:28:08 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34805 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbbJDS2H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 14:28:07 -0400
Received: by padhy16 with SMTP id hy16so13378365pad.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fxzCKmA3M0B9s/I0jludWs5/+vgd42RxkyiEQFg+XOc=;
        b=g0YjvwpFxTla4p5HGpvPA25Jpx4im3+l8QQAQBclJzVJNhQ26+etbPUVrQl8W1ZAyC
         Cj6XFdo1vTXb+05+7DcOwEssEWpE2yOdJIwcLaJoL/4snhaO5OW4hvNblLAXO5nA0D9Z
         EV8U23wzVkeCvHH0jqHmnVkQhQ/ztkzaB7MjS6fQ7nsD9DvwkE9h0jpT1sEqp4C68N1c
         LvjrxxklyI1BEY46I8ug/ZsNASX+PXX+1UEeQnS1VNJ5hMHB3Zm7/oy2NPUHUvT140Y4
         v5QWykODms/I8gQ6b3C8+BzydIe6VqG/Ay+D2+5Bv6vVl7WdrMgUkbURAp2gV4g583lm
         NSXA==
X-Received: by 10.67.7.71 with SMTP id da7mr35038704pad.69.1443983287247;
        Sun, 04 Oct 2015 11:28:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:cd5:dd7c:35c8:15e])
        by smtp.gmail.com with ESMTPSA id iy1sm23104731pbb.85.2015.10.04.11.28.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 04 Oct 2015 11:28:06 -0700 (PDT)
In-Reply-To: <1443981977-64604-3-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Sun, 4 Oct 2015 11:06:15
	-0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279018>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Some Unix tools differ between Linux and Mac OS X. Add this prereq to
> detect OS X and handle it appropriately.

If my comment on 4/4 turns out to be to the point, then we do not
need this, I presume?  In general, we really should think three
times before adding prerequisite based on the platform.  A prereq
based on a specific feature of the platform is often what we want
instead.
