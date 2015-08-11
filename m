From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/16] Introduce a tempfile module
Date: Tue, 11 Aug 2015 13:21:31 -0700
Message-ID: <xmqqzj1xpodw.fsf@gitster.dls.corp.google.com>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 11 22:21:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPG3G-0005hZ-Gp
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 22:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828AbbHKUVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 16:21:34 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33159 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbbHKUVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 16:21:33 -0400
Received: by pabyb7 with SMTP id yb7so137165315pab.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 13:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZtvEGNwyRUk3WKHgZEeq6EcJ1jXHHOa6Zost7dBCq6c=;
        b=jrog7t/VoNM96hPUlnXhvBdNYmf6T5iBEUJOe3R1zAoQk/2h2HUtOyhs05RmYf9O8s
         1JQo7i18m/w+nYrf1MuU3FOO5VtBiAXQDD3ou6KlJttcACMVWDtZs6GYCTzsZM0Ibhhp
         LSURQdYQZybXr+iOe0hrIG0zmIFjkRYP4FAES8p+QX6UPtM2gUTQUCBkScxgs/R1NL+3
         VeD+1pdr36qtdYTwvAkN0IKV0elYTtrH9B7LyH/n+DMZfMpBrhu+5eb00CrWPE1Kji2F
         EomGtt3yAmP4XY7XtFfBkBVZ0Jdifc/ebbspgD8ItWraMul+UGyPDw3/+ZGYj5lVeGt3
         JQ8g==
X-Received: by 10.68.196.233 with SMTP id ip9mr60220433pbc.139.1439324493246;
        Tue, 11 Aug 2015 13:21:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id dm6sm3717218pdb.36.2015.08.11.13.21.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 13:21:32 -0700 (PDT)
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu> (Michael Haggerty's
	message of "Mon, 10 Aug 2015 11:47:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275719>

Thanks for a pleasant read.  All looked reasonable.
