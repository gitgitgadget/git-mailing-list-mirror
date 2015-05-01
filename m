From: Alangi Derick <alangiderick@gmail.com>
Subject: Patch for readability enhancement
Date: Fri, 1 May 2015 12:07:25 +0100
Message-ID: <CAKB+oNuh26vrwd2=TRQQs6fFFQ-O16Ouh3WxySxWgYx03sKhCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 13:07:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yo8n6-0007ep-W1
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 13:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbbEALH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 07:07:28 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35589 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbbEALH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 07:07:26 -0400
Received: by qkhg7 with SMTP id g7so48827561qkh.2
        for <git@vger.kernel.org>; Fri, 01 May 2015 04:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=dT+bclc/J0phAet4CmvnUpgZ0cFGY18y2Z2yTIbsXzc=;
        b=ocTI6S6tnm+4CzStCeSWxpJGiGJXdRRQwywZd6HXk7QtrV34qAD+NIPzvHESCRnVJh
         h5EXX2t308M1/C2Ff8pnhlRKX2uPxuE1DtDk52RdzFiicat8Ekdd7KBvTTBgEjFj+dx3
         BMlT/UN/2piC4UqOnU6NikJhsflKwIWFZH4dYO/OgFCXyzm6YO19G5QxVCOCA/fE991R
         5Etw33YqKPVJAZMdKsozNO0lkDqy7vPBXyjWRzrJDw2rt4FYZuR/ebt50I4nB/5X1xy/
         oodTpTcRbHmvK6nY+4u+P0REXkrUXU7BcnzQyxn07lleJ+y5YwHQIijbOMPJgU+SFHvv
         NBRA==
X-Received: by 10.140.192.73 with SMTP id n70mr11009591qha.91.1430478445984;
 Fri, 01 May 2015 04:07:25 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Fri, 1 May 2015 04:07:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268114>

This patch is to enhance readability and consistency in English to the
users of Git

diff --git a/git.c b/git.c
index 42a4ee5..481aa74 100644
--- a/git.c
+++ b/git.c
@@ -667,7 +667,7 @@ int main(int argc, char **av)
  } else {
  /* The user didn't specify a command; give them help */
  commit_pager_choice();
- printf("usage: %s\n\n", git_usage_string);
+ printf("Usage: %s\n\n", git_usage_string);
  list_common_cmds_help();
  printf("\n%s\n", _(git_more_info_string));
  exit(1);

Regards
Alangi Derick Ndimnain
