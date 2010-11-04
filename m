From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 4 Nov 2010 13:10:20 -0500
Message-ID: <20101104181020.GB16431@burratino>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org>
 <20101104112530.5c0e444a@chalon.bertin.fr>
 <4CD2E7B4.3000908@nextest.com>
 <vpq62wddmc0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raible <raible@nextest.com>, Yann Dirson <dirson@bertin.fr>,
	kevin@sb.org, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Nov 04 19:10:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE4Gy-0005QP-EC
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 19:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156Ab0KDSKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 14:10:49 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64055 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab0KDSKr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 14:10:47 -0400
Received: by wwb39 with SMTP id 39so404283wwb.1
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7FczTBCPQqkwGAMJKdurcIS7VNY7gkmimBQh9zAr6bw=;
        b=ceFSXnwNRWVO0B91scx3PaWU+N/oUrFAecVs44e/YfIVRnQazD6kWB0ZRI/cmkmPNJ
         /sKLuFh9/apRMpsNWWrQj403m026Eo3G1GF+If88r1nD0/gCJ5QPUnC4DGEM3cbg0P7Z
         zOv71AYnSMD+DdL4eGewee41ZbEkwaDXg/0hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VdSWw8yjzLW6xIAtGmOck8Lyde3UMCgImYdM91x/jMx6iHDMkxnmSKjceRq5F2y9KJ
         nlMbywKYyp3BxrYIfuBEoM8csGk4tAKwYDQPWefGAk5SbvhXi7uWHNEvb/+askB5aU9w
         FiZJJlbCLt0ndh+USYVt2GSgBO6k7X1hlMKIo=
Received: by 10.227.127.132 with SMTP id g4mr1063704wbs.114.1288894246305;
        Thu, 04 Nov 2010 11:10:46 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id f14sm173964wbe.2.2010.11.04.11.10.42
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 11:10:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpq62wddmc0.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160742>

Matthieu Moy wrote:

> #  e <commit>, edit <commit> = use commit, but stop for amending
> #  e, edit = stop for amending

Before it said:

# Commands:
#  p, pick = use commit
#  r, reword = use commit, but edit the commit message
#  e, edit = use commit, but stop for amending
#  s, squash = use commit, but meld into previous commit
#  f, fixup = like "squash", but discard this commit's log message
#  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
#
# If you remove a line here THAT COMMIT WILL BE LOST.
# However, if you remove everything, the rebase will be aborted.

How about:

# Commands:
#  p, pick = use commit
#  r, reword = use commit, but edit the commit message
#  e, edit = use commit, but stop for amending
#  s, squash = use commit, but meld into previous commit
#  f, fixup = like "squash", but discard this commit's log message
#  x, exec = run command using shell, and stop if it fails
#
# The argument to edit is optional; if left out, it means to
# stop to examine or amend the previous commit.
#
# If you remove a line here, THAT COMMIT WILL BE LOST.
# However, if you remove everything, the rebase will be aborted.
# Use the noop command if you really want to remove all commits.

Ciao,
Jonathan
who is happy to help paint today
