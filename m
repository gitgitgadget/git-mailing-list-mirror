From: Leo Razoumov <slonik.az@gmail.com>
Subject: Re: Deciding between Git/Mercurial
Date: Tue, 29 Sep 2009 20:49:52 -0400
Message-ID: <ee2a733e0909291749s71801b29ufa827cab715d0abb@mail.gmail.com>
References: <h9nlhj$heq$1@ger.gmane.org> <m33a66br69.fsf@localhost.localdomain>
	 <ee2a733e0909291144g4b99ab7ay9e63bfac935013aa@mail.gmail.com>
	 <200909292058.53045.jnareb@gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Anteru <newsgroups@catchall.shelter13.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 02:50:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsnOw-0005E1-4i
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 02:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbZI3Atu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 20:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753632AbZI3Atu
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 20:49:50 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:41918 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbZI3Att (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 20:49:49 -0400
Received: by ewy7 with SMTP id 7so5984642ewy.17
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 17:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+9fJzXxm5D/5p5BVZieohHyvzsKQd56Q0DN4jwpvPY0=;
        b=EeR9Ho/BLFcZj09bZuia1lv+8pILtD+6zD1CnJniIAsP047kuYlOJGRgX5JBEBOk7E
         dEP93hmL5R/+IgyHsvQ7GAy+4c6KT+QFXPlnQzBeWw7LsM3d1C66B7mW9/mJ3MNjx85N
         eM27NM4g6MO5ix7rGkeJxibxENhPWi09o6FDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=gBAGG0r8iKtESeRHEHaOu8dU4Cj3Mg51+jAz7FqMxooDgFzvNsUKsGsH44hGKf/yPR
         oykDDy4+Wb4XSMcrQ2ultHMnymDPUT73QVdzWlwakqpVDi2cGOmtcJdBLH47wF7bglb1
         1zeOjUeBFhhwVlIdqWt8vI+ho6TD8dntvyYkg=
Received: by 10.216.17.136 with SMTP id j8mr1206417wej.226.1254271792590; Tue, 
	29 Sep 2009 17:49:52 -0700 (PDT)
In-Reply-To: <200909292058.53045.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129330>

On 2009-09-29, Jakub Narebski <jnareb@gmail.com> wrote:
> On Tue, 29 Sep 2009, Leo Razoumov wrote:
>  > On 2009-09-28, Jakub Narebski <jnareb@gmail.com> wrote:
>  > > [..snip..]
>  > >  Besides with nonlinear history with
>  > >  revision numbers such as 12678 and 12687 you know that 12678 is older
>  > >  than 12687 if and only if 12678 and 12687 are on the same line of
>  > >  development.
>  >
>  > The statement above is incorrect!! In a Mercurial repo local revision
>  > numbers are strictly ordered in commit time. 12678 < 12687 means that
>  > 12678 was committed prior to 12687. But these two commits could belong
>  > to two completely unrelated lines of development.
>
>
> This is impossible with distributed development.  If the second branch
>  comes from other repository, with commits _created_ (in that repository)
>  earlier than commits in current repository, but commits in first
>  branch (from current repository) were created earlier than _fetching_
>  those commits in second branch:
>
>   .---.---.---.---x---1---2---3---M---.
>                    \             /
>                     \-A---B---C-/             <-- from repository B
>
>
>  Either you would have to change commits numbers, and therefore they would
>  be not stable, or you would have to change commit time to mean 'time this
>  commit got into current repository', which would kill performance for sure.
>

Jakub,
in Mercurial sequential commit numbers are local to a repo and are not
unique between the clones. Unique ID is SHA1 as in git. So mercurial
commit 127:aaf123453dfgdfgddd...
means commit number 127 in this repo with SHA1 "aaf123453dfgdfgddd..."
In another clone commit 127 might mean completely different thing.
Sequential commit numbers are strictly for "local convenience".

--Leo--
