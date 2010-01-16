From: Paul Richards <paul.richards@gmail.com>
Subject: Re: Stamp Git commit id into file during build process
Date: Sat, 16 Jan 2010 21:12:58 +0000
Message-ID: <a1138db31001161312i2c032c38tcc0fb162c61fbb35@mail.gmail.com>
References: <a1138db31001161050i73eade1bif968ca1256dcef2c@mail.gmail.com>
	 <m3d419desd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 22:13:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWFxF-00066L-Lt
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 22:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab0APVNA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 16:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895Ab0APVNA
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 16:13:00 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:56435 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab0APVNA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jan 2010 16:13:00 -0500
Received: by ey-out-2122.google.com with SMTP id d26so375774eyd.19
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 13:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ydbYEu0rzVpxQ5uxYlG/YnUTvvMjR8Btn6H3WUgRof8=;
        b=k+lDVCe4tMT2dXcojJPV3hFZ35gHPbq2aA+Ac5dvp1LGhr9mXfJ0eHRq4b3PpOFSBy
         XOOfbBvS/2O9Xzwjr+TT98a0F+3LBvp4Ryu8/baSxtO46OwNuiOXXFn3Nsn3TRGa9sZs
         g2ftUXklb04RvNKXgmfkRzn1p8KNljc7wqA6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B5B7ubhED5gQoTG+XcQqWKcwQQ9890jbxJdoHJju4XEnM5ZMD35GZILSuMTN/sETkR
         mGX9Pu6m+OH8Qvd82pxktivBHIcWLgs4LFYpbBr7EO84MruH8CBpkN7mAyaDFsRKZ9Sh
         XgukFPQiW5zCJmzP40NL3/6rBNamDAvhYQa3I=
Received: by 10.213.50.140 with SMTP id z12mr1509877ebf.89.1263676378140; Sat, 
	16 Jan 2010 13:12:58 -0800 (PST)
In-Reply-To: <m3d419desd.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137258>

2010/1/16 Jakub Narebski <jnareb@gmail.com>:
> Paul Richards <paul.richards@gmail.com> writes:
>
>> Hi,
>> I am in the process of migrating from Subversion to Git. =C2=A0One t=
hing I
>> am unsure of is how to stamp the 'version' or 'commit id' into a fil=
e
>> as part of a build process.
>>
>> With subversion I used the SubWCRev tool from TortoiseSVN
>> (http://tortoisesvn.net/docs/release/TortoiseSVN_en/tsvn-subwcrev.ht=
ml).
>>
>> With Git I imagine that I'd like to put a copy of the current commit
>> id (either the full hash or a truncated version of that) into a file
>> which then gets included into the program source code in some way.
>>
>> Is there a recommended way of doing this with git? =C2=A0Perhaps wit=
h
>> something similar to SubWCRev?
>>
>> Currently I am thinking about using "git log", and grepping the outp=
ut
>> in some way so that I just get the hash.
>
> Not "git log".
>
> Take a look how for example git project and Linux kernel use "git des=
cribe"
> in GIT-VERSION-GEN script, and how they use GIT-VERSION-GEN script in=
 the
> Makefile.
>


Thanks, it appears though that "git describe" does not work in Cygwin g=
it. :(


--=20
Paul Richards
