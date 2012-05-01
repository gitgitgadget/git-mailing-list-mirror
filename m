From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 14:25:14 -0700
Message-ID: <4FA054BA.80601@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com> <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com> <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com> <7v62cf8v2d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 23:25:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPKZv-0000tM-VY
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 23:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770Ab2EAVZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 17:25:22 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:25868 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab2EAVZW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 17:25:22 -0400
X-IronPort-AV: E=Sophos;i="4.75,513,1330934400"; 
   d="scan'208";a="13249381"
Received: from unknown (HELO ushqusdns3.palm.com) ([148.92.223.90])
  by smtp-relay2.palm.com with ESMTP; 01 May 2012 14:25:15 -0700
Received: from fuji.noir.com ([10.100.2.1])
	by ushqusdns3.palm.com (8.14.4/8.14.4) with ESMTP id q41LPENI001006;
	Tue, 1 May 2012 14:25:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7v62cf8v2d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196754>

On 5/1/12 14:12 , Junio C Hamano wrote:
> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>
>> Rich>  I want that if you and say, Sitaram commit conflicting changes to
>> Rich>  a shared branch, it's easy for me to recognize that the conflict
>> Rich>  exist and easy for me to resolve that conflict in my own
>> Rich>  repository.  I want the source code control system to keep track
>> Rich>  of those things, show them to me/us, and to track and show my
>> Rich>  resolution to you.  This stuff should all be automatic.  It
>> Rich>  shouldn't require explicit testing, manual pulling, nor explicit
>> Rich>  discussion between the three of us.  It shouldn't prohibit that
>> Rich>  either, but it shouldn't require it.
>>
>> You're asking a lot of an automated system.  I think you're trying to
>> get a system to replace the communication you should be doing as a
>> developer.
>
> While what Merlyn says is always right ;-), you could automate things by
> having your post-receive hook to notice that remotes/from-merlyn/master
> location was updated, attempt an automerge, and then report a failure.
>
> Not everybody wants such an automated system, so there is no such
> complexity in the vanilla setting, but the important thing is that whoever
> needs such a complexity could easily do so.

I think we have different definitions of "easily".  This is simple, 
first use sorts of stuff.  I've already invested weeks in trying to 
understand git enough to use it and I still don't have a process I like, 
much less do I know how to write a post-receive hook.  I'm sure I could, 
given enough time.  But frankly, I could switch to a different source 
code control system in less time.

Simple things should be simple.  They shouldn't require in-depth 
knowledge and customization of the tool.

In other systems, the automation is optional, but it's available.  If 
you want to vet each and every change as you take it, you can.  But you 
don't have to.

--rich
