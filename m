From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT RFC] JGit mavenization done right
Date: Mon, 18 Aug 2008 12:33:29 +0600
Message-ID: <7bfdc29a0808172333g1cbe2102n6e76ae98a1943411@mail.gmail.com>
References: <7bfdc29a0808162152y4329303dte8f82bfea646180d@mail.gmail.com>
	 <20080818055502.GE7376@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 18 08:34:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUyK3-0006v3-LE
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 08:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbYHRGdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 02:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbYHRGdb
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 02:33:31 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:60431 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbYHRGda (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 02:33:30 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1220532yxm.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 23:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QrXE+dVK7+VmfDOn0KAmugQ5C4Uoy9/sfPEXdEfdBa4=;
        b=xgOKvrbN+iIhDMB2Gg3l64ME/n78n2U/Tcp/KWbm8BJ3bFNfLCcnfsby2kLfA17rYl
         FZs1QaJOdzAG6mIpZBfsotKtyjX0ufbyYlf87dR8YsMrPz/5pPu0cATSaecgJAbayd7q
         35bACZXmyIACY5oGDNZf4DNzty4618qQkFqJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gxO/6CyZuo0r6Wg+ONnfaXmBQO0p6CA1T48fTXr8DCnKSVE4dEmFrZcc1w/te3kWpl
         ab20L4JSgk/31N5zdaUkfW/3JhwoHb9zlqWn2QPaDJWVQlIUUvBhyZoCpwHrdM8KJtkh
         g5hW5ub02JBKBWMUxzulY0Mrx0oZOMFFbW634=
Received: by 10.150.197.8 with SMTP id u8mr9080348ybf.237.1219041209415;
        Sun, 17 Aug 2008 23:33:29 -0700 (PDT)
Received: by 10.150.225.1 with HTTP; Sun, 17 Aug 2008 23:33:29 -0700 (PDT)
In-Reply-To: <20080818055502.GE7376@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92687>

On Mon, Aug 18, 2008 at 11:55 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Imran M Yousuf <imyousuf@gmail.com> wrote:
>> I would like to request you all to test out JGit from
>> http://repo.or.cz/w/egit/imyousuf.git. Please checkout the branch
>> 'unified_tst_rsrc' and try to build it with both maven and Eclipse
>> (i.e. as was built earlier) and please be kind enough to inform me if
>> the build fails. Please feel free to suggest any improvements you have
>> in mind.
>
> Thanks, I'll take a look at it tomorrow or the day after.

Thanks, it would nice to know whether it works in the original build
process or not :).

>
> I am looking forward to making JGit more available to the Java
> community, so support under Maven is welcome, even if Maven isn't
> the project's (current) primary build tool.

Once this is out of the way I will add configuration to make the
source code and other project related information to be allowed to be
published online from maven POM file using the 'site' plugin.

Additionally I also want to add configuration to build a distribution
for JGit PGM project.

>
> --
> Shawn.

Best regards,

-- 
Imran M Yousuf
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
