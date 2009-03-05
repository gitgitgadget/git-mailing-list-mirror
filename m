From: John Tapsell <johnflux@gmail.com>
Subject: Re: More git bisect modes
Date: Thu, 5 Mar 2009 10:17:22 +0000
Message-ID: <43d8ce650903050217m2885692dkcef08ab2a5f60082@mail.gmail.com>
References: <43d8ce650903050149u4ca98444w28efceb9084efa68@mail.gmail.com>
	 <20090305190542.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 11:19:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfAfI-0001wZ-Oz
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 11:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbZCEKRZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 05:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbZCEKRZ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 05:17:25 -0500
Received: from wf-out-1314.google.com ([209.85.200.170]:28357 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbZCEKRY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 05:17:24 -0500
Received: by wf-out-1314.google.com with SMTP id 28so4464909wfa.4
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 02:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9NJx2ikONak2A0M3iO1sFu2sDP+AUWvTtMrQZe+5TGg=;
        b=Yj06UQEVw/XhMPnRdfv/IfIgMtHlT4JCVl4AYwWh0HfFWTpKQdEFtEOJK+gd5+4uQM
         wunM9+gCwy5PG9FaPFT3FjKgeXYevT+4LdxvrIbQ8XTSa++lFw99P2c38luG3vqpgyzl
         KanyIe7hj1YvX85vC3XjaeTmwVnZShEUyXIDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=s28mh6q9GaBUfbOSDIRy3BaZfFN7tLzEEwaHccO6y80z6FDkT/pThm4WAZbqLzD9T4
         Od0pdQ6CIgyS7n8viYlpud2WTmkmwRMqUE2MqXN/o+QRcw/Rci/fkwSt/tF+EZNkRhTv
         GJV38XmH/vBVClm02OuA0Ny8Iu8DRmZcFP+UE=
Received: by 10.142.141.21 with SMTP id o21mr464673wfd.33.1236248242925; Thu, 
	05 Mar 2009 02:17:22 -0800 (PST)
In-Reply-To: <20090305190542.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112286>

2009/3/5 Nanako Shiraishi <nanako3@lavabit.com>:
> Quoting John Tapsell <johnflux@gmail.com>:
>
>> * An exponential back-off. =C2=A0Typically I know that HEAD is broke=
n, and
>> I don't know when it used to work.
>
> I thought 'git bisect' already worked with only bad commit(s) without=
 any good commit for a long time?

I believe this makes it start from the very first commit.  This
probably much further back than most people would actually want to
start from.
(Also there seems to be a bug here, in that  'git bisect run' requires
you to have both a good and a bad commit.  Also the man page doesn't
document this)

John Tapsell
