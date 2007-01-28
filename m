From: David Lang <david.lang@digitalinsight.com>
Subject: Re: More precise tag following
Date: Sun, 28 Jan 2007 14:26:16 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0701281425270.26863@qynat.qvtvafvgr.pbz>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>  <20070127080126.GC9966@spearce.org>
  <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> 
 <45BB9C8B.8020907@fs.ei.tum.de>  <Pine.LNX.4.64.0701271103520.25027@woody.linux-foundation.org>
 <204011cb0701271136m655815f6o1501de2bf699b362@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Chris Lee <clee@kde.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 23:41:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBIia-0006ub-RN
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 23:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928AbXA1Wlp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 17:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932935AbXA1Wlp
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 17:41:45 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:63414 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932928AbXA1Wlo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 17:41:44 -0500
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sun, 28 Jan 2007 14:41:44 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sun, 28 Jan 2007 14:36:52 -0800
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <204011cb0701271136m655815f6o1501de2bf699b362@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38052>

if nobody else steps forward I can arrange something like this on my home server 
(only 768K updtream bandwidth, but it's better then nothing)

Daivd Lang

On Sat, 27 Jan 2007, Chris Lee wrote:

> Date: Sat, 27 Jan 2007 11:36:50 -0800
> From: Chris Lee <clee@kde.org>
> To: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
>     Shawn O. Pearce <spearce@spearce.org>, Junio C Hamano <junkio@cox.net>,
>     git@vger.kernel.org
> Subject: Re: More precise tag following
> 
> On 1/27/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> Do you have the converted repo somewhere to be cloned for? It's going to
>> be a lot more interesting for scalability testing than anything else.
>
> I don't have access to any servers that I could drop a 3GB packfile
> onto and expect them to serve it. And I don't have a connection at
> home that I could use to upload the 3GB pack from quickly - it would
> take days, at least. If anybody wants to hook me up with a hosting
> provider or a machine that just the git devs can access, I'd be
> willing to tie up my upstream bandwidth for a few days so you all can
> have access to it.
>
>> The thing is, one of the reasons the git object database is small is that
>> it compresses really well, and I suspect that for the KDE repo, what
>> you're seeing is really a combination of:
>>
>>  - the KDE people were idiots in the first place to make it into one big
>>    repo
>
> No argument from me about this one. The only defense I can really
> think of is that, in KDE, we *have* moved entire applications and
> libraries around between modules, and it is really nice to be able to
> have the full history for them.
>
>> So please point to a kde conversion archive to play with (maybe you have,
>> I missed it).
>
> I can provide you with instructions on how to reconstruct one, but
> you'll have to rsync over about 38GB of KDE's Subversion archive to do
> it. (Not fun.) If someone else wants to give me a dumping ground where
> I can upload my 3GB converted repo, I'd be happy to start pushing it.
>
> Also, please note, the 3GB packed repo is only about 2/3 of the full
> KDE repo - I cut off the import at revision 409202, because that was
> when the KDE svn admins decided to move a bunch of modules from
> /trunk/ to /trunk/KDE/ and it screws up everything. So a *full* KDE
> history import would definitely be more than 4GB, packed.
>
> -clee
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
