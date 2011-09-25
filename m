From: Andreas Ericsson <ae@op5.se>
Subject: Re: Can a git changeset be created with no parent
Date: Sun, 25 Sep 2011 16:33:16 +0200
Message-ID: <4E7F3BAC.4020209@op5.se>
References: <1316960136073-6829212.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: vra5107 <venkatram.akkineni@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 16:33:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7plt-0004PF-ME
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 16:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840Ab1IYOdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 10:33:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40381 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab1IYOdW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 10:33:22 -0400
Received: by bkbzt4 with SMTP id zt4so4914604bkb.19
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 07:33:21 -0700 (PDT)
Received: by 10.204.154.10 with SMTP id m10mr3826540bkw.66.1316961199258;
        Sun, 25 Sep 2011 07:33:19 -0700 (PDT)
Received: from vix.int.op5.se (c83-248-99-226.bredband.comhem.se. [83.248.99.226])
        by mx.google.com with ESMTPS id y8sm17556749bkb.4.2011.09.25.07.33.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Sep 2011 07:33:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.20) Gecko/20110831 Fedora/3.1.12-2.fc14 Thunderbird/3.1.12 ThunderGit/0.1a
In-Reply-To: <1316960136073-6829212.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182076>

On 09/25/2011 04:15 PM, vra5107 wrote:
> Hi
> 
>          I am currently in the process of converting a large hg repository.
> One of the changesets has no parents assigned. So to mirror that is it
> possible to create a git changeset that doesnot have a parent ?
> 

Yes. Each and every project git has ever managed starts with a commit
just like that. In git lingo, it's called a "root commit".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
