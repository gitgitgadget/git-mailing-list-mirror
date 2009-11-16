From: James Pickens <jepicken@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2009, #03; Sun, 15)
Date: Sun, 15 Nov 2009 17:13:14 -0700
Message-ID: <885649360911151613m7752ad09v3c0f48c44d569dfb@mail.gmail.com>
References: <7vtywwm6i4.fsf@alter.siamese.dyndns.org>
	 <loom.20091116T003914-635@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Peter Weseloh <Peter.Weseloh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 01:13:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9pDk-00038b-Kx
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 01:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbZKPANK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 19:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbZKPANK
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 19:13:10 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:53249 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbZKPANJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 19:13:09 -0500
Received: by iwn8 with SMTP id 8so3854837iwn.33
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 16:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=gBltDeDs/N7YnjmFUOl4OXpJe0QNHTtcezLLzl3p94k=;
        b=sMjvpjtnlrzGt4It2oQ8/jNcfq1JttwmLmue7JacdLP5VfHBcD78I3NBTVDPRg5Zfz
         NJzz+GXiURrEtcmQN745atSKEVeciEBrT9mr38PwwIoBe6HmEsCUc7B2G7w5QV3VJkOJ
         5IotoEyYWk9Ekm2cI5jOSFmDAcKA5oYtViH5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Q+FD3bCuCHxuPuhSZug9GvDhCcztH8XSDorbkaoGy6D7Cls4qqZo4lchtRMgknEGLN
         /DThO0Wmq5I/IZqpzW8BjOdkY0zG0vr9nUYhewwv5hcVaMaLR9k/nQzPhduBKvKvqAuS
         7xiP6zN9gvtMF69lwSu24BvcXezFTrS4JYO/U=
Received: by 10.231.122.139 with SMTP id l11mr4718605ibr.53.1258330394756; 
	Sun, 15 Nov 2009 16:13:14 -0800 (PST)
In-Reply-To: <loom.20091116T003914-635@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132973>

On Sun, Nov 15, 2009 at 4:40 PM, Peter Weseloh <Peter.Weseloh@gmail.com> wrote:
> I'm currently trying to convince my managment to switch from CVS to git.
> What causes some trouble is that we have quite some files (> 40k) in various
> (>300) CVS modules and splitting them into sub-repos seams somewhat difficult.
> git has no problem even with that many files but commands that stat the
> working copy (e.g. 'git status') take quite long on our filers
> (it's either a problem with the filers or with nfs or both, I don't know yet).
> Having the ability to do sparse checkouts only of the repo sounds like a
> way out.

Make sure you have set core.preloadindex to true.  It makes life on NFS much
more tolerable.

James
