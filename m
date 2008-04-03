From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Re: Can I switch a git-svn clone from a file => http url?
Date: Wed, 2 Apr 2008 22:06:48 -0400
Message-ID: <p06240802c419e22d78a7@[63.138.152.125]>
References: <p06240804c41942f6276e@[192.168.1.114]>
 <20080402151721.GA31738@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 04:14:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhEyD-0003zk-0G
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 04:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758651AbYDCCNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Apr 2008 22:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758649AbYDCCNo
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 22:13:44 -0400
Received: from deanbrook.org ([66.160.189.173]:56223 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758112AbYDCCNn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2008 22:13:43 -0400
Received: from 72.173.30.166 ([72.173.30.166]) by deanbrook.org for <git@vger.kernel.org>; Wed, 2 Apr 2008 19:13:39 -0700
In-Reply-To: <20080402151721.GA31738@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78722>

Thanks Bj=F6rn,

At 5:17 PM +0200 4/2/08, Bj=F6rn Steinbrink wrote:
>On 2008.04.02 10:38:34 -0400, Stephen Bannasch wrote:
> > Is there an operation I can now do to switch the base url from:
>>
>>   file:///Path/to/svn/repository/projects
>>
>> to
>>
>>   https://svn.concord.org/svn/projects
>
>Basically, this should work:
>
>Change the URL to the repo in your .git/config.

Done

>Use filter-branch to change all git-svn-id lines in the log entries.

I've just started using git so please forgive the beginner questions.

What should I change the log entries to?

Here's what the log entries look like now:

$ git-filter-branch --msg-filter 'echo $GIT_COMMIT'
^MRewrite 89817efa5b290d375786a5af9a0dcc338df8a68c (1/13099)^MRewrite b=
090d1d40cba2c66a494d52e370317487d103484 (2/13099)^M

Do you mean each one should just be re-written to a new SHA1 keys? If s=
o how should I generate new SHA1 keys?

>The filter-branch call should use the --msg-filter option to change th=
e
>log entries and should apply to all the svn branches/tags/trunk (or ju=
st
>use " -- --all", if there's nothing that may not be filtered).
>
>HTH
>Bj=F6rn
>--
>To unsubscribe from this list: send the line "unsubscribe git" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
