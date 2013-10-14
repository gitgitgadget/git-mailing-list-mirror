From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/14] Officially start moving to the term 'staging area'
Date: Mon, 14 Oct 2013 17:51:12 -0500
Message-ID: <CAMP44s3u_SMyZOe5jxkvoGn5MBJ_g70iHRT5v_3u1rZwFoqiVA@mail.gmail.com>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
	<1381789769-9893-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 15 00:51:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqys-00082T-Oq
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757443Ab3JNWvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:51:15 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:42311 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676Ab3JNWvO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:51:14 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so6046026lab.8
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=S9lkuHR99tD0qAX2cnRteSXHwpmYx6UWwwHMZsLmj2g=;
        b=KwRHlj5fZekBocCVHNkPR5EeYxlDOV7kpzdw1bJHywmnwHnCeo3OkP8cj48aMB6jiI
         UFC0OK1F+CpSMv/Jn7uf024/Uf2mph+llVyv6qS1imvy70uvt9Asn9z8SDO2KtSqZSiQ
         6UEHV5w4rlkliRt9EP0jaAz/PnyzzXysIWVjO9zbcedOWH1P3fKTfPmx6xcGU8a+V2IK
         gwcL1QcveCJ+QsavoR9ihAihf1R4pMxHF1HovZlWi7Bt32fPP2UY8n5w/FGDKrF2o3FN
         TA5KJuzLbYYgAr5Q17hjBtQeEhwe8LPJ1pFjNEbexZDxQqwSGn/Il0bOuq1Cee5nmpGa
         3MKw==
X-Received: by 10.112.57.49 with SMTP id f17mr32703540lbq.26.1381791072866;
 Mon, 14 Oct 2013 15:51:12 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Mon, 14 Oct 2013 15:51:12 -0700 (PDT)
In-Reply-To: <1381789769-9893-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236145>

On Mon, Oct 14, 2013 at 5:29 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> tl;dr: everyone except Junio C Hamano and Drew Northup agrees; we should move
> away from the name "the index".

Junio, can you make an exception and reply to this thread? The change
to move away from the term "the index" has been suggested many times
since many years ago, it is an extremely important change to users,
and all the Git developers agree it must be done.

Virtually everyone has agreed already that the term "staging area" is
the best option and this patch series is a good first step. Other than
the --work patches, this series could easily be merged to the 'pu'
branch. Yet not only is this series not there, but you haven't said
what needs to be done to get there.

It has been more than a month that I demonstrated to you that virtual
nobody has any problems with moving away from term "the index"[1][2],
and yet you haven't even responded.

I'm not even asking about this series, all I want to know is if any
change that tries to move away from the term "the index" towards
"staging area" would ever be considered for inclusion. Yes or no.

All I want is a simple answer to a simple question. Is that too much to ask?

[1] http://article.gmane.org/gmane.comp.version-control.git/233469
[2] http://article.gmane.org/gmane.comp.version-control.git/233468

-- 
Felipe Contreras
