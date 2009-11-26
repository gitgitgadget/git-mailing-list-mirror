From: Douglas Campos <douglas@theros.info>
Subject: Re: [egit] Git repository with multiple eclipse projects ?
Date: Wed, 25 Nov 2009 23:12:20 -0200
Message-ID: <ed88cb980911251712o499ad3bexccca6be071801776@mail.gmail.com>
References: <20091125164734.GF21347@linagora.com> <20091126004817.GL11919@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@linagora.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 02:12:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSuk-0001bd-CI
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 02:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758878AbZKZBMf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 20:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758856AbZKZBMe
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 20:12:34 -0500
Received: from mail-px0-f180.google.com ([209.85.216.180]:59075 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758853AbZKZBMe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 20:12:34 -0500
Received: by pxi10 with SMTP id 10so186358pxi.33
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 17:12:40 -0800 (PST)
Received: by 10.114.2.29 with SMTP id 29mr1628689wab.48.1259197960386; Wed, 25 
	Nov 2009 17:12:40 -0800 (PST)
In-Reply-To: <20091126004817.GL11919@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133749>

(worksforme) egit 0.5.x

On Wed, Nov 25, 2009 at 10:48 PM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
> Yann Dirson <ydirson@linagora.com> wrote:
>> I am investigating whether it is possible at all to have several
>> eclipse projects in a single git repo, and have those projects
>> correctly seen as managed by git.
>
> As Robin said, it should work. =C2=A0EGit and JGit both use this layo=
ut.
>
>> When importing a git repo into eclipse, we get a list of projects to
>> import, but that list is empty. =C2=A0What is expected by egit to ge=
t this
>> list filled ?
>
> There should be .project files in the repository. =C2=A0I think we sc=
an
> the entire checkout tree for .project files, but maybe we are doing
> something stupid and only looking at the top level directory of
> the checkout.
>
>> It also does not look like it would be possible to use the "share"
>> functionnality to setup such a repository from multiple projects (or
>> from a project set), right ?
>
> Nope, I don't think this is supported right now. =C2=A0You need to
> initialize the git repository by hand in the higher level directory
> that holds the projects.
>
> --
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Douglas Campos (qmx)
+55 11 7626 5959
+55 11 6762 5959
