From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 14 Jun 2011 02:17:58 +0200
Message-ID: <4DF6A8B6.9030301@op5.se>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>	<BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com>	<BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com>	<4DF0EC32.40001@gmail.com>	<BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com>	<20110609162604.GC25885@sigill.intra.peff.net> <BANLkTimEGjBMrbQpkZfWYPTZ93syiKFHdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git <git@vger.kernel.org>
To: NAKAMURA Takumi <geek4civic@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 02:18:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWHKd-0003Py-Ds
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 02:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab1FNASG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 20:18:06 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56762 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab1FNASE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 20:18:04 -0400
Received: by ewy4 with SMTP id 4so1789906ewy.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 17:18:02 -0700 (PDT)
Received: by 10.213.113.146 with SMTP id a18mr3054413ebq.121.1308010680434;
        Mon, 13 Jun 2011 17:18:00 -0700 (PDT)
Received: from vix.int.op5.se (c83-248-99-226.bredband.comhem.se [83.248.99.226])
        by mx.google.com with ESMTPS id v76sm2542367eea.3.2011.06.13.17.17.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 17:17:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <BANLkTimEGjBMrbQpkZfWYPTZ93syiKFHdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175738>

On 06/10/2011 05:59 AM, NAKAMURA Takumi wrote:
> Good afternoon Git! Thank you guys to give me comments.
> 
> Jakub and Shawn,
> 
> Sure, Notes should be used at the case, I agree.
> 
>> (eg. git log --oneline --decorate shows me each svn revision)
> 
> My example might misunderstand you. I intended tags could show me
> pretty abbrev everywhere on Git. I would be happier if tags might be
> available bi-directional alias, as Stephen mentions.
> 
> It would be better git-svn could record metadata into notes, I think, too. :D
> 
> Stephen,
> 
> 2011/6/10 Stephen Bash<bash@genarts.com>:
>> I've seen two different workflows develop:
>>   1) Hacking on some code in Git the programmer finds something wrong.  Using Git tools he can pickaxe/bisect/etc. and find that the problem traces back to a commit imported from Subversion.
>>   2) The programmer finds something wrong, asks coworker, coworker says "see bug XYZ", bug XYZ says "Fixed in r20356".
>>
>> I agree notes is the right answer for (1), but for (2) you really want a cross reference table from Subversion rev number to Git commit.
> 

If you're using svn metadata in the commit text, you can always do
"git log -p --grep=@20356" to get the commits relevant to that one.
It's not as fast as "git show svn-20356", but it's not exactly
glacial either and would avoid the problems you're having now.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
