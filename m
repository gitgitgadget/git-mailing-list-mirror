From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Unexpected cherry-pick behaviour
Date: Sat, 14 Dec 2013 20:47:10 +0100
Message-ID: <CALWbr2wZ2tid45u8_ew2PH7tco7XkqY=gaUFEPKm9UN8Xk9HLg@mail.gmail.com>
References: <118044938ad8ebf6b069bcc1d220a986@matos-sorge.com>
	<xmqqvbywts9d.fsf@gitster.dls.corp.google.com>
	<7050e7272bb83d083a56a2c391228ed8@matos-sorge.com>
	<CALWbr2zPPnDiv7oVBhnM9dSW=pfz2jUA_A5u_gk2ttgXTStvkw@mail.gmail.com>
	<beee32a53ece8b839578703deb851eaa@matos-sorge.com>
	<CALWbr2y1YDX0dzjpZoF8WL4+ND+8drurH+Wrf1wBs_-=0datOA@mail.gmail.com>
	<7vvbyrgrcv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paulo Matos <paulo@matos-sorge.com>, git <git@vger.kernel.org>,
	git-owner@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 20:47:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrvBD-00078A-SU
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 20:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab3LNTrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 14:47:12 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:48476 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab3LNTrL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 14:47:11 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so3770210pde.21
        for <multiple recipients>; Sat, 14 Dec 2013 11:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Qa4jKmQJB9au/v3KRQdhQhXjIP7IfkVJX/65CwXg470=;
        b=uVwBJvi0LfEADLWrc97HMXJo3tL4gfL1jFpS8V7l5w7kaIpByQ/6msmKHgCA2GtN5d
         nQr03qdwLlpigt8b47L6rs7e+0g+9TZsqQy92iVMgquMhDglhft/UUmLIe2DeAbJcUiC
         SaK6NsHGv2NSqrolN1QTeU40Us5UczFMGIm77fE4NVzPfFGiXk+bUY+CQPN5+KbgtxIK
         UTe3zPte5fW/we1vO1p91cHlHzAZy71u6T8aipUDH2u0EXEv4TVbqZVBjC7Csz/J8xJz
         bqbZoElVZ78yjzrx/WWuu4lf9aKmsgZ4lBKm9TNykKqroZiAem4jxBpMU06zyYt1dlEr
         s4iw==
X-Received: by 10.68.190.33 with SMTP id gn1mr11192643pbc.48.1387050431008;
 Sat, 14 Dec 2013 11:47:11 -0800 (PST)
Received: by 10.70.124.228 with HTTP; Sat, 14 Dec 2013 11:47:10 -0800 (PST)
In-Reply-To: <7vvbyrgrcv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239315>

On Sat, Dec 14, 2013 at 8:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> If you only want to see the diff applied to master, you
>> should run:
>>
>>     $ git diff --ours
>
> Does "git diff HEAD" have the same/similar effect?

Yes, it does produce the same output as --ours.

>> You can also have a look at what is currently being applied:
>>
>>     $ git diff :1:gcc/tree-ssa-threadedge.c :3:gcc/tree-ssa-threadedge.c
>>
>> By the way, does anybody know a better way to do that ?
>
> In a merge, you can say "git diff ...MERGE_HEAD" (three-dots).  You
> should be able to tell "git show" the commit you are trying to pick
> during a cherry-pick, I think.

Thanks,
