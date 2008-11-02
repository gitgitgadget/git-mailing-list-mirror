From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: [PATCH] Document that git-log takes --all-match.
Date: Sun, 2 Nov 2008 19:32:46 +0100
Message-ID: <237967ef0811021032j15f7d9cbudfdf9350bc521cd6@mail.gmail.com>
References: <237967ef0811021028w3aa22411t99b2203a9148bbf6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 19:34:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwhly-00048w-NJ
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 19:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbYKBSct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 13:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753994AbYKBSct
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 13:32:49 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:29219 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbYKBScs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 13:32:48 -0500
Received: by ey-out-2122.google.com with SMTP id 6so727168eyi.37
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 10:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pxSLlRsHIrc525nr+Yi8zFBxW2cYkLUU7XFeit/Koqs=;
        b=wYcv3e/9+DD29ft3hzcSqjtQR3vZmwhBTuwH3txtMcKGM9HTYtppa6dSmw0WzeXgYY
         KaTYdxwS04Wb7UTdZFdVXhhvccSfU+Z7HVc2tBIIADjLTsNOXhlsbAxp7QxCqCnC901I
         Qc/jif+oZ3TijVk6DsRK7FCVi4B5qUcvaA6V8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=H3sQwJ3VIvfjA+QU/6cSkV98wDyUyYNLr11kZWi4RaATpgJJyjXeUu5UdcZvjUCwWb
         XSeDGo3rHZTHBJXMHnNNtY5ieFE7MeAFVoYQIuHVoSRUUwjOhsqveozlDYnKWNL5XGQq
         lyX8KAKLJes2lKYCKHhDkYvk74tHbyu7xZrno=
Received: by 10.210.143.11 with SMTP id q11mr727380ebd.146.1225650766253;
        Sun, 02 Nov 2008 10:32:46 -0800 (PST)
Received: by 10.210.73.14 with HTTP; Sun, 2 Nov 2008 10:32:46 -0800 (PST)
In-Reply-To: <237967ef0811021028w3aa22411t99b2203a9148bbf6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99860>

Signed-off-by: Mikael Magnusson <mikachu@gmail.com>

---

It's already listed in the bash completion. Feel free to reword.
Looking at this I can't help but feel that the text for
--grep/--author/--committer is misleading, since they say they will
limit to commits blabla, but they don't if another is given. Ie they
only do what they say if you give the --all-match option.

 Documentation/rev-list-options.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

index 0ce916a..966276b 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -174,6 +174,10 @@ endif::git-rev-list[]
       Limit the commits output to ones with log message that
       matches the specified pattern (regular expression).

+--all-match::
+       Limit the commits output to ones that match all given --grep,
+       --author and --committer instead of ones that match at least one.
+
 -i::
 --regexp-ignore-case::

--
1.6.0.2.GIT

--
Mikael Magnusson
