From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: How to push properly a la subversion
Date: Wed, 29 Jul 2009 19:12:32 +0000
Message-ID: <32541b130907291212p2c079cn2d7a8b17693577b4@mail.gmail.com>
References: <4A7095CE.8030307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Stigler <matthieu.stigler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 21:13:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWEaD-0003ns-Qu
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 21:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbZG2TMx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 15:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754022AbZG2TMx
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 15:12:53 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:56424 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713AbZG2TMw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 15:12:52 -0400
Received: by gxk9 with SMTP id 9so1799895gxk.13
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5WQkz4UgTAMc61RTfZsV7QwmBBYbnKUOR8lPqFx9Rts=;
        b=nQ7YQH0I67zKhw6dijnd40GZyPN9L7/twds6iWDCFUWb6kIts3/Jtxsj2zOOJthktm
         a7bAt8/QB1pn39CKMqPp26kaF3Yrt293MhSajIkcqZt2q2j6DeMDd3yGfz75BrPeD2N8
         FuqCWbzNP8xYBoqdqLkCRGQ0FLj58zKXGXxww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BLrBXfZISzfhZ2HBMJtdl1Wiq4h9ccyPShKWVsUYSmtA6JjkkDMTi1epk+oAYhtdIi
         D2JgjSRl09P4Pg9Q7EYw0/g6SZcoMoZ44cnEc2Rkg0cZ4PyaJT1zcI2CFp6egbyPDUCJ
         9A0ENtbdllsZrnj29k+mJei41RJxXORurANDg=
Received: by 10.150.53.9 with SMTP id b9mr422436yba.57.1248894772113; Wed, 29 
	Jul 2009 12:12:52 -0700 (PDT)
In-Reply-To: <4A7095CE.8030307@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124382>

On Wed, Jul 29, 2009 at 6:32 PM, Matthieu
Stigler<matthieu.stigler@gmail.com> wrote:
> I'm discovering git switchig from svn, so I'm still confused... I wan=
t
> actually to use git but keeping this idea of one common/public repo t=
hat
> different users push/pull from.
>
> I tried just by cloning A to B, changing/commiting B and the pushing =
to A
> but: then on A the last log is integrated but I have this message wit=
h gitk
> "local changes checked in to index but not commited", and those local
> =A0changes are actually the version of A before the commit from B :-(=
 What I
> expected with svn mentality is that A is changed and updated...

You need to configure A as a "bare" repository.  For example:
http://toolmantim.com/articles/setting_up_a_new_remote_git_repository

=46uture versions of git will prevent you from accidentally getting A
into the inconsistent state that you've managed to produce.

Avery
