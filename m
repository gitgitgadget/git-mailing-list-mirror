From: Igor Lautar <igor.lautar@gmail.com>
Subject: Re: commit gone after merge - how to debug?
Date: Mon, 26 Nov 2012 14:29:19 +0100
Message-ID: <CAO1Khk9mzJjnysnc1iDFeMgqnRq0z35t0kgC-8nrsjJ-oOvdOg@mail.gmail.com>
References: <CAO1Khk_eugH--wp3s-gr4HTvuRyL=SaWHWtEXCRZ_Ak7+s5U=w@mail.gmail.com>
	<1353935441-ner-9639@calvin>
	<vpqr4ngsdjl.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 26 14:29:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcykh-0002ql-0y
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 14:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab2KZN3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 08:29:20 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:59482 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab2KZN3T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 08:29:19 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so5587566vbb.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 05:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e7hnPLLaEDj8hBbtPKRTSb2C9q/DftND1MffwRII/3g=;
        b=g74A6xm5cYRFaXm/w7odQtrW37yCfi2SCFeU5ouonfvoiTFQAtD0Qx8xeBVPrEAP0/
         2pEWNJCW75T4c8VJHdXAX2eX0++MGoUL2mKD02dm+XaWSVxpLcoGArMbkvQd73TA7s1K
         ZQBwB3qZNzL+sT/6bHU/VoUkhwevXyYY0LWpwLL80QXfzQoWTOB/gGkJ8UIjEgbtH47A
         o+Q7TsVDu8cJnfE5Ik5lpTexGuMZRxdOlapHUzk5NKVlXwOKac0uMJhLfqZCem4NnrIj
         2fcWMzYoc0c6uGU2jKZn2A+06zGZ5GM5sGpSmDAy2iZZUVBkUmgxEZ/sRtYZEY9Jy0Iz
         QxFQ==
Received: by 10.52.175.225 with SMTP id cd1mr16481867vdc.130.1353936559275;
 Mon, 26 Nov 2012 05:29:19 -0800 (PST)
Received: by 10.58.69.112 with HTTP; Mon, 26 Nov 2012 05:29:19 -0800 (PST)
In-Reply-To: <vpqr4ngsdjl.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210445>

On Mon, Nov 26, 2012 at 2:23 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> The other related question being: does reading the section "History
> Simplification" in "man git-log" help? ;-)

Somewhat, but it does not explain why the file no longer has that
change. I can understand omitting history if end result is the same,
but here it shouldn't be - I cannot find a commit that reversed that
change, so the change should still be in after the merge?

The file in question was not modified on mirror, nor was modified on
origin after that change.
