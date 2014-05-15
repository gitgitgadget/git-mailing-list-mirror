From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] transport-helper: add trailing --
Date: Thu, 15 May 2014 07:32:14 +0200
Organization: <)><
Message-ID: <20140515053214.GA12133@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
        msysGit <msysgit@googlegroups.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBY5C2GNQKGQEEN4FL5Y@googlegroups.com Thu May 15 07:32:20 2014
Return-path: <msysgit+bncBCU63DXMWULRBY5C2GNQKGQEEN4FL5Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f188.google.com ([74.125.82.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBY5C2GNQKGQEEN4FL5Y@googlegroups.com>)
	id 1WkoHE-0008FL-3L
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 07:32:20 +0200
Received: by mail-we0-f188.google.com with SMTP id t61sf31630wes.25
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 May 2014 22:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:mime-version:organization
         :user-agent:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=OeA2H5gBONkKLxFyRi9n98N80X9bWiagn2SxmNPEOWc=;
        b=p2air+Qnwoa18c+W31PV9dGYasvTenhxDJEcdcPFmJPnAfKTrfWIcFeDnBEN8Ed4Mv
         q58LQ6wQf1kVPmeTEJopiQ6aupQ22+OGD/kq6YH0/K1jJUBJyNv93bG5QLLW7Y8Yc40F
         45IhAOcvPbizIi0h8g4ORSwoY7cWsP846vN6naSmP0nQQIqC3AMBrpNgko48D3raZpO1
         ZczqPmEj6xoFnA5aZi0xMkHXYC7tp7GOlV3sddwpEh8lZXcssCSLfgRs4t08KcSDqUVC
         pp1yIVymBVys4FofMARjxynFRF6wyf9IwX/+pym1SWa7gCjjrJALEH3b4+qWzoG8B6dh
         PKhw==
X-Received: by 10.152.197.4 with SMTP id iq4mr1112lac.21.1400131939731;
        Wed, 14 May 2014 22:32:19 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.30.2 with SMTP id o2ls6979lah.40.gmail; Wed, 14 May 2014
 22:32:18 -0700 (PDT)
X-Received: by 10.112.14.5 with SMTP id l5mr735019lbc.6.1400131938487;
        Wed, 14 May 2014 22:32:18 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id u49si1298808eeo.1.2014.05.14.22.32.18
        for <msysgit@googlegroups.com>;
        Wed, 14 May 2014 22:32:18 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 2E83A1C00B0;
	Thu, 15 May 2014 07:32:18 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4F5WHA8012276;
	Thu, 15 May 2014 07:32:17 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4F5WEZ4012275;
	Thu, 15 May 2014 07:32:14 +0200
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249059>

From: Sverre Rabbelier <srabbelier@gmail.com>
Date: Sat, 28 Aug 2010 20:49:01 -0500

[PT: ensure we add an additional element to the argv array]

Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---

Hi,
  this patch was present in msysgit from Mar 2012.
Do you like it?
I'm sorry, there is no author signoff; is the patch small enough?

Stepan

 transport-helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 0e7c330..a01ea47 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -429,7 +429,7 @@ static int get_exporter(struct transport *transport,
 	/* we need to duplicate helper->in because we want to use it after
 	 * fastexport is done with it. */
 	fastexport->out = dup(helper->in);
-	fastexport->argv = xcalloc(6 + revlist_args->nr, sizeof(*fastexport->argv));
+	fastexport->argv = xcalloc(7 + revlist_args->nr, sizeof(*fastexport->argv));
 	fastexport->argv[argc++] = "fast-export";
 	fastexport->argv[argc++] = "--use-done-feature";
 	fastexport->argv[argc++] = data->signed_tags ?
@@ -446,6 +446,8 @@ static int get_exporter(struct transport *transport,
 	for (i = 0; i < revlist_args->nr; i++)
 		fastexport->argv[argc++] = revlist_args->items[i].string;
 
+	fastexport->argv[argc++] = "--";
+
 	fastexport->git_cmd = 1;
 	return start_command(fastexport);
 }
-- 
1.9.2.msysgit.0.335.gd2a461f

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
