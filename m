From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: which git commands is  correponding to "svnlook diff -t" and
 "svnlook log -t"?
Date: Tue, 02 Nov 2010 10:13:36 +0100
Message-ID: <4CCFD640.6070909@debugon.org>
References: <30111518.post@talk.nabble.com> <vpq8w1cxfkk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: samilkarahan <samilkarahan@yahoo.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Nov 02 10:13:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDCw6-00022L-Pb
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 10:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab0KBJNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 05:13:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:58880 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468Ab0KBJNk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 05:13:40 -0400
Received: from [172.20.2.23] (p578D1764.dip.t-dialin.net [87.141.23.100])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0LyBCX-1OY2kv3AWb-015bV5; Tue, 02 Nov 2010 10:13:36 +0100
User-Agent: Thunderbird 2.0.0.24 (X11/20101027)
In-Reply-To: <vpq8w1cxfkk.fsf@bauges.imag.fr>
X-Provags-ID: V02:K0:ArvYarMOErfXMw66e/XBzpsCY2/9OtNqCEftOmgrue1
 NRk79CVZaaWpzLs8bjfLgxxRL0aD8FVtw+vvAibcla1i4tWXuV
 DMW2ki1Yr/Ie1+cGpn94o8bOiEBkrDATKwfHiqtS4ho8w44Cl+
 lUmNJfomJL/EipvQoGZH5ylYRkzKtul/6L8lgJFDfnofRFkJg0
 U8vE2PWXNlRCkHryWYSIhCv+v/n5qn01uQ30b0mspM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160514>

Matthieu Moy wrote:
> samilkarahan <samilkarahan@yahoo.com> writes:
> 
>> Hi,
>>
>> I have developed pre-commit hook, but it only run for svn hook. 
>>
>> I want to run it for git hook,But I don't know git well like svn ,so 
>>
>> I haven't found corresponding git command to svn commands which are "svnlook
>> diff -t" and "svnlook log -t".
>>
>> these commands take two parameter in svn.
> 
> What do these commands do in SVN?
> 

$ svnlook help diff
diff: usage: svnlook diff REPOS_PATH

Print GNU-style diffs of changed files and properties.

Valid options:
  -r [--revision] ARG      : specify revision number ARG
  -t [--transaction] ARG   : specify transaction name ARG
  --no-diff-deleted        : do not print differences for deleted files
  --no-diff-added          : do not print differences for added files
  --diff-copy-from         : print differences against the copy source
  -x [--extensions] ARG    : Default: '-u'. When Subversion is invoking an
                             external diff program, ARG is simply passed
along
                             to the program. But when Subversion is
using its
                             default internal diff implementation, or when
                             Subversion is displaying blame annotations, ARG
                             could be any of the following:
                                -u (--unified):
                                   Output 3 lines of unified context.
                                -b (--ignore-space-change):
                                   Ignore changes in the amount of white
space.
                                -w (--ignore-all-space):
                                   Ignore all white space.
                                --ignore-eol-style:
                                   Ignore changes in EOL style

$ svnlook help log
log: usage: svnlook log REPOS_PATH

Print the log message.

Valid options:
  -r [--revision] ARG      : specify revision number ARG
  -t [--transaction] ARG   : specify transaction name ARG


Though I have no idea what "transaction" means here?

Apart from that, I guess "svnlook log" corresponds to "git log" and
"svnlook diff" to "git log -p".

-Mathias
