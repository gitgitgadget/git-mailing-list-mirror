From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch submodules
 too
Date: Wed, 13 Oct 2010 18:01:04 -0700
Message-ID: <4CB65650.6080204@gmail.com>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de> <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org> <4CB0BFDB.7010503@web.de> <4CB5C6D8.1070108@xiplink.com> <4CB6093F.3040800@web.de> <1691DBFD-6075-479E-8847-EB4595BB9E10@sb.org> <4CB61137.6030502@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 14 03:00:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6CBg-0003XD-SH
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 03:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657Ab0JNBAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 21:00:40 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49569 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab0JNBAj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 21:00:39 -0400
Received: by pvc7 with SMTP id 7so476209pvc.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 18:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ceQ28EDD6r95gsgbl23zxVEaBryu9lomAtAqgjm/xqo=;
        b=r35xPWPnZ95c6tFsvpZuIWHFvPd/ML0q7gEdI8a2c6u1+wltaAm6r7ZnRFld2V5u3K
         qAvOSuoE540kRGvn6KdYS2liFJmKvcIUJas3ILWV1QxRLiTSjHX47MZkzFXgDi2zGTT4
         d7+dVswQqF1dfC7kAnxH8beQqDzY6kO0GOD0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=af82/CnJ1rUQGPWD57o23+SvxzVG5YuQfEcUmS0TgsG4C2YykBO16w8lDqQbZ3Kxo1
         OhNlN7KR/Qn4CqZf4s3BD4lcgMhTDtV4oa/Z9OZQwaWj+waZQ4vF+V+QiXdMwUMxIi3n
         GVsR7UlOSGddwZrFrxINrV0MB6k17DI8coxh8=
Received: by 10.142.216.6 with SMTP id o6mr8207526wfg.236.1287018038691;
        Wed, 13 Oct 2010 18:00:38 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id y42sm6324869wfd.10.2010.10.13.18.00.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 18:00:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.12) Gecko/20100914 SUSE/3.0.8 Thunderbird/3.0.8
In-Reply-To: <4CB61137.6030502@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159011>

On 13/10/10 13:06, Jens Lehmann wrote:
> 
> For *your* use case it might not be correct, but for others it may very
> well be.
> 
> We need to get more user stories like that to get an overview about what
> config options are useful and what might be reasonable defaults for them.
> And then we can decide what set of options and defaults to choose.

We'll if you want it here's an example of how we use submodules at $dayjob.

Most developers initially clone the project repo and run git submodule
update --init (or git submodule init && git submodule update if their
git version is too old).  This could be replaced by git clone
--recursive, or just git clone if we there was a config for enabling
recursive cloning by default.

A few newbies have been confused by the fact that they run git clone but
don't actually end up with any code (in our case the superprojects are
just containers with no actual code themselves).

We have a continuous integration machine that does a git pull on all
submodules, a few automated tests and updates the superproject if the
tests pass. This would make use of git fetch/pull --recursive to grab
all the latest changes.

After the initial clone developers run git pull on the project. for
modules they aren't working on they run git submodule update <module>.
For modules they are working on they to rebase their working branch to
the SHA1 recorded in the superproject. I think this kind of thing has
already been discussed on the list, not sure that I've seen a solution
that would work for us. For now all of this is is wrapped in a script
for the developers.

Developers would probably want the fetch-if-super-gitlink-has-changed
behaviour. We also need to handle rebasing a submodule's checkedout
branch (if present) against the recorded submodule SHA1. This could
remain "our problem" as long as the worktree of these branches does not
get updated we can simply use the existing rebase logic we have today.

Hope that is a useful use-case.
--
- Chris
