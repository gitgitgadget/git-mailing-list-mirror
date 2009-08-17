From: Thomas Schlichter <thomas.schlichter@web.de>
Subject: Re: git http-push and MKCOL error (22/409)
Date: Mon, 17 Aug 2009 19:28:38 +0200
Message-ID: <200908171928.38999.thomas.schlichter@web.de>
References: <200908161557.26962.thomas.schlichter@web.de> <200908170725.09592.thomas.schlichter@web.de> <20090817170943.180dbedd.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	willievu <willievu@dev.java.net>,
	Sean Davis <sdavis2@mail.nih.gov>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:30:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md62c-0006Kk-77
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 19:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757723AbZHQRac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 13:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757704AbZHQRab
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 13:30:31 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:34555 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757699AbZHQRab (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 13:30:31 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id ED65D114EA10B;
	Mon, 17 Aug 2009 19:28:41 +0200 (CEST)
Received: from [92.207.103.184] (helo=netbook.localnet)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1Md60f-0006bR-00; Mon, 17 Aug 2009 19:28:41 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.28-14-generic; KDE/4.3.0; i686; ; )
In-Reply-To: <20090817170943.180dbedd.rctay89@gmail.com>
X-Sender: thomas.schlichter@web.de
X-Provags-ID: V01U2FsdGVkX1/qhjh70Z7YrsaV8ZZ6PK2B/eWDAc2nV/Urq7mu
	w6gLPbUj2z7byWxstEhWtxZiE4gCXTeH4rMxdnF//z+VfYUtp/
	UPweUX1lYRFYrY/cm/7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126242>

Hi,

Am Montag 17 August 2009 11:09:43 schrieb Tay Ray Chuan:
> Subject: [PATCH] http.c: don't assume that urls don't end with slash
>
> Make append_remote_object_url() (and by implication,
> get_remote_object_url) use end_url_with_slash() to ensure that the url
> ends with a slash.
>
> Previously, they assumed that the url did not end with a slash and
> as a result appended a slash, sometimes errorneously.
>
> This fixes an issue introduced in 5424bc5 ("http*: add helper methods
> for fetching objects (loose)"), where the append_remote_object_url()
> implementation in http-push.c, which assumed that urls end with a
> slash, was replaced by another one in http.c, which assumed urls did
> not end with a slash.
>
> The above issue was raised by Thomas Schlichter:
>
>   http://marc.info/?l=git&m=125043105231327
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

Thank you very much!
This patch indeed fixes my problem.

You may add my

   Tested-by: Thomas Schlichter <thomas.schlichter@web.de>

if you'd like to. I don't know how this is handled in the git-tree...

Is there a plan in which version this patch will be released? Will there be a 
1.6.4.1 or is 1.6.5 next?

Kind regards,
Thomas Schlichter
