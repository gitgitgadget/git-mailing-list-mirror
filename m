From: Junio C Hamano <junkio@cox.net>
Subject: Re: git/gitweb - feature request: Add description to the branches.
Date: Wed, 07 Sep 2005 18:27:59 -0700
Message-ID: <7vll281h7k.fsf@assigned-by-dhcp.cox.net>
References: <87ll2aib73.fsf@gmail.com> <431DA8CD.9060009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp-2
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 03:31:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDBCy-0005yM-OC
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 03:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbVIHB2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 21:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbVIHB2D
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 21:28:03 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:23285 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932827AbVIHB2B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2005 21:28:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050908012758.BIBB11315.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Sep 2005 21:27:58 -0400
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <431DA8CD.9060009@gmail.com> (A. Large Angry's message of "Tue,
	06 Sep 2005 10:33:49 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8187>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Santi B.ANijar wrote:
> [...]
>>         One thing I'm missing is a way to describe a branch. It can
>> be
>>         done in the $GIT_DIR/description, the first line for the whole
>>         repository and the rest for the branches. So description file
>>         for the git.git repository could be:
>> [description]
>> The core git plumbing
>> pu: Proposed updates
>> rc: Release candidate
>> todo: Todo list
>> [/description]
>>         And it can be added to the gitweb tool.
>
> Having somewhere to describe the intent of a branch would be a useful 
> convention. But I think the descriptions should be in separate files; 
> one for each branch and one for the repository as a whole.

This reminds me of somebody else wanting to have 'motd' in
git-daemon.  Once we have a common data format we could also
serve this information from there, and possibly from
'git fetch --motd'; pass that to 'git-peek-remote --motd' for git
and ssh transports, and do something else using curl for http
transport.

Anybody interested?  I think the git-daemon side would be the
cleanest if we introduce a new program to format the motd
information and send it out, instead of attempting to enhance
git-upload-pack protocol; I do not think the latter can be
done in a backward compatible way.
