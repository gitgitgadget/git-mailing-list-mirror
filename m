From: Ben Boeckel <mathstuf@gmail.com>
Subject: Re: [PATCH] add ls-remote --get-push-url option
Date: Fri, 31 Jul 2015 15:04:15 -0400
Message-ID: <20150731190415.GA23674@megas.kitware.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
 <xmqqfv445fxv.fsf@gitster.dls.corp.google.com>
 <20150731185619.GA24622@megas.kitware.com>
 <xmqq4mkk5ex5.fsf@gitster.dls.corp.google.com>
Reply-To: mathstuf@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 21:04:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLFbS-00041I-Sh
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 21:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbbGaTET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 15:04:19 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36197 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbbGaTES (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 15:04:18 -0400
Received: by qkdv3 with SMTP id v3so32442669qkd.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=M2pVLrEQVF0Idl6XpG0rZ3eZwyChCSjXt6+Ug8H6lHQ=;
        b=wB5nfYKpr3FKvUSVKaKy2b07bzi4czhgAigu5O1dhB8ZGvHUXd5kUTnu8nVEW2kpw6
         +LJRSYjMqH1jq1la8YPvtKr6vjurO5f/+bpfV/QFHgpurySzfYx446gbzzLmdPMuW4PB
         CmWpJTop1evWYD6RC0TQTKxqZuvRHWde6Ki7bo03t96RtdsrYk87w8znJG4UI4tqgxWD
         YaNC45+xRKtu29XVSzXb8zYI4NPVtoX227eTJ/NH2ukauQcs2l/bjRlPC7jzGWApTLFR
         6X7u5cYz2dbN3ryYAy6W+16LM/KPLQSJf+cGs3vPbsP8xL9Amgw6Qp5LypHmCpVpYk4M
         vMAg==
X-Received: by 10.55.41.195 with SMTP id p64mr7001915qkp.5.1438369457614;
        Fri, 31 Jul 2015 12:04:17 -0700 (PDT)
Received: from megas (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id r22sm2678469qkr.2.2015.07.31.12.04.16
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 12:04:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq4mkk5ex5.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275067>

On Fri, Jul 31, 2015 at 12:02:14 -0700, Junio C Hamano wrote:
> Ben Boeckel <mathstuf@gmail.com> writes:
> 
> > With some sed, yes, but then so would `git remote show` just as useful
> > too (and in that case, "why does --get-url exist either?" comes to
> > mind).
> 
> Either carelessness let it slip in, or it came before 'git remote show'.

Would adding `git remote show --url $remote` and `git remote show
--push-url $remote` be acceptable?

--Ben
