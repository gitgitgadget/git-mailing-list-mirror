From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: migrating to git: keep subversion revision numbers (as tags?)
Date: Sun, 31 Jan 2010 10:35:22 +1100
Message-ID: <2cfc40321001301535s2f886629m8c05cbaefeb81372@mail.gmail.com>
References: <20100130230829.GA3544@comppasch2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "fkater@googlemail.com" <fkater@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 00:35:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbMqg-0000ff-Q6
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 00:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab0A3XfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 18:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752370Ab0A3XfX
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 18:35:23 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:55438 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab0A3XfW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 18:35:22 -0500
Received: by pzk2 with SMTP id 2so2883903pzk.21
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 15:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=X3LzHjoSnGe0NJHZhwz8B16nyAU6y2xAJo08/odPM9Y=;
        b=m+1vJbqxPZN0YRRhIoQSV6xK1idIen767iYywtQFjjhp3Ya1vgQTptzLBlCGvqTnWd
         +PaD2yrCVCWXOJEmco+lBEah2wl4yX3NU4iWlpEcl7BIqPP3ZWavs+Egkl0RrA+XpxE9
         g1bTZAgsHMz36paKDmQTXoSJRhZBnduF66n4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Ly8nha+nh4B2r9uvHdcJsLq4HFioWKZxezj4aT0Hm/UkhlfNttrTTATMr3YgnwEYLV
         zP/W/IemBt2lFsDDUyohIgtF4+hUMbV2+r6oXbvuuFR5ZpMdeRlXEtm6AvSprOSLBcPv
         UW3cWW9xPlm++mrjFJvNXx1qve7wRkltW0O4w=
Received: by 10.114.51.4 with SMTP id y4mr1770097way.166.1264894522088; Sat, 
	30 Jan 2010 15:35:22 -0800 (PST)
In-Reply-To: <20100130230829.GA3544@comppasch2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138519>

On Sun, Jan 31, 2010 at 10:08 AM, fkater@googlemail.com
<fkater@googlemail.com> wrote:
> Hi,
>
> I would like to completely migrate from subversion to git
> (and NOT have subversion enabled anymore). However, I need
> to be able to lookup the old subversion revision numbers
> later from the git repository. The default seems to be
> though, that they are replaced by git sha-1 keys.
>
> It would be completely o.k. here to use git tags for all
> those subversion revision numbers (if possible), so, to
> create a tag for each subversion revision. However, I have
> neither seen any option in git nor found a script which does
> that upon cloning (converting) a subversion repo into a git
> repo.
>
> Is there a way to do so?
>

As I understand it, git-svn stores the SVN revision number in the git
commit message and git-svn log allows queries based on the SVN
revision number. I think you will find having one tag for each SVN
revision number is an abuse of the git tag facility - it makes it much
harder to use for its intended function in git.

jon.
