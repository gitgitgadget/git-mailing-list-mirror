From: Jessica Lucci <jessicalucci14@gmail.com>
Subject: post-receive hooks based on push content
Date: Tue, 31 Jul 2012 13:27:57 -0500
Message-ID: <CAC=i8BzHi6UF=GEAiEdUzcjQM3NjibPw=p5S2uOeaE31nDkkjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 20:28:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwHAq-00034a-5a
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 20:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab2GaS17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 14:27:59 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37423 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab2GaS16 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 14:27:58 -0400
Received: by yenl2 with SMTP id l2so6392079yen.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Ao9v8k+5mWhGWOhlTLTR5xgXQNq9s+ZoUGzRuqkJ3oI=;
        b=Abzqpquh81KgneB4jAeZcaVM+eD17DfEeGWShYO/MbUzMRjCOjrm1K9fj0qSTkjSm/
         yM96590JvATwFO0smj3s+iI//w5opNELDuKRmIp5C8oowDyfmezBTnunoIouNqeQf3Em
         X/YDE4KU4nF2IJTAUfscQ90iGlwwB03WTe5VWt10GY0NfDWWbq1VRVxZi46T5ZLlUFJv
         P3wn8TTjYycUylXqvPGTK+QeN51vA8AMPZUZkyquH3DbVJ9Bl2x7n5aBaPusJTsUAw3z
         1vkF0Jz4cRnNYPJzCDO9f93aV3YFrkO9o+Bu9XsuJ3dU54L5W+WEoCT2IS70jtlWJkdm
         +nyQ==
Received: by 10.60.31.165 with SMTP id b5mr24634925oei.58.1343759277560; Tue,
 31 Jul 2012 11:27:57 -0700 (PDT)
Received: by 10.76.171.168 with HTTP; Tue, 31 Jul 2012 11:27:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202667>

Hey guys,

I'm trying to set up a post-receive hook that redirects code based on
the content of the actual push. Specifically, I'm trying to set up
automatic deployment of web apps with the option of sending the code
to a build farm first. For example, if you push your code to a git
repo, there should be a post-receive hook in there that looks to see
if /www is empty or something. If /www is empty, the app has yet to be
"built", so the hook should push the code to a build farm that can
compile the code into a WAR file (or whatever is appropriate). If /www
is already populated, we assume the code has already been compiled and
will then push the code directly onto the node.

So, first of all, is this even possible?
And if so, how would I go about writing this specific hook?

Thanks for your time!
Jessica
