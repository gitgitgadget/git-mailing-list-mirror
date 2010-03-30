From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: the careless committer and fear of commitment (rebase -i vs add 
	-p)
Date: Tue, 30 Mar 2010 11:44:01 +0530
Message-ID: <f3271551003292314v23058945vb432cc4c8a601aca@mail.gmail.com>
References: <alpine.DEB.1.00.1003281834520.13534@pip.srcf.ucam.org> 
	<32541b131003291331y3ae5ca23la33466d588c1b9e1@mail.gmail.com> 
	<20100330030508.GA2887@progeny.tock> <32541b131003292132q10db3c5eh1bb6443d625fcb82@mail.gmail.com> 
	<20100330045704.GA9004@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Daniel Thomas <drt24@srcf.ucam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 08:14:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwUia-00037y-Dy
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 08:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542Ab0C3GOX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 02:14:23 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42644 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481Ab0C3GOW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 02:14:22 -0400
Received: by gyg13 with SMTP id 13so1977331gyg.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 23:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=e1gyW8hjH1qZvws7vEtZIIg6zywjTLrOj5Gz+FQZHZo=;
        b=F5nIByQd9vpeZU4a/CR/AYauvCo4Y10Z9VnCnK5LpXrp+9oh86/7borH3M+WU9zxB1
         i4QN2a5TPWqNOYLODP2HV2b5+BvJWbDK9Ef0Q8hGCSt+pBv94biCrYZ67KBsUsJk4mMz
         fsRPZAnQOzCrZIRrSonTA8QSaa27sao9wM+GI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jxNzYxmyNi7JCYU6HpzFpBxYBkYRmw2jMrkdvBJZmq3iu00npwbnOPSfx1s4A7gStt
         4cGGw15N25KpGxUFOfe+qCBjk4KBUO/PDg0XnfGRwyMcMsrcy9a6bDm2lDSBcprMrYBs
         emZmYpvxRVqSoAy7QX9If11/WfhR8J02M7Ghk=
Received: by 10.90.69.14 with HTTP; Mon, 29 Mar 2010 23:14:01 -0700 (PDT)
In-Reply-To: <20100330045704.GA9004@progeny.tock>
Received: by 10.91.11.5 with SMTP id o5mr2128784agi.46.1269929661227; Mon, 29 
	Mar 2010 23:14:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143548>

Hi,

On Tue, Mar 30, 2010 at 10:32 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> I like =91git diff --cached=92 and =91git diff=92 to show the entire =
list
> of staged and unstaged changes. =A0I don=92t consider this =93wrong=94=
 at all.

On a related note, my workflow is somewhat similar: I just use Magit
within Emacs, which essentially does the same thing. The staging area
in Git really helps me organize my work, and I wouldn't mind attaching
a small note to it that I can refer to while writing my commit message
(much like Jonathan's idea). However, I don't think this task is large
enough for an entire GSoC.

Also, I'm positively opposed to the idea of a complex interactive
command-line interface. If someone *did* want that kind of complexity/
interactivity, they ought to use something like Magit: a cli can't
even come close.

-- Ram
