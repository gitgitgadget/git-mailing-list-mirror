From: Rusty Dog Ink <chris@rustydogink.com>
Subject: A little help with error?
Date: Sun, 7 Aug 2011 14:16:57 -0700
Message-ID: <752985D1B23046F994920F9018B53DF8@rustydogink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 23:17:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqAiY-0000pS-L2
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 23:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302Ab1HGVRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 17:17:01 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:53174 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262Ab1HGVRA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 17:17:00 -0400
Received: by pzk37 with SMTP id 37so7171017pzk.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 14:16:59 -0700 (PDT)
Received: by 10.142.178.21 with SMTP id a21mr3672391wff.445.1312751819810;
        Sun, 07 Aug 2011 14:16:59 -0700 (PDT)
Received: from Betty.local (24-113-151-157.wavecable.com [24.113.151.157])
        by mx.google.com with ESMTPS id b4sm5583425pba.59.2011.08.07.14.16.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 14:16:59 -0700 (PDT)
X-Mailer: sparrow 1.2.1 (build 767.23)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178928>

This command. 
git add --force /Users/chris/Sites/mattSchubert/public/css/browserfix.css => "Crappy Error"
Yields this error.
fatal: '/Users/chris/Sites/mattSchubert/public/css/browserfix.css' is outside repository 
This command does gives the same error. 
git add --force /public/css/browserfix.css => "Same error"
But this command, works. Why?
git add --force public/css/browserfix.css => "Works yeah"
This is an issue since Gitbox my graphical client uses full paths for it's commands. This began happening after I use the "bundle install" command after adding 'dm-postgres-adapter' to my gem file. Ideas on fixing this?

-- 
Chris
Sent with Sparrow (http://www.sparrowmailapp.com)
