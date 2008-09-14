From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Autosign newly created patches
Date: Sun, 14 Sep 2008 22:05:04 +0100
Message-ID: <b0943d9e0809141405u6e309f11q80edcfd59eb942dd@mail.gmail.com>
References: <20080912215515.10270.32667.stgit@localhost.localdomain>
	 <20080914083728.GB30664@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 23:06:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeynO-0003yj-Ah
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 23:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbYINVFH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 17:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754084AbYINVFG
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 17:05:06 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:28565 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbYINVFF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2008 17:05:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1848475rvb.1
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WArCjo5mjnrn7rdTLury01qAvJS7ti/GoII56z3HBvk=;
        b=xPBjLfDQ7gsE+57ZavwNf6QXjbmumYD+tVlnoQSTZY2fdmGM09yeuRKEXFOEKZYidM
         AYIX2i7jsqjBJdFqihzbiGhzZb/2bj5HhGzzGMSptrPQ5Q1YJ48wg6iXIMmYDsLRDKx3
         lq3cPL/f4bq9k92ZmOP8eUqQTKk5IzVzdTTYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gFYBhBwGmk+jcCRSptxZK/1IukzGPbKd9ys5zEcyKv0WJOQNKlHQjW7BnTGPskzF90
         PwD/tObl6n3uaOAXlVDRVUQfIG+sq37qGsRi3XpBTXoBpk/E7nv6cQO4XRRy19MXmNbN
         hn5gr+VHSXSAAeDtj8uAUavdzf5R0IaUndZHA=
Received: by 10.141.161.6 with SMTP id n6mr4286461rvo.41.1221426305055;
        Sun, 14 Sep 2008 14:05:05 -0700 (PDT)
Received: by 10.140.199.1 with HTTP; Sun, 14 Sep 2008 14:05:04 -0700 (PDT)
In-Reply-To: <20080914083728.GB30664@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95861>

2008/9/14 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-09-12 22:55:56 +0100, Catalin Marinas wrote:
>
>> This patch adds the autosign configuration variable which is checked
>> by the "new" command to automatically sign the patch message.
>
> Sounds useful. I have a sign-off command in my .emacs, but I expect
> this would be useful for those who don't.

I use emacs for writing code but not that much for stgit commands (I
prefer the shell).

>> BTW, what happened to the patchdescr.tmpl file? It doesn't seem to
>> be used anymore, however one can save a template file
>
> I don't know. I don't use it myself, so it's perfectly possible that
> I've broken it without noticing, seeing as there is no test suite
> coverage ...

There isn't a test but the command description suggests that
patchdesr.tmpl file will be used if present.

Should we keep this feature? The only case where I was using it was
for automatic signed-off-by line.

--=20
Catalin
