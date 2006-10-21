From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Syntax highlighting for combined diff
Date: Sat, 21 Oct 2006 10:49:56 +0200
Message-ID: <200610211049.56477.jnareb@gmail.com>
References: <ehbq0k$24l$1@sea.gmane.org> <7vslhigld7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 10:50:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbCYF-0004QI-6B
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 10:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992863AbWJUItu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 04:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992867AbWJUItu
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 04:49:50 -0400
Received: from qb-out-0506.google.com ([72.14.204.227]:12315 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2992863AbWJUItt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 04:49:49 -0400
Received: by qb-out-0506.google.com with SMTP id p36so254310qba
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 01:49:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Qnl/7Rexvy89KTPpkPpDTmQySh4bCWKbFr16cTJm45fBXvmv78bzby/P8YTVYaMR6rLwUmVAnKohfKpMuKxH/pFJgRV2AbOEWMVofVVdDWU4UqABMazmt4ifRPBqU3cj2wKvpURS5OBPpvNGDvGIRJgZEsQxig3C+InpYY5j+Io=
Received: by 10.67.117.18 with SMTP id u18mr3459448ugm;
        Sat, 21 Oct 2006 01:49:48 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 34sm2337374uga.2006.10.21.01.49.47;
        Sat, 21 Oct 2006 01:49:48 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vslhigld7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29594>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> So the question is how to color combined diff format (what should be syntax
>> highlighting for combined diff format). If branches columns have only
>> pluses we use the same color as for adding line in ordinary diff; if
>> branches column consist only of minuses we use the same color as for
>> removing line in ordinary diff. Can there be mixture of plusses and
>> minuses? How git-diff --color solves this?
> 
> UTSL ;-).
> 
> Otherwise (iow, if you refuse to use the source), you could
> cheat and let "git diff" do the coloring for you, and then
> regexp replace the output.  You could even use the same coloring
> logic for normal diff if you did so.

Do I understand code correctly, and the last '+' or '-'
in the parents column means?

        for (i = 0; i < ecbdata->nparents && len; i++) {
                if (line[i] == '-')
                        color = DIFF_FILE_OLD;
                else if (line[i] == '+')
                        color = DIFF_FILE_NEW;
        }

Anyone who wrote this code, could you answer me, please?
-- 
Jakub Narebski
Poland
