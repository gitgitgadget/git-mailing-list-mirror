From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v2 01/11] gitweb: introduce remote_heads feature
Date: Fri, 14 Nov 2008 22:44:02 +0100
Message-ID: <cb7bb73a0811141344q4360351do346def5515ec157b@mail.gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811141915.17680.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 22:45:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L16Ti-0005YG-56
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 22:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbYKNVoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 16:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbYKNVoF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 16:44:05 -0500
Received: from qb-out-0506.google.com ([72.14.204.225]:10972 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbYKNVoE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 16:44:04 -0500
Received: by qb-out-0506.google.com with SMTP id f11so1601318qba.17
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 13:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GTyCvlc8CsaJ9qG92/gUzzrJ6iZRB1X9mvJJw1xrxvs=;
        b=B305RA0w7JOTm6PcnK6mJJL3vM8xd9i6Fcmijp44Q6I05iWu5ritmD6Gt0Q2dYXLUt
         sSyHA7fjoxcPRiQqRP5fqVAz64Yehf5mcPQJrohZ3CSSZ3VKwuql1RpBc7Tvmfd+aRTY
         VQ9GZuUTesN3I2dVZ0g9i2cwEDbhlC6Bih4zU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kyKQz7NK73N4Bg1iO+nMKuhT3ZsL10sj1MPbFmEoNDL5gR3FRDEzLHjV/sKYu3r+0k
         85+7tr5L4VbFSpCppW/eu2ugNxveZsNanK7WiSwVNC9yyhtzgXemUra5quSXY/G8iPUv
         hJP32RInra6aRwMF4TEHEAN3h+9P7pTeVjKc8=
Received: by 10.210.88.7 with SMTP id l7mr1564123ebb.67.1226699042130;
        Fri, 14 Nov 2008 13:44:02 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Fri, 14 Nov 2008 13:44:02 -0800 (PST)
In-Reply-To: <200811141915.17680.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101018>

On Fri, Nov 14, 2008 at 7:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 13 Nov 2008, Giuseppe Bilotta wrote:
>
>> With this feature enabled, remotes are retrieved (and displayed)
>> when getting (and displaying) the heads list.
>
> I think it would be good idea to add in commit message idea _why_
> such feature would be useful, for example
>
>  This is useful if you want to use git-instaweb to examine the state
>  of repository, influding remote-tracking branches, or a repository
>  is fork of other repository, and remote-tracking branches are used
>  to see what commits this fork has in addition to those from forked
>  (main) repository.
>
> Or something like that.

Ah yes, many commit messages in this patchset are way too terse. A
side effect of this being something like the first patchset I ever
prepared. I'll rework them to something more sensible.

> It would be also in my opinion a good idea to modify git-instaweb.sh
> (I guess better in separate commit) to make it make use of this new
> feature... unless it does it already, doesn't it?

It doesn't, but it's something I have considered. I'll work on it (on
a separate patch)


>> +     # Make gitweb show remotes too in the heads list
>
> I'm not native engish speaker, but shouldn't instead of "remotes too"
> be "also remotes" or "remotes also"?

No idea, I guess we'll wait for a native english speaker opinion 8-D

-- 
Giuseppe "Oblomov" Bilotta
