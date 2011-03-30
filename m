From: Computer Druid <computerdruid@gmail.com>
Subject: Re: error: cannot run hooks/pre-receive: No such file or directory
Date: Wed, 30 Mar 2011 14:35:11 -0400
Message-ID: <AANLkTimkVSL52Bhdhnu+OC8SWzfUJ7ZK0KBcydjG4wXT@mail.gmail.com>
References: <AANLkTinehsLJWYona7ONqquWpCZozr3hW-JNMhYz4Rvn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 20:35:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q50Eo-0001Fg-Gl
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 20:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710Ab1C3SfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2011 14:35:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33568 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778Ab1C3SfL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2011 14:35:11 -0400
Received: by iwn34 with SMTP id 34so1532358iwn.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4unfwauCkcFv4+xZLNVCX6kRcxE0poAWXZSUFyBW2Yw=;
        b=PAx2ntlKUJK5pA1N5EFcjcXWn+Jo0zCfe8P3xSX7V6MaPpPfiq4JHkSJcUEedPpTLz
         bRe8IoNyViZcrsBvb0W3XbdNKG/g6PrTbeX7LAF4Vy9TDofueQV98cvkUNL++cHxuHMv
         cjooepC++HCrc7rvwB0I9G4vRzhyvFjhGjEN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oTY/VFCsvw2CHyLVjJ+/ghe5/oNkAIMfqdkvtEwiH4r1cMh0H9YvAJdFwneTLazKT2
         fnN1dsju/wtFSLpPoN+FVimaHxLZPs0B89N5xn0hmNt/ZpBDyLbPc2C3S/8HQORw7INj
         cyu8NJAa5DIK7i0rkEHqhNa9cCOiG4gpDgTMw=
Received: by 10.42.130.198 with SMTP id w6mr1458161ics.496.1301510111197; Wed,
 30 Mar 2011 11:35:11 -0700 (PDT)
Received: by 10.231.179.165 with HTTP; Wed, 30 Mar 2011 11:35:11 -0700 (PDT)
In-Reply-To: <AANLkTinehsLJWYona7ONqquWpCZozr3hW-JNMhYz4Rvn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170401>

On Wed, Mar 30, 2011 at 9:27 AM, Mathieu Malaterre
<mathieu.malaterre@gmail.com> wrote:
> Hi all,
>
> =C2=A0I am trying to use a ruby script to reject commit with non-line=
ar
> history (*). However it keeps failing with the following message:
>
> $ git push
> Counting objects: 5, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (3/3), done.
> Writing objects: 100% (3/3), 304 bytes, done.
> Total 3 (delta 2), reused 0 (delta 0)
> error: cannot run hooks/pre-receive: No such file or directory
> To ssh://malat@gdcm.git.sourceforge.net/gitroot/gdcm/gdcm.old
> =C2=A0! [remote rejected] master -> master (pre-receive hook declined=
)
> error: failed to push some refs to
> 'ssh://malat@gdcm.git.sourceforge.net/gitroot/gdcm/gdcm.old'
>
> I tried with something as simple as :
>
> % cat pre-receive
> #!/usr/bin/ruby
> % which ruby
> /usr/bin/ruby
Check that hooks/pre-receive is executable? (chmod +x)
