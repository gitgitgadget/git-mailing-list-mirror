From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: QGIT questions/bugs
Date: Tue, 16 Jun 2009 16:08:29 +0200
Message-ID: <e5bfff550906160708x540f2b23ka1308de504233ee7@mail.gmail.com>
References: <81D77A49EF91FF4FB63E5EB32416330F7239A5@HKMGAXMB104A.zone1.scb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Cannizzo, Fabio" <Fabio.Cannizzo@sc.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 16:08:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGZL4-0002Sr-7Y
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 16:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbZFPOI3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2009 10:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbZFPOI2
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 10:08:28 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:39793 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbZFPOI2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2009 10:08:28 -0400
Received: by ewy6 with SMTP id 6so6041281ewy.37
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 07:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=84Cg1C5K36wlBXKVho2e3/0k1Wf+zR+B1Y44qR5ezqo=;
        b=J/IVvgh/eyHBuiLEtxKAB/gS8o5zK8kGBNh5b2KNK01U7K8vvxNcM0dZcKLxad4bIt
         d4CwKrJlc9MkaTapPqdX1irYsASrBkEKm5JLQqh+yOKE1PjA3QQT8k7xhibJod2rlNno
         kTkewvme0y03yTj8A0joo7n1YhDq6JkLiM2Vc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZvPKBNBlBjwpU1Oz5ddlamGiHYjzRWoK33yGFs+KFQhQUPOmPCL+0f27yU+13MhdFw
         JJtoYojlBdv/kUXn8Aj19mXhzros0C5eTx8eq65/6PPW2UxvBwlYgsDFlBbMcVHem4Zb
         e1YucefCoo7zIKZgII5UFOkH8oQUmXtGSrPw4=
Received: by 10.216.21.211 with SMTP id r61mr2789002wer.211.1245161309383; 
	Tue, 16 Jun 2009 07:08:29 -0700 (PDT)
In-Reply-To: <81D77A49EF91FF4FB63E5EB32416330F7239A5@HKMGAXMB104A.zone1.scb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121682>

On Tue, Jun 16, 2009 at 15:54, Cannizzo, Fabio<Fabio.Cannizzo@sc.com> w=
rote:
>
> 1)
>
> I have a problem using qgit. As you can see from the screenshot below=
, when
> I select Working Dir, qgit shows all my files in the bottom right pan=
e.
>
> However, if I do git status from the command line, there are no modif=
ied
> files.
>


As you can see from the bottom LEFT pane, it seems git status returns
something. Actually in the bottom LEFT panel you see the output of
'git status' no more no less, and you can see the modified files are
the same on the two panels.


>
>
> 2) If I select by tree view, and select an individual file and that f=
ile has
> been renamed, on the right pane I will be able to see only the histor=
y up to
> the point where it was renamed. Is there a way to see the full histor=
y (i.e.
> equivalent to git =E2=80=93follow)?
>
>

To see history of a single file I suggest to use annotation in file
viewer. Simply double click on the file name in the TREE VIEW and the
file tab will open and file will be annotated. You will see the whole
file history, included renames.


>
> 3) I often encounter a bug. When I open a repo, after a while qgit cr=
ashes.
> It happens most of the time 5-10 seconds immediataly after I have ope=
ned the
> repo, and is quite random. Do you have any suggestion on how I could =
try to
> avoid it? I have tried to compress the repo, but it has no impact.
>
>

Is is possible for you to send me, directly, without passing from git
mailing list, the compressed repo (it is enough the zip of the .git
directory), but, please, only if it is not very big.

Alternatevly you can write me the link from where I can download the
zipped .git directory.
