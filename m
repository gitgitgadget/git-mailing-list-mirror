From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Any command to simplify 'git fetch origin && git reset --hard origin/master'?
Date: Sat, 19 Jan 2008 22:03:26 +0800
Message-ID: <46dff0320801190603w4f0b2595v495ed10f2a87b0cc@mail.gmail.com>
References: <46dff0320801182122t1581b366yad123407aaad6326@mail.gmail.com>
	 <alpine.LSU.1.00.0801191114310.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 19 15:03:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGEIf-0001jY-2L
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 15:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbYASOD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 09:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbYASOD3
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 09:03:29 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:64140 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbYASOD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 09:03:28 -0500
Received: by py-out-1112.google.com with SMTP id u52so1989016pyb.10
        for <git@vger.kernel.org>; Sat, 19 Jan 2008 06:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Xlt3SxZDF73iiXAcxk1+IO718aDoQZNbf9HJLzgmWXE=;
        b=NwKvTgG0aGO9bB3y8Di0e1l07rn0HTJPVu+lHIbfmKxoM07k971EpRdMQoaTB/nc/ICDj3oRdLgDOrHZRZbxnWcy6/l1b8zkDfFJIgRvrulyaIYCW8opfqDk/0AdqxuEm4p6SQh2AMiNgSN6/S+qdKK0PJa8Rlq8u9RBAJpftLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HNdukg4uEhFp6azKP2BZazRYRc1A7hbmnwPP+eMsvCeW36WIw5oeWhPArE1dsxcPAb38P+N2HQlvnao73p8ZOLacKeP5VW2sHhmxQDZKi8CVW5JxeXY0tUTNiDQUoqnIUz6eocAcVIoUJ6+NQkVsH+btuYndMpr+3gOYV1Jy1eQ=
Received: by 10.35.75.15 with SMTP id c15mr5208325pyl.37.1200751406249;
        Sat, 19 Jan 2008 06:03:26 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 19 Jan 2008 06:03:26 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0801191114310.5731@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71106>

On Jan 19, 2008 7:15 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 19 Jan 2008, Ping Yin wrote:
>
> > I often encounter the case that the origin reposotory is rebased and i
> > make sure i want to use the origin head as my master
> > Now I have to do
> > $ git fetch origin && git reset --hard origin/master
>
> Just make an alias if you're too lazy to type.
>
> Personally, I do not see much sense in it, and it is too dangerous to
> bless it with an option to fetch or pull.
>
Can any alias do this? Since a parameter 'origin' or something should
be passed in.
Of course i can write a very simple wrapper. I just try to figure out
the better way.
> Ciao,
> Dscho
>
>



-- 
Ping Yin
