From: Eric Raible <raible@gmail.com>
Subject: Re: [msysgit? bug] crlf double-conversion on win32
Date: Wed, 14 Oct 2009 11:17:31 -0700
Message-ID: <279b37b20910141117s7980c249tab4565c93b389df3@mail.gmail.com>
References: <38cfaa83fdf80dec3a3d81ed3e0de0e2.squirrel@intranet.linagora.com>
	 <loom.20091014T001602-378@post.gmane.org>
	 <alpine.DEB.1.00.0910141601580.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:18:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My8Qq-0006HS-DD
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 20:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbZJNSSK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 14:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755872AbZJNSSJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 14:18:09 -0400
Received: from mail-vw0-f203.google.com ([209.85.212.203]:51071 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794AbZJNSSI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2009 14:18:08 -0400
Received: by vws41 with SMTP id 41so20756vws.4
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/s54j7g3MM4vsGmmzr9n+Nsqt/kUi+NYnTE7J20ZztM=;
        b=I8byLNr4KvR91jWos1za4+OS0z0SIpgElGwmnVIyGYJ9YEkhywUmBfqoUvb4U4s+gW
         o9ZehAkxPgCuEyqbNOsK5RFgxxFORFvRoCrTJl8wAEKT4rjvXeF6iAOtLL8JF64hV/+4
         mB9QaQBtSI2Og76CCElXor/9n66tnUFS6zSDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=A4KcZisLb0dMwsWdPdf4so7PULeEbMVby/Gsnbh2lN7NbK/EnB2Aak0kmsXcb5IR2m
         AeqoDlb3CDW4g8ZqAklVrR/oiyCNVhLtUVI/SuL0KDX6qQ9OUM044m5bTeJlgABp3OG2
         hZ6zRGscYHPdiJSY9JifrexGzfEbLQxpVNEpc=
Received: by 10.220.70.73 with SMTP id c9mr7244784vcj.33.1255544251972; Wed, 
	14 Oct 2009 11:17:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910141601580.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130312>

On Wed, Oct 14, 2009 at 7:03 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 13 Oct 2009, Eric Raible wrote:
>
>>
>> See http://thread.gmane.org/gmane.comp.version-control.git/122823/fo=
cus=3D122862
>>
>> In which Junio suggests:
>> $ rm .git/index
>> $ git reset --hard
>>
>> in order to "restore sanity to your work tree"
>
> Of course this is insane as a user interface. =A0It is not even plumb=
ing.
>
> So I started some time ago to code a "git checkout --fix-crlf", but I
> am not really happy with the user interface. =A0I think that Git shou=
ld
> realize itself that something went wrong with the line endings. =A0If=
 I say
> "git reset --hard", it is just a bug in Git when it insists afterward=
s
> that the files are modified.

I fully agree that "git reset --hard" should actually, uh, do a hard re=
set,
as should be clear in the my reply to Junio's suggestion.  So I'm not
advocating "rm .git/index" as a good solution, but simply one that work=
s.
