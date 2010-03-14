From: Kris Shannon <kris@shannon.id.au>
Subject: Re: re-running merge on a single file
Date: Sun, 14 Mar 2010 23:24:39 +1100
Message-ID: <e51f4f551003140524r18546bd6i202f1b886de9d7a9@mail.gmail.com>
References: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>
	 <a038bef51003111408g38698837ldcf1d0f5995f4f30@mail.gmail.com>
	 <m3hbomla3u.fsf@localhost.localdomain>
	 <a038bef51003111631n38f7e50cp79d8335109f3ed0@mail.gmail.com>
	 <a038bef51003111633v5d5d418bu332b63bb3874e3ef@mail.gmail.com>
	 <4B99E309.2070603@viscovery.net>
	 <7viq92rpsr.fsf@alter.siamese.dyndns.org>
	 <a038bef51003121216l5c0a4942qabc3d12741c9030e@mail.gmail.com>
	 <7v3a05p29w.fsf@alter.siamese.dyndns.org>
	 <a038bef51003121543t52a864ddlab345dd1bcf6c906@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 13:24:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqmsC-0003Fq-Oi
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 13:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298Ab0CNMYm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Mar 2010 08:24:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40922 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0CNMYl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Mar 2010 08:24:41 -0400
Received: by wyb38 with SMTP id 38so1126894wyb.19
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 05:24:39 -0700 (PDT)
Received: by 10.216.90.17 with SMTP id d17mr414940wef.175.1268569479494; Sun, 
	14 Mar 2010 05:24:39 -0700 (PDT)
In-Reply-To: <a038bef51003121543t52a864ddlab345dd1bcf6c906@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142135>

On 13 March 2010 10:43, Chris Packham <judge.packham@gmail.com> wrote:
> On Fri, Mar 12, 2010 at 3:07 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> =C2=A0(3) If you have rerere enabled, then the conflicts would be al=
ready
>> =C2=A0 =C2=A0 resolved in your working tree at this point, but not i=
n the index, so
>> =C2=A0 =C2=A0 you can reproduce the conflicted state with "checkout =
-m".
>
> Mental note: Need to learn more about git rerere. Sounds like what I
> need to do the job.
>

There is a script in the contrib directory written by Nanako Shiraishi =
called
rerere-train.sh which can be used to prime the rr-cache even if you did=
n't
have rerere enabled before you orginally did the merge.
