From: Meinrad Recheis <meinrad.recheis@gmail.com>
Subject: Fwd: [ANN] gitsharp 0.2 released
Date: Wed, 28 Oct 2009 22:33:10 +0100
Message-ID: <43d756720910281433n15eac4a3t530be37b479d1f67@mail.gmail.com>
References: <658c7e11-85ad-4ae6-a2a3-dec5aff121d1@b2g2000yqi.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 22:33:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3G8v-00014e-1a
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 22:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881AbZJ1VdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 17:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755830AbZJ1VdI
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 17:33:08 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:38248 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbZJ1VdH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 17:33:07 -0400
Received: by bwz27 with SMTP id 27so1534836bwz.21
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 14:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=BaascSw+nVQDCNoepVR9+2Mjg28v/VUAKlOjOIN8qaI=;
        b=AlXe0BC4hSdEORUMVFq9dQfmllkI8RSjI82ZdakevsWNDEfXS9qXq4UEvWSMmgOIyD
         XV2Hb39vAW4uQp5CY7sVPZiudxbc443OlKG0BWYeGVDb+Wv7Uz0ULheObYAXv/kmsnb7
         xzLsoxE2fsWzTUC4mio3GSzP+yhcQOq8QGUHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=R9ftwHCenSnNw34am5xe6PBQhIS+6wSvMvAPmFkKkMFtQ7DcUcRLjRIWnvwtaWbvK0
         vrbwz3ZZHtaseht70gvC2cnMDSpVIOTH8Uie0H7KPWXvV1toRcPhL0EO4+MjI0Q95KxL
         k+2F37I3DHslOzrgZtoI52YdXzo1MQwluXrdU=
Received: by 10.223.14.22 with SMTP id e22mr232540faa.42.1256765590604; Wed, 
	28 Oct 2009 14:33:10 -0700 (PDT)
In-Reply-To: <658c7e11-85ad-4ae6-a2a3-dec5aff121d1@b2g2000yqi.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131498>

Dear fellow git enthusiasts,

We are proud to announce version 0.2 which marks significant
improvements in the new Git api we are building around GitSharp.Core.
The core is a line-by-line port of jgit. We found it quite hard to use
without good knowledge of git's internals and technical concepts.
The api which is documented by examples at
http://www.eqqon.com/index.php/GitSharp/Examples
encapsulates and abstracts this knowledge so that everyone with a
little git experience can easily make use of the library.

The improvements mentioned above allow to add files to the index and
commit them. It is as easy as this:

=A0 =A0var repo =3D Repository.Init("path/to/new/repo");

Now suppose you have created some files in the new repository and want
to stage them for committing:

=A0 =A0repo.Index.Add("README", "License.txt");
=A0 =A0var commit=3Drepo.Commit("My first commit with gitsharp", new Au=
thor
("henon", "meinrad.recheis@gmail.com"));

Easy, isn't it? Now let's have a look at the changes of this commit:

=A0 =A0foreach(var change in commit.Changes) Console.WriteLine
(change.Name + " " + change.ChangeType);

Of course there is still much work to do until this new API will
completely reflect the full range of git interactions a standard
application is probably going to need. We hope to quickly build up the
most important parts until the end of the year. If you check it out,
please give us feedback which will be greatly appreciated.

Download Gitsharp 0.2 binaries from
http://www.eqqon.com/index.php?title=3DGitSharp/v0.2.0

Have a nice day,
--Henon 21:22, 28 October 2009 (CET)
