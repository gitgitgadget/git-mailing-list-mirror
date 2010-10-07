From: fREW Schmidt <frioux@gmail.com>
Subject: Re: Git over SMBFS
Date: Thu, 7 Oct 2010 17:49:03 -0500
Message-ID: <AANLkTi=Va+rsiewbjHdRzMxKj96gFrvxT4=muMeP9=zq@mail.gmail.com>
References: <AANLkTik9U_jr6r6BuUcRrk8pjQTacKDY7YbqWnfrCLmD@mail.gmail.com> <20101007174006.GA31711@fearengine.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Casey Dahlin <cdahlin@redhat.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 00:49:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3zHH-0003xQ-Om
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 00:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180Ab0JGWt0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 18:49:26 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59621 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065Ab0JGWtZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 18:49:25 -0400
Received: by qyk29 with SMTP id 29so684693qyk.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5mh2Xb6CeDIGWpahPfcI3dXp8VPnxc4WhJt3I+PFsS8=;
        b=ZD3FWWGIZy3nKHEdobHAbsE/sR+vNeO7dzDtXC+sgs25Kajt9GdE/O4Top596Ipw6a
         MpM26fIKXBuTDiIBuTanKYE+nW+dakhEkoKaLvW7sxyCRBcSVAoH8bS0wDGAhwgJrkvq
         2kkpoqdgVcmA7kBFn/fGQUur6MckEfaxA1TSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=c51RHRNPPHDpQ7fWoiFa1CDr81CvFOKc6drSZ6qkBi/uha5U33rxMml2P56GcchH/v
         uy2D1VlGjeMISgotah/k9+MIOiaQ+dMFx9A72QlUPYXT2oof1upfbhKTUoXMCKOSZXYn
         2NGsWo7EZ6zOePRZkKqvaT3ka99xoKf+5E/CQ=
Received: by 10.224.187.134 with SMTP id cw6mr848726qab.247.1286491764974;
 Thu, 07 Oct 2010 15:49:24 -0700 (PDT)
Received: by 10.224.67.80 with HTTP; Thu, 7 Oct 2010 15:49:03 -0700 (PDT)
In-Reply-To: <20101007174006.GA31711@fearengine.rdu.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158461>

On Thu, Oct 7, 2010 at 12:40 PM, Casey Dahlin <cdahlin@redhat.com> wrot=
e:
>
> On Tue, Oct 05, 2010 at 09:26:15PM -0500, fREW Schmidt wrote:
> > A coworker of mine is working on a project that is running on a
> > windows server.=A0 The project is in git, but we are having a lot o=
f
> > trouble getting it to work at all.=A0 For example, if he merely doe=
s
> > (from his machine) "git checkout ." it seemingly times out after 68=
0
> > files being checked out.
> >
> > Are there any settings we might be able to tweak that might make gi=
t
> > more tolerable of the latency involved in a network based checkout?
> >
>
> Sounds to me like the best way would be to make a local copy with
>
> git clone /path/to/cifs/mounted/project
>
> And then do your work on the local hard disk. Later, you can git-push
> back in to the cifs folder.

That's actually what we've been doing.  I was just curious if there
were another way.


--
fREW Schmidt
http://blog.afoolishmanifesto.com
