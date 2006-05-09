From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: Unresolved issues #2
Date: Tue, 9 May 2006 13:53:48 +0200
Message-ID: <4fb292fa0605090453s390b58f3oc6c7607ea9f2f728@mail.gmail.com>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	 <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	 <1147174809.2794.12.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 13:54:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdQmr-0007zV-KU
	for gcvg-git@gmane.org; Tue, 09 May 2006 13:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWEILxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 07:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWEILxu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 07:53:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:15805 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932396AbWEILxt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 07:53:49 -0400
Received: by nf-out-0910.google.com with SMTP id b2so1170358nfe
        for <git@vger.kernel.org>; Tue, 09 May 2006 04:53:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BaXYsFh4QY8lsjWyQIHvN5AHRcEqQcfXHdYAl/+o1NtBoN7hTdSq1XS3NorIvlG4991O81fsOtRQRyQPXZNfe+LpnGnAmJXqL/SjzSxtpMtp+1yUxFjb+OgydH/yLkkx2ttJLudBsvEhzdAjflc/WXDvvvFFlwlYdzb8mUeM1LY=
Received: by 10.48.162.20 with SMTP id k20mr2043880nfe;
        Tue, 09 May 2006 04:53:48 -0700 (PDT)
Received: by 10.49.2.19 with HTTP; Tue, 9 May 2006 04:53:48 -0700 (PDT)
To: "David Woodhouse" <dwmw2@infradead.org>
In-Reply-To: <1147174809.2794.12.camel@pmac.infradead.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19835>

On 5/9/06, David Woodhouse <dwmw2@infradead.org> wrote:
> On Thu, 2006-05-04 at 01:15 -0700, Junio C Hamano wrote:
> >
> > * Message-ID:
> > <4fb292fa0604290630r19edd7ejf88642e33b350d1d@mail.gmail.com>
>
> >   David Woodhouse did a patch to allow specifying charset on the
> >   command line (and default to UTF-8) which is a move in the
> >   right direction, but Bertrand's system seems to have trouble
> >   with it.
>
> I thought Bertrand then confirmed that he was having trouble _before_
> applying my patch, too? His response when I asked it it appears without
> my patch was "[it] appear without in 1.3.1 and I can't seed mail with
> too. Also, 1.2.4 work fine here (without patch)."

Ok, to make short :
git-send-email 1.2.4 :
No EOF error on my smtp server.
git-send-email 1.3.1 :
EOF error on my smtp server.

I upgraded to 1.3.1 when I received patch from you, don't test 1.3.1
and then applied your patch, you test. And so test failed.

--
Beber
#e.fr@freenode
