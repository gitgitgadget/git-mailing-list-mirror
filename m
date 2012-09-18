From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t/perf: add "trash directory" to .gitignore
Date: Tue, 18 Sep 2012 12:06:32 +0530
Message-ID: <CALkWK0=zTZs6SLDq-FL4RYL+MZtJQAB1ApE0o7q5FqaieK01fQ@mail.gmail.com>
References: <1347901579-5545-1-git-send-email-artagnon@gmail.com> <7vpq5ks5lx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 08:37:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDrQb-0005r9-NW
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 08:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab2IRGgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 02:36:53 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:40296 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab2IRGgx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 02:36:53 -0400
Received: by qcro28 with SMTP id o28so5127145qcr.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nJ1ZysrpuHh1b9V6XTxMpq7caQ8c3Yc0i3pRH0KS1zk=;
        b=WkqLfIJOZoN3pVFrRL5hTP6PEBp2FsY/fCohosGeOA6yjW7iL3hl0T4x2n1GcToFp6
         akS1Bdx6IwLU1goR+zOyR1gf+dJHhXWcYwKjGSExwaJCed/xWJj6SsgzgB3WcsvNSzBv
         kMX1iom/SNbwukN8UxzRW9vvvdYuRIJQ+P7KT2D1vPGUGvDxM+lYoFtifvT5t2vNTwde
         NVWkKu1tVnWqyDl6/zt6vZspHw/D8M61FAEH8sBJa4+le8UOLCRdNIUIEkOeA4E692h6
         LOtUmJfj6IuBjwrRNtqO2hf8XATGlhlD5vhXSrjsJQeeYqYMBLZPI7fcG7iXZrKB21Xi
         IbFw==
Received: by 10.224.213.10 with SMTP id gu10mr31300379qab.10.1347950212356;
 Mon, 17 Sep 2012 23:36:52 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 17 Sep 2012 23:36:32 -0700 (PDT)
In-Reply-To: <7vpq5ks5lx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205797>

Hi,

Junio C Hamano wrote:
> Thanks.  I _think_ you still want to make sure these are
> directories, so instead of losing the trailing slash, you would want
> to keep it and add a leading slash to anchor them to the t/perf
> directory, i.e.
>
>         /build/
>         /test-results/
>         /trash directory*/

Right.  Thanks for taking care of this.

Ram
