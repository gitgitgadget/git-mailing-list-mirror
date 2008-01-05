From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git-walkthrough-add script
Date: Sat, 5 Jan 2008 00:17:49 +0000
Message-ID: <8666B7CA-D47F-40A0-88A2-3756C0663296@simplicidade.org>
References: <1199426431-sup-6092@south> <2CC98B8C-CBB1-4C26-8C94-B152A4D02DDC@simplicidade.org> <1199491057-sup-5588@south>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: William Morgan <wmorgan-git@masanjin.net>
X-From: git-owner@vger.kernel.org Sat Jan 05 01:18:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAwjs-000395-Rd
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 01:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbYAEARq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 19:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753749AbYAEARq
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 19:17:46 -0500
Received: from mail.sl.pt ([212.55.140.13]:54432 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753674AbYAEARp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 19:17:45 -0500
Received: (qmail 12184 invoked from network); 5 Jan 2008 00:17:41 -0000
X-Virus-Status: Clean (0.01048 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00008 seconds / 0.04595 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [192.168.1.65]) (melo@[85.241.127.244])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 5 Jan 2008 00:17:41 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 85.241.127.244 as permitted sender)
In-Reply-To: <1199491057-sup-5588@south>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69618>

Hi,

On Jan 5, 2008, at 12:02 AM, William Morgan wrote:
> Excerpts from Pedro Melo's message of Fri Jan 04 15:26:41 -0800 2008:
>> You script asks me to add all the changes in the same file at once.
>
> It shouldn't. The whole point is to walk through and allow  
> selection on
> a per-hunk basis.
>
> Maybe I'm parsing the output of git diff incorrectly and not  
> picking up
> hunk boundaries? Would you mind sending the output of a git diff that
> results in this behavior?

I used a new git repo, just to test your script.

The diff is:

------ snip
diff --git a/a b/a
index b6b8cab..456bb2d 100644
--- a/a
+++ b/a
@@ -1,4 +1,5 @@
  asasas
+****
  assas
  assas
  asas
@@ -37,6 +38,7 @@ asasas
  assas
  assas
  asas
+=fsdfsdfsadfasdfsad=

  asasas
  assas
@@ -46,5 +48,6 @@ asas
  asasas
  assas
  assas
+asdasdasdasda=DASD=AS=DA=SD=
  asas

------ snip

Best regards
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
