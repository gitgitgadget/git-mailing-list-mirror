From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] git-commit: no silent exit on duplicate Signed-off-by lines
Date: Sun, 13 Aug 2006 19:41:46 -0700 (PDT)
Message-ID: <20060814024146.85979.qmail@web31807.mail.mud.yahoo.com>
References: <7vejvlm4op.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 04:42:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCSOv-00070G-6K
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 04:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWHNCls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 22:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWHNCls
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 22:41:48 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:39085 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751799AbWHNClr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 22:41:47 -0400
Received: (qmail 85981 invoked by uid 60001); 14 Aug 2006 02:41:46 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=a0uGAKuqRT8mgyPulB/hrGa8iI3IPZuEjm57SgNfkwKa75xMjGoOt92rQmdYGju6ltTClqRTXP5P2FU+Cf6hll3kEgYQORhVcy+L6dMjS4K9nN2fdg2HKQ6RyGiLondj9cUKK1EWdyH4WhCuw6GrBSS08JcT/V/y+/DeWnEOO3Y=  ;
Received: from [71.80.231.253] by web31807.mail.mud.yahoo.com via HTTP; Sun, 13 Aug 2006 19:41:46 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejvlm4op.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25310>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > @@ -690,7 +690,7 @@ case "$verify" in
> >  t)
> >  	if test -x "$GIT_DIR"/hooks/commit-msg
> >  	then
> > -		"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG || exit
> > +		"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG || die "Duplicate Signed-off-by lines
> -- nothing commited"
> >  	fi
> >  esac
> 
> Please emit the complaint from the sample hook/commit-msg
> script, not from git-commit.

Ok, I will. (In which case the aforementioned patch can be dropped
in favor of the new one.)

    Luben
