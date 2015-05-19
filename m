From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] clean: remove unused variable buf
Date: Wed, 20 May 2015 00:13:26 +0200
Message-ID: <555BB586.8050503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 20 00:14:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuplu-0002LM-G3
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbbESWNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:13:54 -0400
Received: from mout.web.de ([212.227.15.3]:54462 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbbESWNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:13:53 -0400
Received: from [192.168.178.27] ([79.253.161.1]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LeLin-1ZWs0v0Pgj-00q7rH; Wed, 20 May 2015 00:13:48
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-Provags-ID: V03:K0:TaCyCZ3vZGVB+AvwqfqLExaXsoQ+KwulhVAhrTLaOjfjb6OYQy3
 Y/wKPLziYoZnqOKWrBCSJfkcfi3dWf3nruXsOyafCU22QpMVpZUM5qBkX59U60MAMZ8TqJu
 kltfeS51EvKmVER0I4T4Bq3s8GUmAbBe7W8W0YO7xk0lLSkS0/7SwWxK41OP4YX0WFay97D
 m/X9m+XX6bHJGc71EOm2w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269418>

It had never been used.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/clean.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98c103f..a9eb772 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -314,7 +314,6 @@ static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen)
 {
 	struct string_list menu_list = STRING_LIST_INIT_DUP;
 	struct strbuf menu = STRBUF_INIT;
-	struct strbuf buf = STRBUF_INIT;
 	struct menu_item *menu_item;
 	struct string_list_item *string_list_item;
 	int i;
@@ -363,7 +362,6 @@ static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen)
 	pretty_print_menus(&menu_list);
 
 	strbuf_release(&menu);
-	strbuf_release(&buf);
 	string_list_clear(&menu_list, 0);
 }
 
-- 
2.4.1
