From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Syntax highlighting for combined diff
Date: Sat, 21 Oct 2006 12:02:00 +0200
Message-ID: <200610211202.00314.jnareb@gmail.com>
References: <ehbq0k$24l$1@sea.gmane.org> <200610211049.56477.jnareb@gmail.com> <7vfydigg4w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 12:02:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbDg9-0005YB-RL
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 12:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992910AbWJUKCF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 06:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWJUKCF
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 06:02:05 -0400
Received: from hu-out-0506.google.com ([72.14.214.224]:15525 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030387AbWJUKCD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 06:02:03 -0400
Received: by hu-out-0506.google.com with SMTP id 28so519053hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 03:02:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Z6hxigPZpxUUrgPSy3WYDWptyyoH8hdwBhQddr79hrKZjFg/pPZHv2j++IXfrlVchE0e81IfN0Wg946DQLogQz6ZFLONs6baZ9vkuTh6uJLQzAH6EzXON7fkuGCH/8JiHws8OMbWMcEkQSz9RVSL8yC5TUA6ag6F4V/yP+MpZ8M=
Received: by 10.67.91.6 with SMTP id t6mr3592452ugl;
        Sat, 21 Oct 2006 03:02:01 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 32sm2536092ugf.2006.10.21.03.02.00;
        Sat, 21 Oct 2006 03:02:01 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vfydigg4w.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29599>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Do I understand code correctly, and the last '+' or '-'
> > in the parents column means?
> >
> >         for (i = 0; i < ecbdata->nparents && len; i++) {
> >                 if (line[i] == '-')
> >                         color = DIFF_FILE_OLD;
> >                 else if (line[i] == '+')
> >                         color = DIFF_FILE_NEW;
> >         }
> >
> > Anyone who wrote this code, could you answer me, please?
> 
> The "up to ecbdata->nparents" is Johannes in cd112ce.  But you
> are looking at a wrong code, I am afraid, if your original
> question was about the combined format (there is a comment about
> the codepath dealing only with two-way diffs by Johannes, above
> the part you quoted).  The output for combined diff is coming
> from combine-diff.c:dump_sline().

I was asking both about combined diff format, and how it is colored
by git-diff --color, to add colored combined diff output to gitweb.

> Combined diff output logic pretty much guarantees that you never
> will see plus and minus on the same line.

That's enough for me.

Any other ideas how combined commitdiff should look like in gitweb?
-- 
Jakub Narebski
Poland
