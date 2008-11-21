From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: TopGit: ensure worktree (was: [TopGit PATCH] Check for help invocation before setup)
Date: Fri, 21 Nov 2008 13:18:42 +0100
Message-ID: <36ca99e90811210418i5ae14a42t882988aed289d534@mail.gmail.com>
References: <1227110623-4474-1-git-send-email-madduck@debian.org>
	 <1227110623-4474-2-git-send-email-madduck@debian.org>
	 <36ca99e90811210119s215513a8m7c12c8d55fd54d70@mail.gmail.com>
	 <20081121120609.GA10326@piper.oerlikon.madduck.net>
	 <36ca99e90811210415g7b50c5c1m3185bf19cab104aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "petr baudis" <pasky@suse.cz>,
	501982@bugs.debian.org
To: "martin f krafft" <madduck@debian.org>
X-From: git-owner@vger.kernel.org Fri Nov 21 13:20:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3UzP-0001do-KA
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 13:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbYKUMSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 07:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbYKUMSo
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 07:18:44 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:65071 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbYKUMSo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 07:18:44 -0500
Received: by an-out-0708.google.com with SMTP id d40so394892and.1
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 04:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zC04NUzuC0m7WHvw//X+uHogjIBzFRhBMAx3eWsQDVE=;
        b=VRHVo3yr7fV6s5vMPl4iaaDvMFOzNg5QGeV5VuJkwvap+WW5jaDTiWRRdgEpAV2Nfm
         pRpJDwMbZBK90u9RNzx5DPQU5jV+nJZhnnDUFbHPGa8LLDAkeYK3hqt3yZ5v5EEmR/t+
         zrlKRgwDG+AqT5GrV2y8KIcYioVwWQofe7a+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DMtxJrgp88Vvb3odx9HCarzZPdpq33MI0rmcc7olYJIbGetyOaLP7f9+VTtPeTKFx7
         1tUJhENopr37QQK3nLbPRM0WNz3+TQz6mrXjV+rkVJfR8gYRTbAgCHzwKNLV6lyn9tah
         JWQ7E5BnJTQt0zR639BVa0UscfYN3GLfu6ofs=
Received: by 10.64.183.1 with SMTP id g1mr375369qbf.26.1227269922646;
        Fri, 21 Nov 2008 04:18:42 -0800 (PST)
Received: by 10.65.148.5 with HTTP; Fri, 21 Nov 2008 04:18:42 -0800 (PST)
In-Reply-To: <36ca99e90811210415g7b50c5c1m3185bf19cab104aa@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101518>

On Fri, Nov 21, 2008 at 13:15, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> On Fri, Nov 21, 2008 at 13:06, martin f krafft <madduck@debian.org> wrote:
>> I think you wanted to CC Petr, not Junio. It's also useful to CC
>> Debian bugs if you know of them. :)
> I CC'ed Junio, because I think this git rev-parse --git-dir is a bug.
> For example you can try starting git gui inside a .git dir.
Oh, I send a patch only to petr, but forgot to cc the list ;-)

But your patch should be fine, thanks.

Bert
