From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Tue, 20 Mar 2012 14:31:19 -0400
Message-ID: <CACPiFCLbTA=AwymUOde43Z61t9cd5O=uk_hs5Dt6WZhYYg06zA@mail.gmail.com>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <7vty1ndcoi.fsf@alter.siamese.dyndns.org>
 <CACPiFCKbfgSZMnpc6Q_Lg6n5YMHQ2bad-bwQsyASk0eMuiAFTQ@mail.gmail.com> <7vy5qv70mh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 19:31:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA3qT-00089c-RP
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 19:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864Ab2CTSbl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 14:31:41 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54053 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab2CTSbk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2012 14:31:40 -0400
Received: by iagz16 with SMTP id z16so363242iag.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yFycLCobquKAV3EnAuZXrRpjzjVmLcEN8M2YdmJyqXE=;
        b=tIC+mAkcez/2EkHwQWpng1HtTnldLREiZmF3gaCnPR5pulng6LWf5LCo3ruAiIpRJh
         03cazKZGoGhvFiGIMzvU+z55VbSGPMdKAV+WN9uOPYkY5xlGloYQRsU+8+ddkqKatXPN
         qgq469EKT04QGCxu9PQovT3LDLSoLHdOItGldvBt6S+1C0Yt/K4DP4qkV2C1mjFvUICu
         7uDQOgajMvFzTghOSRrRQlag7XfQ6AGvJDmCYj/rvF6NZpxzXJCqUWEk5G3zJhutOg7B
         51V7uy410QDUP/aTbvWWa85dAFr9+dAiE314lsQ2KUd2GVlSb9Wd7xro1NuN6tf2/Cxx
         0HuA==
Received: by 10.50.40.166 with SMTP id y6mr687679igk.69.1332268299743; Tue, 20
 Mar 2012 11:31:39 -0700 (PDT)
Received: by 10.42.239.131 with HTTP; Tue, 20 Mar 2012 11:31:19 -0700 (PDT)
In-Reply-To: <7vy5qv70mh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193531>

On Tue, Mar 20, 2012 at 11:28 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> As many people already said in the discussion before the RFD message =
that
> is at the root of this thread, the name of the option --force alone
> already signals it is something you use after thinking twice.

Definitely. You may think twice about the branch you' re planning to
force-update. "Do I really want to force-update <this>?". But it
doesn't mean you know and fully understand the "push default" rules of
git.

With "immediately" I mean "sooner than several releases away".

In any case, seems I missed the train and the discussion is closed;
I'll head back to my cave.

cheers,



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
